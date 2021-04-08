//
//  MyTableViewCell.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 05/04/2021.
//

import UIKit
protocol MyTableViewCellDelegate: AnyObject {
    func plusOrMinusButton(cell: MyTableViewCell, calculation: Bool)
}

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var fruitImageLabel: UILabel!
    @IBOutlet weak var nameFruitLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cellLabelView: UIView!
    weak var delegate: MyTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.downButton.customButtonCornerRadius(buttonName: "topLeftBottomLeft")
        self.upButton.customButtonCornerRadius(buttonName: "topRightBottomRight")
        self.cellLabelView.customCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func touchUpButton(_ sender: Any) {
        delegate?.plusOrMinusButton(cell: self, calculation: true)
    }
    @IBAction func touchDownButton(_ sender: Any) {
        delegate?.plusOrMinusButton(cell: self, calculation: false)
    }
    
    
}
