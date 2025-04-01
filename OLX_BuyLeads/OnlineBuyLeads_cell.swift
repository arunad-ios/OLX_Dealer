//
//  OnlineBuyLeads_cell.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 01/04/25.
//

import Foundation
import UIKit

class OnlineBuyLeads_cell : UITableViewCell {
    
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let dateLabel = UILabel()
    let visitedLabel = UILabel()
    let separatorView = UIView()
    let carLabel = UILabel()

    
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

        // Name Label
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.numberOfLines = 0
        // Status Label
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textColor = .darkGray
        statusLabel.numberOfLines = 0
        
        // Date Label
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.numberOfLines = 0
        dateLabel.textColor = .darkGray

        // Visited Label
        visitedLabel.text = "VISITED"
        visitedLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        visitedLabel.textColor = .systemGreen
        visitedLabel.textAlignment = .right

        // Separator
        separatorView.backgroundColor = .lightGray

        // Car Label
        carLabel.font = UIFont.systemFont(ofSize: 14)
        carLabel.textColor = .black

        
        //bottom View
        bottomView.backgroundColor = .systemGray6
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        
      
        
        

        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(equalToConstant: 50),
            cellseparatorView.heightAnchor.constraint(equalToConstant: 20),
            // Only one height constraint
            ])
      
        
             let button1 = createButton(title: "Like", color: .systemBlue)
             let button2 = createButton(title: "Share", color: .systemGreen)
             let button3 = createButton(title: "Delete", color: .systemRed)
             
             // Create Labels
             let label1 = createLabel(text: "Label 1")
             let label2 = createLabel(text: "Label 2")
        
             
        NSLayoutConstraint.activate([
            label1.widthAnchor.constraint(equalToConstant: 1),
            label2.widthAnchor.constraint(equalToConstant: 1),

            // Only one height constraint
            ])
        
             // Add Stack View
        let bottomstackView = UIStackView(arrangedSubviews: [button1, label1, button2, label2, button3])
        bottomstackView.axis = .horizontal
        bottomstackView.alignment = .center
        bottomstackView.distribution = .equalSpacing
        bottomstackView.spacing = 10
        bottomstackView.translatesAutoresizingMaskIntoConstraints = false
        bottomstackView.backgroundColor = .systemGray6

             
        bottomView.addSubview(bottomstackView)
        
        NSLayoutConstraint.activate([
            bottomstackView.heightAnchor.constraint(equalToConstant: 50) // Only one height constraint
               ])
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, statusLabel, dateLabel, visitedLabel, separatorView, carLabel,bottomstackView,cellseparatorView])
        stackView.axis = .vertical
        stackView.spacing = 5
        contentView.addSubview(stackView)
        stackView.backgroundColor = .clear
        
        

        stackView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            separatorView.heightAnchor.constraint(equalToConstant: 1),
            visitedLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }

    func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
          button.setTitle(title, for: .normal)
      //  button.setImage(UIImage.init(named: "like"), for: .normal)
          button.backgroundColor = color
          button.setTitleColor(.white, for: .normal)
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
          label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }
    func configure(name: String, status: String, date: String, cars: String) {
        nameLabel.text = name
        statusLabel.text = status
        dateLabel.text =  "Inquired Cars\n" + cars
        carLabel.text = ""
        
    }
}
