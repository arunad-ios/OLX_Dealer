//
//  ErrorView.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 27/03/25.
//

import UIKit

class ErrorView: UIView {
    
    var errormessageupdate = ""
    public let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        label.numberOfLines = 0
        label.text = ""
        label.backgroundColor = .clear
        return label
    }()
    
    public let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        button.layer.cornerRadius = 8
      //  button.addTarget(ErrorView.self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    @objc func dismiss()
    {
        self.removeFromSuperview()
    }
    
    init(errorMessage: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI(message: errorMessage)
        errormessageupdate = errorMessage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(message : String) {
        self.backgroundColor = UIColor.white
        
        
        let popupView = UIView()
        popupView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        popupView.layer.cornerRadius = 12
        popupView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        popupView.addSubview(label)
        self.addSubview(popupView)

        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 30),
            popupView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -30),

            label.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
        ])

        // Auto dismiss after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            popupView.removeFromSuperview()
        }
        
        
//        addSubview(messageLabel)
//        addSubview(retryButton)
//        
//        messageLabel.sizeToFit()
//        messageLabel.text = message
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        retryButton.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.cornerRadius = 10
//        self.layer.masksToBounds = true
//        
//        NSLayoutConstraint.activate([
//            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
//            messageLabel.widthAnchor.constraint(equalToConstant: 250),
//
//            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
//            retryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
//
//            retryButton.widthAnchor.constraint(equalToConstant: 100),
//            retryButton.heightAnchor.constraint(equalToConstant: 40)
//        ])
    }
  
}
