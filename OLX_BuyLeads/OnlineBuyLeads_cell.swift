//
//  OnlineBuyLeads_cell.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 01/04/25.
//

import Foundation
import UIKit

protocol TableCellDelegate: AnyObject {
    func chatwithDealer(item: String)
    func deleteCar(item: [String:Any],tag : Int)

}

class OnlineBuyLeads_cell : UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    weak var delegate: TableCellDelegate?  // ✅ Delegate Reference

    var cars: [Any] = []
    let phoneLabel = UILabel()
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let dateLabel = UILabel()
    let visitedLabel = UILabel()
    let separatorView = UIView()
    let carLabel = UILabel()
    public var chatBtn = UIButton()
    public var editBtn = UIButton()
    public var deleteBtn = UIButton()
    let status_category = UIButton(type: .system)

    var heightconstaint =  NSLayoutConstraint()
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Scroll horizontally
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let bottomView: UIView = {
          let view = UIView()
          view.backgroundColor = UIColor.systemGray6
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
      }()
    
    private let cellseparatorView: UIView = {
          let view = UIView()
          view.backgroundColor = UIColor.clear
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
      }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
//OLXBlueColor
        // Name Label
        nameLabel.font = UIFont(name: "Roboto-Medium", size: 15)
        nameLabel.textColor =  UIColor.black
        nameLabel.numberOfLines = 0
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        // Name Label
        phoneLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        phoneLabel.textColor =  .systemBlue
        phoneLabel.numberOfLines = 0
        phoneLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

      

     
        
        
        
        // Status Label
        statusLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        statusLabel.textColor =   UIColor.black
        statusLabel.numberOfLines = 1
        
        // Date Label
        dateLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        dateLabel.numberOfLines = 0
        dateLabel.textColor =  UIColor.black

        // Visited Label
        visitedLabel.text = "VISITED"
        visitedLabel.font = UIFont(name: "Roboto-Medium", size: 15)
        visitedLabel.textColor = .systemGreen
        visitedLabel.textAlignment = .right

        
        let visibleStackView = UIStackView(arrangedSubviews: [statusLabel,visitedLabel])
        visibleStackView.axis = .horizontal
        visibleStackView.alignment = .center
        visibleStackView.distribution = .fillProportionally
        visibleStackView.spacing = 2
        visibleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Separator
        separatorView.backgroundColor = .lightGray

        // Car Label
        carLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        carLabel.textColor =  UIColor.black
        carLabel.numberOfLines = 0
        
        
        //collectionView
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarsCollection.self, forCellWithReuseIdentifier: CarsCollection.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        heightconstaint = collectionView.heightAnchor.constraint(equalToConstant: 100)
        heightconstaint.isActive = true

        
        //bottom View
        bottomView.backgroundColor =  UIColor(red: 216/255, green: 219/255, blue: 224/255, alpha: 1.0)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.isUserInteractionEnabled = true
     

        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            cellseparatorView.heightAnchor.constraint(equalToConstant: 20),
            // Only one height constraint
            ])
      
        
           chatBtn = createButton(title: "sms", color: UIColor.OLXBlueColor)
           editBtn = createButton(title: "edit", color: UIColor.OLXBlueColor)
           deleteBtn = createButton(title: "download", color: UIColor.OLXBlueColor)
             
             // Create Labels
             let label1 = createLabel(text: "Label 1")
             let label2 = createLabel(text: "Label 2")
             let label3 = createLabel(text: "Label 1")
             let label4 = createLabel(text: "Label 2")
   
   
             // Add Stack View
        let bottomstackView = UIStackView(arrangedSubviews: [label3, chatBtn, label1, editBtn, label2, deleteBtn,label4])
        bottomstackView.axis = .horizontal
        bottomstackView.alignment = .center
        bottomstackView.distribution = .equalSpacing
        bottomstackView.spacing = 10
        bottomstackView.translatesAutoresizingMaskIntoConstraints = false
             
        bottomView.addSubview(bottomstackView)
        
        bottomstackView.layer.cornerRadius = 12
        bottomstackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomstackView.layer.masksToBounds = true
        bottomstackView.backgroundColor =   UIColor(red: 216/255, green: 219/255, blue: 224/255, alpha: 1.0)

        
        bottomView.isUserInteractionEnabled = true
        
      NSLayoutConstraint.activate([
       label1.widthAnchor.constraint(equalToConstant: 1),
       label2.widthAnchor.constraint(equalToConstant: 1),
       label1.heightAnchor.constraint(equalToConstant: 46),
       label2.heightAnchor.constraint(equalToConstant: 46),
       label3.widthAnchor.constraint(equalToConstant: 0),
       label4.widthAnchor.constraint(equalToConstant: 0),
       // Only one height constraint
       ])
        
        NSLayoutConstraint.activate([
            bottomstackView.heightAnchor.constraint(equalToConstant: 50), // Only one height constraint
            visibleStackView.heightAnchor.constraint(equalToConstant: 35) // Only one height constraint
               ])
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, visibleStackView, separatorView,dateLabel,collectionView,carLabel,bottomstackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        contentView.addSubview(stackView)
        stackView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
             nameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),
             nameLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10),
            separatorView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            bottomstackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
             visitedLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: -5)
            // Only one height constraint
            ])
       

        stackView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
           // visitedLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
