//
//  Extension + UIViewController.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//

import UIKit
import ToastViewSwift

extension UIViewController {
    func generateRandomHexColor() -> String? {
        return String(format: "#%06X", Int.random(in: 0...0xFFFFFF))
    }
    
    func internetConnectivityPopUp(message:String){
        DispatchQueue.main.async {
            let toast = Toast.text(message)
            toast.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                toast.close()
            }
        }
    }
}
