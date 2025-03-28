//
//  CustomView.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 25/03/25.

import Foundation
import UIKit

@IBDesignable
public class CustomView: UIView {

    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let closeButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 2)

        // Title Label
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)

        // Message Label
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        messageLabel.numberOfLines = 0

        // Close Button
        closeButton.setTitle(" Ok ", for: .normal)
        closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        closeButton.layer.cornerRadius = 5

//        addSubview(messageLabel)
//        addSubview(titleLabel)
//        addSubview(closeButton)
        // Stack View
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel,closeButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)

        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 0.8),
        ])
        
//        NSLayoutConstraint.activate([
//            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
//            messageLabel.widthAnchor.constraint(equalToConstant: 250),
//            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
//            
//            titleLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
//            titleLabel.widthAnchor.constraint(equalToConstant: 250),
//            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
//
//            closeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            closeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
//
//         
//        ])
    }

    @objc private func closePopup() {
        self.removeFromSuperview()
    }

    func configure(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
   

}
