//
//  CireDataManager.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//

import Foundation
import UIKit
import CoreData

class DataBaseStorage {
    static var shareInstance = DataBaseStorage()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    // MARK:   Create the data
    func save(object:[String:Any],completion:@escaping(Bool) -> Void){
        let colorHex = NSEntityDescription.insertNewObject(forEntityName: Constant.CoreData.entityName, into: context!) as! ColorHex
        colorHex.colorCode = object[Constant.CoreData.colorCode] as? String
        colorHex.isSynced = object[Constant.CoreData.isSynced] as? Bool ?? false
        colorHex.timeStamp = object[Constant.CoreData.timeStamp] as? Date
        print(colorHex)
        do {
            try context?.save()
            completion(true)
        } catch  {
            print(Constant.CoreData.dataNotFound)
            completion(false)
        }
        
    }
    
    // MARK: Retrieving the data
    func getColorCodes() -> [ColorHex]? {
        var array = [ColorHex]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constant.CoreData.entityName)
        do {
            array = try context?.fetch(fetchRequest) as! [ColorHex]
        } catch  {
            print(Constant.CoreData.notGetData)
        }
        return array
    }
    
    // MARK: Update the data
    func updateData(object:[String:Any],index:Int) {
        let array = getColorCodes()
        array?[index].colorCode = array?[index].colorCode
        array?[index].isSynced = true
        array?[index].timeStamp = array?[index].timeStamp
        do {
            try context?.save()
        } catch  {
            print(Constant.CoreData.dataNotEdited)
        }
    }
}


