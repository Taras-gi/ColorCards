//
//  ColorCardsCollectionViewCell.swift
//  ColorCards
//
//  Created by Suraj Bhatt on 03/12/24.
//

import UIKit

class ColorCardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hextColorView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.hextColorView.clipsToBounds = true
        self.hextColorView.layer.cornerRadius = 10
    }
    
    func setData(hexColor:ColorHex?){
        if let color = UIColor.fromHex(hexColor?.colorCode ?? "") {
            self.hextColorView.backgroundColor = color
        } else {
            print(Constant.Alert.invalidHex)
        }
    }
}
