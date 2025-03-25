//
//  CustomView.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 25/03/25.

import Foundation
import UIKit

@IBDesignable
public class CustomView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "View from Framework!"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let dismissButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Dismiss", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .red
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        override public init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }

        private func setupView() {
            backgroundColor = .systemBlue
            layer.cornerRadius = 12
            addSubview(dismissButton)
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: centerXAnchor),
                label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10)
            ])
            NSLayoutConstraint.activate([
                dismissButton.centerXAnchor.constraint(equalTo: centerXAnchor),
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
