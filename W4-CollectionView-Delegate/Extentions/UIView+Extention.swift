//
//  UIView+Extention.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 08/04/2021.
//

import UIKit

extension UIView {
    func customCornerRadius()  {
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }
}


