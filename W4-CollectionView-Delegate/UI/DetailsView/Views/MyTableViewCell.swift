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
        self.upButton.coradiusButton(corner: .topRightBottomRight)
        self.downButton.coradiusButton(corner: .topLeftbottomLeft)
        self.cellLabelView.customCornerRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func touchUpButton(_ sender: Any) {
        self.amountLabel.text = "\(Int(self.amountLabel.text!)! + 1)"
        delegate?.plusOrMinusButton(cell: self, calculation: true)
    }
    @IBAction func touchDownButton(_ sender: Any) {
        let amount: String = "\(Int(self.amountLabel.text!)! - 1)"
        if ((Int(amount))! <= 0) {
            delegate?.plusOrMinusButton(cell: self, calculation: false)
        } else {
            delegate?.plusOrMinusButton(cell: self, calculation: false)
            self.amountLabel.text = amount
        }
        
    }
    
    
}
