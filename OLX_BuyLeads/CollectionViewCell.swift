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
