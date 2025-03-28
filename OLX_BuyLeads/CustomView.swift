//
//  CustomView.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 25/03/25.

import Foundation
import UIKit

@IBDesignable
public class CustomView: UIView {
    
    private let backgroundView = UIView()
    private let contentView = UIView()
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
        // Fullscreen Transparent Background
        self.frame = UIScreen.main.bounds
        backgroundView.frame = self.frame
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Semi-transparent background
        backgroundView.alpha = 0
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePopup)))

        // Popup Content View
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Title Label
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black

        // Message Label
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0

        // Close Button
        closeButton.setTitle(" OK ", for: .normal)
        closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        closeButton.layer.cornerRadius = 8
        // Stack View
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel, closeButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)
        self.addSubview(backgroundView)
        self.addSubview(contentView)

        // Constraints
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 300),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),

            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9)
        ])
    }

    @objc private func closePopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }

    func configure(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }

    func show(in viewController: UIViewController) {
        if let window = viewController.view.window {
            window.addSubview(self)
            UIView.animate(withDuration: 0.3) {
                self.backgroundView.alpha = 1
            }
        }
    }

}
