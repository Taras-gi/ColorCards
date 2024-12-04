//
//  ColorCardsViewModel.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//


import UIKit
import CoreData
import ToastViewSwift

class ColorCardsViewModel {
    @Published var colorCodesArray:[ColorHex]?
    @Published var error:Bool?
    private var nonSyncedColorArray:[ColorHex]? = []
    private var isSyncRunning:Bool? = false
    
    func saveColorCodeToDataBase(hexCode:String){
        guard let colorDict = [Constant.CoreData.colorCode:hexCode,Constant.CoreData.isSynced:false,Constant.CoreData.timeStamp:Date()] as? [String:Any] else { return
            self.error = true
        }
        DispatchQueue.global(qos: .userInitiated).async {
            DataBaseStorage.shareInstance.save(object: colorDict) { isDataSaved in
                if isDataSaved {
                    self.retrieveColorCodeData()
                }else{
                    self.error = true
                }
            }
        }
    }
    
    func retrieveColorCodeData(){
        if let data = DataBaseStorage.shareInstance.getColorCodes(){
            self.colorCodesArray = data
            if !(self.isSyncRunning ?? false) {
                self.isSyncRunning = true
                self.syncPendindData(data:data)
            }
        }else{
            self.error = true
        }
    }
    
    func syncPendindData(data:[ColorHex]){
        self.nonSyncedColorArray = data.filter({!($0.isSynced)})
        guard let nonSyncedData = self.nonSyncedColorArray, !nonSyncedData.isEmpty else {
            self.isSyncRunning = false
            return
        }
        DispatchQueue.global(qos: .background).async {
            self.syncColorToFireBase(data:nonSyncedData)
        }
    }
    
    func syncColorToFireBase(data:[ColorHex]){
        let dispatchGroup = DispatchGroup()
        for (index,color) in data.enumerated() {
            dispatchGroup.enter()
            color.isSynced = true
            FireBaseService.shared.uploadColorHexToFirebase(colorHex: color) { isSynced in
                if isSynced {
                    self.updateColorToDataBase(index: index,data:data)
                }else{
                    self.error = true
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            if data.count > 1 {
                self.internetConnectivityPopUp(message: Constant.Alert.syncingDone)
            }
            self.isSyncRunning = false
            self.retrieveColorCodeData()
        }
    }
    
    func updateColorToDataBase(index:Int,data:[ColorHex]){
        let count = ((self.nonSyncedColorArray?.count ?? 0) -  1)
        guard index <= count else{return}
        if let index = data.firstIndex(where: {$0.colorCode == self.nonSyncedColorArray?[index].colorCode}) {
            let selectedColorData:ColorHex = data[index]
            guard let colorDict = [Constant.CoreData.colorCode:selectedColorData.colorCode ?? "",Constant.CoreData.isSynced:true,Constant.CoreData.timeStamp:selectedColorData.timeStamp ?? Date()] as? [String:Any] else {return}
            DataBaseStorage.shareInstance.updateData(object: colorDict, index: index)
        }
    }
    
    func internetConnectivityPopUp(message:String){
        DispatchQueue.main.async {
            let toast = Toast.text(message)
            toast.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8){
                toast.close()
            }
        }
    }
}
