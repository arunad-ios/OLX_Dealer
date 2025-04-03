//
//  CarsCollection.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 03/04/25.
//

import Foundation
import UIKit

class CarsCollection : UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"

    let titleLabel = UILabel()
    let chatBtn = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
      
        // Checkbox
        chatBtn.backgroundColor = .clear
        chatBtn.layer.borderWidth = 1
        chatBtn.layer.borderColor = UIColor.darkGray.cgColor
        chatBtn.translatesAutoresizingMaskIntoConstraints = false
        
        if let bundlePath = Bundle(for: CarsCollection.self).path(forResource: "OLX_BuyLeads", ofType: "bundle"),
           let resourceBundle = Bundle(path: bundlePath) {
            let image = UIImage(named: "think", in: resourceBundle, compatibleWith: nil)
            chatBtn.setImage(image, for: .normal)
        }
        
        // Label
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(chatBtn)

        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            chatBtn.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            chatBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chatBtn.widthAnchor.constraint(equalToConstant: 20),
            chatBtn.heightAnchor.constraint(equalToConstant: 20)
         
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
