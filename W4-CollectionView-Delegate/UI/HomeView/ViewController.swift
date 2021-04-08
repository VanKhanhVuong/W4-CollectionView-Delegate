//
//  ViewController.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 05/04/2021.
//

import UIKit
protocol ViewControllerDelegate: AnyObject {
    func getValueFruitArray(array: Array<Fruit>)
}

class ViewController: UIViewController {
    @IBOutlet weak var fruitListCollectionView: UICollectionView!
    var fruitArray: Array<Fruit> = Array()
    weak var delegate: ViewControllerDelegate?
    var index = IndexPath(item: 0, section: 0)
    
    var data = [Fruit(image: "🥝", name: "Kiwi", description: "Mô tả của Kiwi", amount: 0, price: 20.0, isShow: true, backgrourd: UIColor(red: 157/255, green: 172/255, blue: 87/255, alpha: 1)),
                Fruit(image: "🌶", name: "Ớt", description: "Mô tả của Ớt", amount: 0, price: 30.0, isShow: true, backgrourd: UIColor(red: 230/255, green: 70/255, blue: 63/255, alpha: 1)),
                Fruit(image: "🥑", name: "Bơ", description: "Mô tả của Bơ", amount: 0, price: 40.0, isShow: true, backgrourd: UIColor(red: 236/255, green: 235/255, blue: 133/255, alpha: 1)),
                Fruit(image: "🍑", name: "Đào", description: "Mô tả của Đào", amount: 0, price: 50.0, isShow: true, backgrourd: UIColor(red: 230/255, green: 154/255, blue: 94/255, alpha: 1)),
                Fruit(image: "🫐", name: "Việt Quất", description: "Mô tả của Việt Quất", amount: 0, price: 40.0, isShow: true, backgrourd: UIColor(red: 138/255, green: 178/255, blue: 228/255, alpha: 1)),
                Fruit(image: "🍒", name: "Chery", description: "Mô tả của Cherry", amount: 0, price: 30.0, isShow: true, backgrourd: UIColor(red: 210/255, green: 81/255, blue: 91/255, alpha: 1)),
                Fruit(image: "🍇", name: "Nho", description: "Mô tả của Nho", amount: 0, price: 20.0, isShow: true, backgrourd: UIColor(red: 153/255, green: 50/255, blue: 90/255, alpha: 1)),
                Fruit(image: "🍌", name: "Chuối", description: "Mô tả của Chuối", amount: 0, price: 10.0, isShow: true, backgrourd: UIColor(red: 236/255, green: 218/255, blue: 194/255, alpha: 1)),
                Fruit(image: "🍋", name: "Chanh", description: "Mô tả của Chanh", amount: 0, price: 5.0, isShow: true, backgrourd: UIColor(red: 249/255, green: 220/255, blue: 91/255, alpha: 1)),
                Fruit(image: "🍐", name: "Bưởi", description: "Mô tả của Bưởi", amount: 0, price: 20.0, isShow: true, backgrourd: UIColor(red: 170/255, green: 169/255, blue: 76/255, alpha: 1)),
                Fruit(image: "🍉", name: "Dưa hấu", description: "Dưa hấu", amount: 0, price: 30.0, isShow: true, backgrourd: UIColor(red: 216/255, green: 98/255, blue: 99/255, alpha: 1)),
                Fruit(image: "🌽", name: "Bắp", description: "Bắp", amount: 0, price: 70.0, isShow: true, backgrourd: UIColor(red: 243/255, green: 217/255, blue: 73/255, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
        setupNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataFruitList()
    }
    
    func reloadDataFruitList() {
        if (!self.fruitArray.isEmpty) {
            for i in 0..<data.count {
                for j in 0..<fruitArray.count {
                    if self.fruitArray[j].isShow == false {
                        fruitArray[j].amount = 0
                    }
                    if (data[i].name == fruitArray[j].name) {
                        if (data[i].amount != fruitArray[j].amount) {
                            data[i].amount = fruitArray[j].amount
                        }
                    }
                }
            }
            fruitListCollectionView.reloadData()
        }
    }
    
    func registerCollectionView(){
        fruitListCollectionView.register(MyCollectionViewCell.nib, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        fruitListCollectionView.delegate = self
        fruitListCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        fruitListCollectionView.collectionViewLayout = layout
    }
    
    func setupNavigationBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "bag"), style: .plain, target: self, action: #selector(handleFiler))
    }
    
    @objc func handleFiler() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyBoard.instantiateViewController(identifier: "DetailsView") as! DetailsViewController
        detailView.fruitArr = self.fruitArray
        detailView.delegate = self
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}


//MARK: - Extension
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        item.fruitNameLabel.text = data[indexPath.item].name
        item.imageFruitLabel.text = data[indexPath.item].image
        item.itemView.backgroundColor = data[indexPath.item].backgrourd
        item.priceFruitLabel.text = "\(data[indexPath.item].price)"
        item.fruitDescriptionLabel.text = data[indexPath.item].description
        item.amountFruitLabel.text = "\(data[indexPath.item].amount)"
        item.upButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        item.downButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
        item.delegate = self
        return item
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 45) / 2, height: collectionView.frame.height/2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}
extension ViewController: MyCollectionViewCellDelegate {
    func plusOrMinusButton(item: MyCollectionViewCell, calculation: Bool) {
        guard var amount = Int(item.amountFruitLabel.text!) else { return }
        guard let image:String = item.imageFruitLabel.text else { return  }
        guard let name:String = item.fruitNameLabel.text else { return  }
        guard let description:String = item.fruitDescriptionLabel.text else { return  }
        guard let price:Float = Float(item.priceFruitLabel.text!) else { return  }
        guard let backgrourd:UIColor = item.itemView.backgroundColor else { return  }
        
        if (calculation == true) {
            amount = amount + 1
            item.downButton.isHidden = false
        } else {
            if amount == 0 {
                amount = 0
            } else {
                amount = amount - 1
            }
        }
        item.amountFruitLabel.text = "\(amount)"
        for i in 0..<fruitArray.count {
            if fruitArray[i].image == item.imageFruitLabel.text{
                if (fruitArray[i].amount < amount) {
                    fruitArray[i].amount += 1
                    return
                } else if (fruitArray[i].amount) == amount {
                    return
                } else {
                    fruitArray[i].amount -= 1
                    return
                }
            }
        }
        fruitArray.append(Fruit(image: image, name: name, description: description, amount: amount, price: price, isShow: true, backgrourd: backgrourd))
    }
}
extension ViewController: DetailsViewControllerDelegate {
    func getValueFruitArray(array: Array<Fruit>, index: IndexPath) {
        self.fruitArray = []
        self.index = IndexPath(item: 0, section: 0)
        self.fruitArray = array
        self.index = index
    }
}



