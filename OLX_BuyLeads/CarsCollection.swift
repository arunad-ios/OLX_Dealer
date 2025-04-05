//
//  CarsCollection.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 03/04/25.
//

import Foundation
import UIKit

class CarsCollection : UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"

    let titleLabel = UILabel()
    let chatBtn = UIButton()
    let deleteBtn = UIButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
      
        // Checkbox
       
        chatBtn.translatesAutoresizingMaskIntoConstraints = false
      
        let image = UIImage(named: "chat", in: .buyLeadsBundle, compatibleWith: nil)
        chatBtn.setImage(image, for: .normal)
        deleteBtn.setImage(UIImage(named: "delete", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.black
        // Label
               
               // Create StackView
        let stackView = UIStackView(arrangedSubviews: [titleLabel, chatBtn, deleteBtn])
        stackView.axis = .horizontal // Horizontal layout
        stackView.spacing = 10        // Space between items
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
               
               // Add StackView to the View
        contentView.addSubview(stackView)
               
        NSLayoutConstraint.activate([
            chatBtn.widthAnchor.constraint(equalToConstant: 25),
            chatBtn.heightAnchor.constraint(equalToConstant: 25),
            deleteBtn.widthAnchor.constraint(equalToConstant: 25),
            deleteBtn.heightAnchor.constraint(equalToConstant: 25)
            ])
               // Constraints
               NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                   stackView.widthAnchor.constraint(equalToConstant: 300),
                   stackView.heightAnchor.constraint(equalToConstant: 30)
               ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
