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
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        label.numberOfLines = 0
        label.text = "safakjfd lasdfjlksa dfjlaksdf jalskdfj laskdjf"
        label.backgroundColor = .gray
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
        backgroundColor = UIColor.systemBackground
        addSubview(messageLabel)
        addSubview(retryButton)
        
        messageLabel.sizeToFit()
        messageLabel.text = message
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            messageLabel.widthAnchor.constraint(equalToConstant: 250),
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),

            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            retryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),

            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
  
}