//        stackView.backgroundColor = .white
//        stackView.layer.cornerRadius = 10
//        stackView.layer.masksToBounds = true
//        stackView.isUserInteractionEnabled = true
        
        stackView.layer.cornerRadius = 12
        stackView.layer.shadowColor = UIColor.darkGray.cgColor
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stackView.layer.shadowRadius = 4
        stackView.layer.masksToBounds = false
        stackView.backgroundColor = .white
        
        status_category.setTitle("", for: .normal)
        status_category.translatesAutoresizingMaskIntoConstraints = false
        status_category.setTitleColor(.white, for: .normal)
        status_category.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 12)
        contentView.addSubview(status_category)
        status_category.contentHorizontalAlignment = .center

        contentView.bringSubviewToFront(status_category)
        
        NSLayoutConstraint.activate([
            status_category.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            status_category.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            status_category.widthAnchor.constraint(equalToConstant: 75),
            status_category.heightAnchor.constraint(equalToConstant: 45)
               ])
    }

    func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        let image = UIImage(named: title, in: .buyLeadsBundle, compatibleWith: nil)
        button.setImage(image, for: .normal)
        button.isUserInteractionEnabled = true
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12)
        button.setTitleColor(UIColor.OLXBlueColor, for: .normal)
          button.layer.cornerRadius = 10
          button.translatesAutoresizingMaskIntoConstraints = false
          button.widthAnchor.constraint(equalToConstant: 50).isActive = true
          button.heightAnchor.constraint(equalToConstant: 25).isActive = true
          return button
      }
      
      // Helper Function to Create Labels
      func createLabel(text: String) -> UILabel {
          let label = UILabel()
          label.text = " "
          label.backgroundColor = .white
          label.textAlignment = .center
          label.textColor = .black
          label.font = UIFont(name: "Roboto-Bold", size: 14)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }
    func configure(name: String, status: String, date: String, cars:  [Any] ,phonenumber : String) {
        nameLabel.text = "\(name)(\(phonenumber))"
        statusLabel.text = status
        dateLabel.text =  "Inquired Cars"
        dateLabel.textColor = .black
      //  carLabel.text = cars
        phoneLabel.text = ""
        self.cars = cars
        self.collectionView.reloadData()
        self.updateCollectionViewHeight()
        if(phonenumber.count != 0){
            let coloredText = NSMutableAttributedString(string: "\(name) (\(phonenumber))")
            // 3️⃣ Apply Color to Part of the Text
            coloredText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: name.count)) // "Hello" in blue
            coloredText.addAttribute(.foregroundColor, value: UIColor(red: 33.0/255.0, green: 44.0/255.0, blue: 243.0/255.0, alpha: 1.0), range: NSRange(location: name.count+1, length: phonenumber.count+2))  // "Swift" in red
            nameLabel.attributedText = coloredText
        }
    }
    func updateCollectionViewHeight() {
          collectionView.layoutIfNeeded()
          heightconstaint.constant = collectionView.contentSize.height
          superview?.layoutIfNeeded() // Refresh parent tableView
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarsCollection.identifier, for: indexPath) as! CarsCollection
        let dic = cars[indexPath.item] as! NSDictionary
        print((dic["make"] as! String))
        cell.configure(title: "\((dic["make"] as! String))")
        cell.chatBtn.tag = indexPath.row
        cell.chatBtn.addTarget(self, action: #selector(chatFunction), for: .touchUpInside)
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteCar), for: .touchUpInside)
        if(self.cars.count > 1){
            cell.deleteBtn.alpha = 1.0
        }
        else{
            cell.deleteBtn.alpha = 0.0
        }
        return cell
    }
    @objc func chatFunction(sender : UIButton){
        let selectedItem = cars[sender.tag] as! NSDictionary
        delegate?.chatwithDealer(item: NSString(format: "%@", selectedItem["adId"] as! CVarArg) as String)
    }
    @objc func deleteCar(sender : UIButton)
    {
        let selectedItem = cars[sender.tag] as! [String:Any]
        delegate?.deleteCar(item: selectedItem,tag: collectionView.tag)
    }
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.size.width, height: 25)
    }
}

extension Bundle {
    public static var buyLeadsBundle: Bundle {
        return Bundle(for: OnlineBuyLeads.self)
    }
}
