//
//  CollectionViewCell.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 27/03/25.
//

import Foundation
import UIKit

protocol CollectionCellDelegate: AnyObject {
    func didTapButton(in cell: CollectionViewCell)
}

public class CollectionViewCell : UICollectionViewCell {
   
    weak var delegate: CollectionCellDelegate? // Delegate property
    static let identifier = "CollectionViewCell"
    
    @IBOutlet var myLabel: UILabel! = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    @IBOutlet var myButton: UIButton! = {
        let button = UIButton(type: .custom)
        if let image = UIImage(named: "uncheck.svg") {
            print("Image loaded successfully")
            button.setImage(image, for: .normal)
        } else {
            print("Failed to load image")
        }
        //button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = true
        //button.layer.cornerRadius = 8
        return button
    }()
    @IBOutlet var imagesvg : UIImageView! = {
                let imageView = UIImageView()
                       imageView.image = UIImage(named: "back.svg")
                       imageView.contentMode = .scaleAspectFit
                       imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.backgroundColor = .systemGroupedBackground
        return imageView
      
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.contentView.layer.borderWidth = 1
//        self.contentView.layer.borderColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0).cgColor
////        contentView.addSubview(myLabel)
//////        contentView.addSubview(imagesvg)
////        contentView.addSubview(myButton)
////        myButton.alpha = 0.0
////
////        myLabel.translatesAutoresizingMaskIntoConstraints = false
////        myButton.translatesAutoresizingMaskIntoConstraints = false
////        imagesvg.translatesAutoresizingMaskIntoConstraints = false
////
////        NSLayoutConstraint.activate([
////                            imagesvg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////                            imagesvg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
////                            imagesvg.widthAnchor.constraint(equalToConstant: 30),
////                            imagesvg.heightAnchor.constraint(equalToConstant: 30),
////            
////                     myButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
////                     myButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
////                     myButton.widthAnchor.constraint(equalToConstant: 30),
////                     myButton.heightAnchor.constraint(equalToConstant: 30),
////                     
////                     myLabel.leadingAnchor.constraint(equalTo: myButton.trailingAnchor, constant: 0),
////                     myLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
////                     myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
////        ])
////        contentView.isUserInteractionEnabled = true
////        self.isUserInteractionEnabled = true
////        let tapguesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
////        contentView.addGestureRecognizer(tapguesture)
//       // myButton.setBackgroundImage(UIImage(named: "like"), for: .normal)
//       // myButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//    }
    @objc private func didTapButton() {
           delegate?.didTapButton(in: self) // Notify the delegate
       }
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupUI()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupUI()
       }

       private func setupUI() {
           // Initialize UI elements here
           self.backgroundColor = .clear
       }
}
