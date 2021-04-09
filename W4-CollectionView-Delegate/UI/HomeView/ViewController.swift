//
//  ViewController.swift
//  W4-CollectionView-Delegate
//
//  Created by Văn Khánh Vương on 05/04/2021.
//

import UIKit
protocol ViewControllerDelegate: AnyObject {
    func pushValueFruitArray(array: [Fruit])
}

class ViewController: UIViewController {
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var fruitListCollectionView: UICollectionView!
    var fruitArray: [Fruit] = []
    var listDisplayArray: [Fruit] = []
    var checkbackViewHome: Bool = false
    weak var delegate: ViewControllerDelegate?
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataFruitList()
    }
    
    
    @IBAction func cardButton(_ sender: Any) {
        handleFiler()
    }
    
    func reloadDataFruitList() {
        if self.checkbackViewHome == true {
            self.listDisplayArray = self.fruitArray
            fruitListCollectionView.reloadData()
        }
    }
    
    func registerCollectionView(){
        // Lấy data tổng lấy đổ vào listDisplayArray để hiển thị
        self.listDisplayArray = self.data
        fruitListCollectionView.register(MyCollectionViewCell.nib, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        fruitListCollectionView.delegate = self
        fruitListCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        fruitListCollectionView.collectionViewLayout = layout
    }
    
    func cartCount() {
        // loc listDisplayArray[index].amount > 0  cho vào  listGioHang (Đếm list giỏ hang đẻ hiện label)
        var listGioHang: [Fruit] = []
        for i in 0..<self.listDisplayArray.count {
            if self.listDisplayArray[i].amount > 0 {
                listGioHang.append(self.listDisplayArray[i])
            }
        }
        // Hien thi Label trên trong gio hang XXX
        self.cartButton.setTitle("\(listGioHang.count)", for: .normal)
    }
    
    func handleFiler() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyBoard.instantiateViewController(identifier: "DetailsView") as! DetailsViewController
        detailView.data = self.listDisplayArray
        delegate?.pushValueFruitArray(array: self.listDisplayArray)
        detailView.delegate = self
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}


//MARK: - Extension
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listDisplayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        let model = self.listDisplayArray[indexPath.item]
        item.fruitNameLabel.text = model.name
        item.imageFruitLabel.text = model.image
        item.itemView.backgroundColor = model.backgrourd
        item.priceFruitLabel.text = "\(model.price)"
        item.fruitDescriptionLabel.text = model.description
        item.amountFruitLabel.text = "\(model.amount)"
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
        // Lấy index của item nhấn (+ -)
        guard let indexPath: IndexPath = fruitListCollectionView.indexPath(for: item) else { return }
        // Lấy thuộc tính model.amount
        guard let amountModel: Int = Int(item.amountFruitLabel.text!) else { return }
        // Khi thấy model.amount có thực hiện phép cộng hoặc trừ (calculation) ? true : false
        // Thì if check Nếu listDisplayArray có model.amount tại index đó có thay đổi  {
        //        Thì update model listdiplay
        if calculation == true {
            if self.listDisplayArray[indexPath.item].amount != amountModel {
                self.listDisplayArray[indexPath.item].amount = amountModel
            }
        } else {
            if amountModel == 0 {
                self.listDisplayArray[indexPath.item].amount = 0
            } else {
                if self.listDisplayArray[indexPath.item].amount != amountModel - 1{
                    self.listDisplayArray[indexPath.item].amount = self.listDisplayArray[indexPath.item].amount - 1
                }
            }
        }
        cartCount()
    }
}
extension ViewController: DetailsViewControllerDelegate {
    func getValueFruitArray(array: [Fruit], backViewHome: Bool, cartCount: Int) {
        if cartCount != 0 {
            self.cartButton.setTitle("\(cartCount)", for: .normal)
        }
        self.fruitArray = array
        self.checkbackViewHome = backViewHome
    }
}



