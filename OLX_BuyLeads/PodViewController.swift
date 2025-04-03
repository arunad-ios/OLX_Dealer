//
//  PodViewController.swift
//  CTE_BuyLeads
//
//  Created by Aruna on 25/03/25.
//

import Foundation
import UIKit

public class PodViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Online Buy Leads"
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white, // Title text color
                .font: UIFont.boldSystemFont(ofSize: 15) // Custom font and size
            ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0)
//        let navItem = UINavigationItem(title: "Online Buy Leads")
//        navigationController?.navigationBar.items = [navItem]
        let dismissButton = UIButton(type: .system)
        dismissButton.setTitle("Refresh", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dismissButton)

        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
       // dismiss(animated: true, completion: nil)
    }
}
