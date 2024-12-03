//
//  Constant.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//


import CoreData
import UIKit

enum Constant {
    enum CellIdentifier {
        static let identifier = "ColorCardsCollectionViewCell"
    }
    
    enum Alert {
        static let invalidHex     = "Invalid hex color code."
        static let noInternet     = "You’re offline !!!"
        static let notifier       = "Unable to start notifier"
        static let internetBack   = "You’re back online. Syncing data..."
        static let internetGone   = "You’re offline !!!"
        static let syncingDone    = "Data synced successfully."
    }
    
    enum CoreData {
        static let entityName    = "ColorHex"
        static let colorCode     = "colorCode"
        static let timeStamp     = "timeStamp"
        static let isSynced      = "isSynced"
        static let dataNotFound  = "Did not found data"
        static let notGetData    = "Do not get data"
        static let dataNotEdited = "Data not edited"
    }
    
    enum NotificationCentre {
      static let notificationName = "networkStatusChanged"
    }
}
