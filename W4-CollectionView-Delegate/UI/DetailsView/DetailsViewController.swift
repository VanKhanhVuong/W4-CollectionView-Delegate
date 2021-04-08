//
//  DetailsViewController.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 05/04/2021.
//

import UIKit
protocol DetailsViewControllerDelegate: AnyObject {
    func getValueFruitArray(array: Array<Fruit>, index: IndexPath)
}

class DetailsViewController: UIViewController {
    @IBOutlet weak var fruitListTableView: UITableView!
    @IBOutlet weak var totalBillView: UIView!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    var fruitArr: Array<Fruit> = Array()
    let identifier = "MyTableViewCell"
    var checkRemoveItems: Bool = false
    var index = IndexPath(item: 0, section: 0)
    weak var delegate: DetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruitListTableView.delegate = self
        fruitListTableView.dataSource = self
        buyButton.customButtonCornerRadius(buttonName: "")
        buyButton.effectButton()
        let nib = UINib(nibName: identifier, bundle: nil)
        fruitListTableView.register(nib, forCellReuseIdentifier: identifier)
        setupNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTotalBill()
    }
    
    func setupNavigationBarItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
    }
    @objc func backAction() {
        delegate?.getValueFruitArray(array: self.fruitArr, index: self.index)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showTotalBill() {
        var billArray: [Double] = []
        for i in 0..<self.fruitArr.count {
            billArray.append(Double(fruitArr[i].price * Float(fruitArr[i].amount)))
        }
        let total = billArray.reduce(0.0, +)
        self.totalBillLabel.text = "$ \(total)"
    }
    
    func reloadData() -> Array<Fruit>{
        var fruitListArr: Array<Fruit> = []
        fruitListArr = self.fruitArr
        for i in 0..<self.fruitArr.count {
            if (fruitArr[i].isShow == false) {
                fruitListArr.remove(at: i)
            }
        }
        return fruitListArr
    }
    
    func checkRemoveItem() {
        if self.checkRemoveItems == true {
            self.fruitArr = reloadData()
        }
    }
    
    func displaysWarningMessages(index: IndexPath, nameFruit: String) {
        self.index = index
           let defaultAction = UIAlertAction(title: "Agree",
                                style: .default) { (action) in
            self.fruitArr[index.row].isShow = false
            self.fruitArr[index.row].amount = 0
            self.fruitArr.remove(at: index.row)
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
        checkRemoveItem()
        return self.fruitArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyTableViewCell
        checkRemoveItem()
        cell.fruitImageLabel.text = fruitArr[indexPath.row].image
        cell.nameFruitLabel.text = fruitArr[indexPath.row].name
        cell.nameFruitLabel.textColor = fruitArr[indexPath.row].backgrourd
        cell.descriptionLabel.text = fruitArr[indexPath.row].description
        cell.priceLabel.text = "\(fruitArr[indexPath.row].price)"
        cell.amountLabel.text = "\(fruitArr[indexPath.row].amount)"
        cell.cellLabelView.backgroundColor = fruitArr[indexPath.row].backgrourd
        cell.delegate = self
        return cell
    }
}
extension DetailsViewController: MyTableViewCellDelegate {
    func plusOrMinusButton(cell: MyTableViewCell, calculation: Bool) {
        guard var amount = Int(cell.amountLabel.text!) else { return }
        guard let indexPathFruit: IndexPath = fruitListTableView.indexPath(for: cell) else { return }
        guard let fruitName: String = cell.nameFruitLabel.text else { return }
        if (calculation == true) {
            amount = amount + 1
            cell.downButton.isHidden = false
        } else {
            if amount == 0 {
                amount = 0
                displaysWarningMessages(index: indexPathFruit, nameFruit: fruitName)
                cell.downButton.isHidden = true
            } else {
                amount = amount - 1
            }
            cell.downButton.isHidden = false
        }
        cell.amountLabel.text = "\(amount)"
        for i in 0..<fruitArr.count {
            if fruitArr[i].image == cell.fruitImageLabel.text{
                if (Int(fruitArr[i].amount) < amount) {
                    fruitArr[i].amount += 1
                    showTotalBill()
                    return
                } else if (Int(fruitArr[i].amount) == amount) {
                    showTotalBill()
                    return
                } else {
                    fruitArr[i].amount -= 1
                    self.checkRemoveItems = true
                    showTotalBill()
                    return
                }
            }
        }
    }
}

