//
//  CustomView.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 25/03/25.

import Foundation
import UIKit

@IBDesignable
public class CustomView: UIView {
    public var errormessage = ""
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()

    private let dismissButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Dismiss", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        override public init(frame: CGRect) {
            super.init(frame: frame)
           // setupView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
          //  setupView()
        }

    public func setupView() {
            label.text = self.errormessage
            backgroundColor = .white
            layer.cornerRadius = 12
       
            addSubview(dismissButton)
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10)
            ])
            NSLayoutConstraint.activate([
                dismissButton.centerXAnchor.constraint(equalTo: trailingAnchor),
                dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                dismissButton.widthAnchor.constraint(equalToConstant: 100),
                dismissButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        }

        @objc private func dismissView() {
            self.removeFromSuperview()
        }

   
}
