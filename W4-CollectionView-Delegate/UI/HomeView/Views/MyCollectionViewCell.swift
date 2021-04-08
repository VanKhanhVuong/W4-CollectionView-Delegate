//
//  MyCollectionViewCell.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 05/04/2021.
//

import UIKit
protocol MyCollectionViewCellDelegate: AnyObject {
    func plusOrMinusButton(item: MyCollectionViewCell, calculation: Bool)
}

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageFruitLabel: UILabel!
    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var priceFruitLabel: UILabel!
    @IBOutlet weak var fruitDescriptionLabel: UILabel!
    @IBOutlet weak var amountFruitLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var itemView: UIView!
    
    weak var background: UIView?
    weak var delegate: MyCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.upButton.customButtonCornerRadius(buttonName: "topLeft")
        self.downButton.customButtonCornerRadius(buttonName: "topRight")
        self.itemView.customCornerRadius()
    }

    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    @IBAction func touchUpButton(_ sender: Any) {
        delegate?.plusOrMinusButton(item: self, calculation: true)
    }
    @IBAction func touchDownButton(_ sender: Any) {
        delegate?.plusOrMinusButton(item: self, calculation: false)
    }
    
    
}
