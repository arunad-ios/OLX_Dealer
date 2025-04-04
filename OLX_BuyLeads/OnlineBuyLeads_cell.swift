//
//  OnlineBuyLeads_cell.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 01/04/25.
//

import Foundation
import UIKit

protocol TableCellDelegate: AnyObject {
    func collectionViewCellDidSelect(item: String)
}

class OnlineBuyLeads_cell : UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    weak var delegate: TableCellDelegate?  // ✅ Delegate Reference

    var cars: [Any] = [] {
           didSet {
               collectionView.reloadData()
               collectionView.layoutIfNeeded()
               updateCollectionViewHeight()
           }
       }
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
//UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0)
        // Name Label
        nameLabel.font = UIFont(name: "Roboto-Regular", size: 16)
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
        dateLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        dateLabel.numberOfLines = 0
        dateLabel.textColor =  UIColor.black

        // Visited Label
        visitedLabel.text = "VISITED"
        visitedLabel.font = UIFont(name: "Roboto-Bold", size: 12)
        visitedLabel.textColor = .systemGreen
        visitedLabel.textAlignment = .right

        
        let visibleStackView = UIStackView(arrangedSubviews: [statusLabel,visitedLabel])
        visibleStackView.axis = .horizontal
        visibleStackView.alignment = .center
        visibleStackView.distribution = .fillProportionally
        visibleStackView.spacing = 10
        visibleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Separator
        separatorView.backgroundColor = .lightGray

        // Car Label
        carLabel.font = UIFont.systemFont(ofSize: 14)
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
        bottomView.backgroundColor = .systemGray6
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        

        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            cellseparatorView.heightAnchor.constraint(equalToConstant: 20),
            // Only one height constraint
            ])
      
        
        chatBtn = createButton(title: "sms", color: UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0))
        editBtn = createButton(title: "edit", color: UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0))
        deleteBtn = createButton(title: "download", color: UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0))
             
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
        bottomstackView.backgroundColor = .systemGray6
             
        bottomView.addSubview(bottomstackView)
        
        bottomView.isUserInteractionEnabled = true
        
      NSLayoutConstraint.activate([
       label1.widthAnchor.constraint(equalToConstant: 1),
       label2.widthAnchor.constraint(equalToConstant: 1),
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
        stackView.spacing = 0
        contentView.addSubview(stackView)
        stackView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
           nameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),
         //  phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
           // statusLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
        //    dateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
           // visitedLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),

            separatorView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            bottomstackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            // Only one height constraint
            ])
       

        stackView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            separatorView.heightAnchor.constraint(equalToConstant: 1),
           // visitedLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.isUserInteractionEnabled = true
    }

    func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        if let bundlePath = Bundle(for: OnlineBuyLeads.self).resourcePath {
            print("✅ Framework Bundle Path: \(bundlePath)")

            do {
                let files = try FileManager.default.contentsOfDirectory(atPath: bundlePath)
                print("📂 Bundle Contents: \(files)")
            } catch {
                print("❌ Error reading bundle contents: \(error)")
            }
        }
        print(Bundle.allBundles)
        if let bundleURL = Bundle(for: OnlineBuyLeads_cell.self).url(forResource: "OLX_BuyLeads", withExtension: "bundle"),
           let resourceBundle = Bundle(url: bundleURL) {
            let image = UIImage(named: title, in: resourceBundle, compatibleWith: nil)
            button.setImage(image, for: .normal)
        }
        else{
            button.setImage(UIImage(named: title), for: .normal)
          //  button.setTitle(title, for: .normal)
           // button.backgroundColor = color
        }
        button.isUserInteractionEnabled = true
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12)
          button.setTitleColor(UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0), for: .normal)
          button.layer.cornerRadius = 10
          button.translatesAutoresizingMaskIntoConstraints = false
          button.widthAnchor.constraint(equalToConstant: 50).isActive = true
          button.heightAnchor.constraint(equalToConstant: 25).isActive = true
          return button
      }
      
      // Helper Function to Create Labels
      func createLabel(text: String) -> UILabel {
          let label = UILabel()
          label.text = text
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
      //  carLabel.text = cars
        phoneLabel.text = ""
        self.cars = cars
        self.collectionView.reloadData()
        self.updateCollectionViewHeight()
        if(phonenumber.count != 0){
            let coloredText = NSMutableAttributedString(string: "\(name)(\(phonenumber))")
            // 3️⃣ Apply Color to Part of the Text
            coloredText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: name.count)) // "Hello" in blue
            coloredText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: name.count, length: phonenumber.count+2))  // "Swift" in red
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
        delegate?.collectionViewCellDidSelect(item: NSString(format: "%@", selectedItem["adId"] as! CVarArg) as String)
    }
    // MARK: - UICollectionView Delegate FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.size.width, height: 25)
    }
}

