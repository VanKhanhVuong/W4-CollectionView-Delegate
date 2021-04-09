//
//  DetailsViewController.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 05/04/2021.
//

import UIKit
protocol DetailsViewControllerDelegate: AnyObject {
    func getValueFruitArray(array: [Fruit], backViewHome: Bool, cartCount: Int)
}

class DetailsViewController: UIViewController {
    @IBOutlet weak var fruitListTableView: UITableView!
    @IBOutlet weak var totalBillView: UIView!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    var data: [Fruit] = []
    var listDisplayArray: [Fruit] = []
    let identifier = "MyTableViewCell"
    var sumCartCount: Int = 0
    
    var indexPath = IndexPath(item: 0, section: 0)
    weak var delegate: DetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruitListTableView.delegate = self
        fruitListTableView.dataSource = self
        //buyButton.customButtonCornerRadius(buttonName: "")
        buyButton.effectButton()
        let nib = UINib(nibName: identifier, bundle: nil)
        fruitListTableView.register(nib, forCellReuseIdentifier: identifier)
        setupNavigationBarItems()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTotalBill()
    }
    
     //Filter ra những qua
    func setupData() {
        self.listDisplayArray = self.data
    }
    
    func setupNavigationBarItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
    }
    @objc func backAction() {
        delegate?.getValueFruitArray(array: self.listDisplayArray, backViewHome: true, cartCount: self.sumCartCount)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showTotalBill() {
        var billArray: [Double] = []
        for i in 0..<self.listDisplayArray.count {
            billArray.append(Double(listDisplayArray[i].price * Float(listDisplayArray[i].amount)))
        }
        let total = billArray.reduce(0.0, +)
        self.totalBillLabel.text = "$ \(total)"
    }
    func test(index: IndexPath) {
        var listGioHang: [Fruit] = []
        for i in 0..<self.listDisplayArray.count {
            if self.listDisplayArray[i].amount > 0 {
                listGioHang.append(self.listDisplayArray[i])
            }
        }
        self.sumCartCount = listGioHang.count
        // Hien thi Label trên trong gio hang XXX
        //self.cartButton.setTitle("\(listGioHang.count)", for: .normal)
    }

    func displaysWarningMessages(index: IndexPath, nameFruit: String) {
           let defaultAction = UIAlertAction(title: "Agree",
                                             style: .default) { [self] (action) in
            self.listDisplayArray[index.row].amount = 0
            test(index: index)
            showTotalBill()
            self.fruitListTableView.reloadData()
           }
           let cancelAction = UIAlertAction(title: "Disagree",
                                style: .cancel) { (action) in
            return
           }
           let alert = UIAlertController(title: "Wanning !",
                 message: "Click Agree to accept remove fruit " + nameFruit,
                 preferredStyle: .alert)
           alert.addAction(defaultAction)
           alert.addAction(cancelAction)
           self.present(alert, animated: true)
    }
}

extension DetailsViewController: UITableViewDelegate {
}
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDisplayArray.count
    }
    
    // Ẩn bớt những trái có amount = 0
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listDisplayArray[indexPath.row].amount == 0 {
            return 0
        }
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyTableViewCell
        cell.fruitImageLabel.text = listDisplayArray[indexPath.row].image
        cell.nameFruitLabel.text = listDisplayArray[indexPath.row].name
        cell.nameFruitLabel.textColor = listDisplayArray[indexPath.row].backgrourd
        cell.descriptionLabel.text = listDisplayArray[indexPath.row].description
        cell.priceLabel.text = "\(listDisplayArray[indexPath.row].price)"
        cell.amountLabel.text = "\(listDisplayArray[indexPath.row].amount)"
        cell.cellLabelView.backgroundColor = listDisplayArray[indexPath.row].backgrourd
        cell.delegate = self
        return cell
    }
}
extension DetailsViewController: MyTableViewCellDelegate {
    func plusOrMinusButton(cell: MyTableViewCell, calculation: Bool) {
        guard let indexPath: IndexPath = fruitListTableView.indexPath(for: cell) else { return }
        // Lấy thuộc tính model.amount
        guard let amountModel: Int = Int(cell.amountLabel.text!) else { return }
        if calculation == true {
            if self.listDisplayArray[indexPath.item].amount != amountModel {
                self.listDisplayArray[indexPath.item].amount = amountModel
                showTotalBill()
            }
        } else {
            if amountModel == 1 {
                // Khi amount đã = 1 mà ta bấm (-) nữa nên hiện message
                displaysWarningMessages(index: indexPath, nameFruit: self.listDisplayArray[indexPath.item].name)
            } else {
                if self.listDisplayArray[indexPath.item].amount != amountModel - 1{
                    self.listDisplayArray[indexPath.item].amount = amountModel - 1
                    showTotalBill()
                }
            }
        }
    }
}
extension DetailsViewController: ViewControllerDelegate {
    func pushValueFruitArray(array: [Fruit]) {
        print(array)
    }
}
