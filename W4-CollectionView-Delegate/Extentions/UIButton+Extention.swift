//
//  UIButton+Extention.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 08/04/2021.
//

import UIKit

extension UIButton {
    func effectButton() {
        self.backgroundColor = UIColor(red: 171/255, green: 178/255, blue: 186/255, alpha: 1.0)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }

    func customButtonCornerRadius(buttonName: String){
        // cornerRadius 4 goc
            //self.clipsToBounds = true
            //self.layer.cornerRadius = 12
        
        // cornerRadius tuy chinh
            // Top Left .layerMinXMinYCorner
            // Top Right .layerMaxXMinYCorner
            // Bottom Left .layerMinXMaxYCorner
            // Bottom Right .layerMaxXMaxYCorner
        
        //

        switch buttonName {
        case "topLeftBottomLeft":
            self.clipsToBounds = true
            self.layer.cornerRadius = 12
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            break
        case "topRightBottomRight" :
            self.clipsToBounds = true
            self.layer.cornerRadius = 12
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            break
        case "topLeft":
            self.clipsToBounds = true
            self.layer.cornerRadius = 12
            self.layer.maskedCorners = [.layerMinXMinYCorner]
            break
        case "topRight" :
            self.clipsToBounds = true
            self.layer.cornerRadius = 12
            self.layer.maskedCorners = .layerMaxXMinYCorner
            break
        default:
            self.clipsToBounds = true
            self.layer.cornerRadius = 12
        }
    }
}

