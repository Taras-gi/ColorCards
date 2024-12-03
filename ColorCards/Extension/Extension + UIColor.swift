//
//  Extension + UIColor.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//

import Foundation
import UIKit

extension UIColor {
    static func fromHex(_ hex: String) -> UIColor? {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedHex.hasPrefix("#") {
            cleanedHex.removeFirst()
        }

        guard cleanedHex.count == 6, let hexValue = Int(cleanedHex, radix: 16) else {
            return nil
        }

        let red = CGFloat((hexValue >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexValue >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hexValue & 0xFF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}



