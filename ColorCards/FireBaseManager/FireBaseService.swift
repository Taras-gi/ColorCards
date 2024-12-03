//
//  FireBaseService.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//


import FirebaseFirestore
import CoreData
import ToastViewSwift

final class FireBaseService {
    
    private let db = Firestore.firestore()
    static let shared = FireBaseService()
    
    // Method to upload ColorHex object to Firebase
    func uploadColorHexToFirebase(colorHex: ColorHex,completion:@escaping (Bool)->Void) {
        let colorHexModel = ColorHexModel(from: colorHex)
        let docRef = db.collection(Constant.CoreData.entityName).document()
        docRef.setData(colorHexModel.toDictionary()) { error in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
