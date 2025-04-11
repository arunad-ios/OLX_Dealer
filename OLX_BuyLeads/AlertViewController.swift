import UIKit
import Foundation


class AlertViewController : UIViewController {

    private let titleLabel = UILabel()
    private let headingLebel = UILabel()

    private let cancelButton = UIButton(type: .system)
    private let sendButton = UIButton(type: .system)
    private let containerView = UIView()
    public var items = [String:Any]()
    public var message = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setupUI()
    }

    private func setupUI() {
        // Container
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        // Title
        headingLebel.text = "Delete Lead"
        headingLebel.font = UIFont(name: "Roboto-Bold", size: 16)
        headingLebel.textAlignment = .center
        headingLebel.numberOfLines = 0
        containerView.addSubview(headingLebel)
        
        
        // Title
        titleLabel.text = self.message
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        containerView.addSubview(titleLabel)

        // Buttons
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.layer.borderColor = UIColor.OLXBlueColor.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 6
        cancelButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)

        sendButton.setTitle("DELETE", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.backgroundColor = UIColor.OLXBlueColor
        sendButton.layer.cornerRadius = 6
        sendButton.addTarget(self, action: #selector(DeleteAction), for: .touchUpInside)

        containerView.addSubview(cancelButton)
        containerView.addSubview(sendButton)

        // Layout with AutoLayout
        layoutUI()
    }
    @objc func dismissSelf()
    {
        self.dismiss(animated: false)
    }
    @objc func DeleteAction()
    {
        self.dismiss(animated: false)
    }
    private func layoutUI() {
        [headingLebel, titleLabel, cancelButton, sendButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 250),
            containerView.heightAnchor.constraint(equalToConstant: 150),

            headingLebel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            headingLebel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headingLebel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headingLebel.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: headingLebel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         

            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),

            sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            sendButton.widthAnchor.constraint(equalToConstant: 100),
            sendButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: - Picker Delegate
 
}
