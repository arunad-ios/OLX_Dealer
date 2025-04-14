//
//  CustomAlertViewController.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 13/04/25.
//

import Foundation
import UIKit

class CustomAlertViewController: UIViewController {

    private let titleText: String
    private let messageText: String
    private let confirmTitle: String
    private let cancelTitle: String
    private let confirmAction: () -> Void
    private let cancelAction: () -> Void

    init(title: String, message: String, confirmTitle: String = "OK", cancelTitle: String = "CANCEL", confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
        self.titleText = title
        self.messageText = message
        self.confirmTitle = confirmTitle
        self.cancelTitle = cancelTitle
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleText
        label.textColor = UIColor(red: 23.0/255.0, green: 73.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = messageText
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(confirmTitle, for: .normal)
        button.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 23.0/255.0, green: 73.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    public lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(cancelTitle, for: .normal)
        button.setTitleColor(UIColor(red: 23.0/255.0, green: 73.0/255.0, blue: 152.0/255.0, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(red: 23.0/255.0, green: 73.0/255.0, blue: 152.0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupLayout()
    }
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton,confirmButton])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(containerView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(buttonStack)
      //  containerView.addSubview(cancelButton)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

//            cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
//            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 15),
//            cancelButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor),
//            cancelButton.heightAnchor.constraint(equalToConstant: 44),
//
//            confirmButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
//            confirmButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
//            confirmButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -15),
//            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            
          //  confirmButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -4),
         //   cancelButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 4),

            buttonStack.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            buttonStack.heightAnchor.constraint(equalToConstant: 40), // or adjust as needed
            buttonStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
           // cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -15)
        ])
    }

    @objc private func confirmTapped() {
        dismiss(animated: true) {
            self.confirmAction()
        }
    }

    @objc private func cancelTapped() {
        dismiss(animated: true) {
            self.cancelAction()
        }
    }
}
