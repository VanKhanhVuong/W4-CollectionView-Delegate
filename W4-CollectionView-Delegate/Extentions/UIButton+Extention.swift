//
//  UIButton+Extention.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 08/04/2021.
//

import UIKit

enum CORNER {
    case topLeftbottomLeft
    case topRightBottomRight
    case topLeft
    case topRight
}

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

    func coradiusButton(corner: CORNER) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        // cornerRadius 4 goc
            //self.clipsToBounds = true
            //self.layer.cornerRadius = 12
        
        // cornerRadius tuy chinh
            // 1 Top Left .layerMinXMinYCorner
            // 2 Top Right .layerMaxXMinYCorner
            // 3 Bottom Left .layerMinXMaxYCorner
            // 4 Bottom Right .layerMaxXMaxYCorner
        switch corner {
        case .topLeftbottomLeft:
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            break
        case .topRightBottomRight:
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            break
        case .topLeft:
            self.layer.maskedCorners = .layerMinXMinYCorner
            break
        case .topRight:
            self.layer.maskedCorners = .layerMaxXMinYCorner
            break
        }
    }
}


