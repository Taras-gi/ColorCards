//
//  ColorHexModel.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//


import Foundation

// A model class that represents ColorHex in a way that can be uploaded to Firestore
struct ColorHexModel {
    var colorCode: String?
    var timeStamp: Date?
    var isSynced: Bool?
    
    // Initialize from a Core Data ColorHex object
    init(from colorHex: ColorHex) {
        self.colorCode = colorHex.colorCode ?? ""
        self.timeStamp = colorHex.timeStamp ?? Date()
        self.isSynced = colorHex.isSynced
    }
    
    // Convert the model to a dictionary
    func toDictionary() -> [String: Any] {
        return [
            Constant.CoreData.colorCode: colorCode ?? "",
            Constant.CoreData.timeStamp: timeStamp ?? Date(),
            Constant.CoreData.isSynced : isSynced ?? true
        ]
    }
}

