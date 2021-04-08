//
//  FruitModels.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 05/04/2021.
//

import UIKit
import Foundation

struct Fruit {
    let image : String
    let name: String
    let description: String
    var amount : Int
    let price : Float
    var isShow : Bool
    let backgrourd: UIColor
        
    init(image :String, name: String, description: String, amount:Int, price:Float, isShow:Bool, backgrourd:UIColor) {
        self.image = image
        self.name = name
        self.description = description
        self.amount = amount
        self.price = price
        self.isShow = isShow
        self.backgrourd = backgrourd
    }
}
