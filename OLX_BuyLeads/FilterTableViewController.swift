//
//  FilterTableViewController.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 04/04/25.
//

import Foundation
import UIKit

public protocol PopupTableViewDelegate: AnyObject {
    func didSelectItem(_ item: String)
}

public class FilterTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public weak var delegate: PopupTableViewDelegate?
    
    private let tableView = UITableView()
    public var items: [Any] = []

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setupTableView()
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
    public func configure(with items: [Any]) {
        self.items = items
    }
    
    private func setupTableView() {
        
        let centeredView = UIView()
        centeredView.backgroundColor = .white
        // Add the view to the parent view
        view.addSubview(centeredView)

        // Enable Auto Layout
        centeredView.translatesAutoresizingMaskIntoConstraints = false
        centeredView.layer.cornerRadius = 5

        // Center the view horizontally and vertically
        NSLayoutConstraint.activate([
            centeredView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centeredView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centeredView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-80), // Example width
            centeredView.heightAnchor.constraint(equalToConstant: 400) // Example height
        ])

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 30
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        centeredView.addSubview(tableView)
        tableView.isScrollEnabled = false

        NSLayoutConstraint.activate([
                  tableView.topAnchor.constraint(equalTo: centeredView.topAnchor, constant: 10),
                  tableView.leadingAnchor.constraint(equalTo: centeredView.leadingAnchor, constant: 10),
                  tableView.trailingAnchor.constraint(equalTo: centeredView.trailingAnchor, constant: -10),
                  tableView.bottomAnchor.constraint(equalTo: centeredView.bottomAnchor, constant: -10)
              ])
    }
    // MARK: - UITableView DataSource & Delegate
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let imageview = UIImageView(frame: CGRect(x: 16, y: 0, width: 30, height: 30))
        imageview.image = UIImage(named: "filter")
        headerView.addSubview(imageview)
        let titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: tableView.frame.width, height: 30))
        titleLabel.text = "Filter"
        titleLabel.textColor = UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0)
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        headerView.addSubview(titleLabel)
        return headerView
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dic = items[indexPath.item] as! NSDictionary
        print((dic["name"] as! String))
        cell.textLabel?.text = "\((dic["name"] as! String))(\((dic["count"] as! CVarArg)))"
        cell.textLabel?.font =  UIFont(name: "Roboto-Regular", size: 12)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = items[indexPath.item] as! NSDictionary
        delegate?.didSelectItem(dic["name"] as! String)
        dismiss(animated: true)
    }
}
