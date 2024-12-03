//
//  NetworkManager.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//

import Reachability

class NetworkManager {
    static let shared = NetworkManager()
    private let reachability = try! Reachability()
    
    // Notification names
    static let networkStatusChangedNotification = Notification.Name(Constant.NotificationCentre.notificationName)
    
    private init() {
        setupReachability()
    }
    
    private func setupReachability() {
        reachability.whenReachable = { _ in
            NotificationCenter.default.post(name: NetworkManager.networkStatusChangedNotification, object: true)
        }
        reachability.whenUnreachable = { _ in
            NotificationCenter.default.post(name: NetworkManager.networkStatusChangedNotification, object: false)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print(Constant.Alert.notifier)
        }
    }
    
    func stopNotifier() {
        reachability.stopNotifier()
    }
    
    func isInternetAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
}
