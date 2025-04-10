//
//  LoadInventoryView.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 05/04/25.
//

import Foundation
import UIKit
public protocol InventoryTableViewDelegate: AnyObject {
    func didSelectInventory(_ item: String)
}
public class LoadInventoryView : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    public weak var delegate: InventoryTableViewDelegate?
    let searchBar = UISearchBar()

    private let tableView = UITableView()
    public var items: [Any] = []

    public override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
        self.setupTableView()
        loadInventory()
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
    public func configure(with items: [Any]) {
        self.items = items
    }
  
    func loadInventory()
    {
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
        let parameters = [
            "action": "loadallematchinventory",
            "api_id": "cteolx2024v1.0",
            "device_id":"4fee41be780ae0e7",
            "dealer_id":MyPodManager.user_id
        ] as! [String:Any]
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                DispatchQueue.main.async {
                    if  let dic = data["data"] as? NSDictionary{
                        self.items = (dic["cars"] as! NSArray) as! [Any]
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                }
            }
        }
    }
    private func setupTableView() {
        
        tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.sectionHeaderTopPadding = 0
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self

    }
    // MARK: - UITableView DataSource & Delegate
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let imageview = UIImageView(frame: CGRect(x: 16, y: 0, width: 30, height: 30))
        imageview.backgroundColor = UIColor.OLXBlueColor
        imageview.layer.cornerRadius = imageview.frame.size.width / 2
        imageview.layer.masksToBounds = true
        imageview.image = UIImage(named: "filter")
        headerView.addSubview(imageview)
        let titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: tableView.frame.width, height: 30))
        titleLabel.text = "Inventory Cars"
        titleLabel.textColor = UIColor.OLXBlueColor
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 16)
        headerView.addSubview(titleLabel)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: tableView.frame.width - 30, y: 0, width: 25, height: 25)
        let image = UIImage(named: "close", in: .buyLeadsBundle, compatibleWith: nil)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.isUserInteractionEnabled = true
        headerView.addSubview(button)
        
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(searchBar)

               // Layout constraints
        NSLayoutConstraint.activate([
        searchBar.topAnchor.constraint(equalTo: button.safeAreaLayoutGuide.bottomAnchor,constant: 20),
        searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
        searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ])
        return headerView
    }
   @objc func dismissView()
    {
        self.dismiss(animated: false, completion: nil)
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dic = items[indexPath.item] as! NSDictionary
        print((dic["name"] as! String))
        cell.textLabel?.text = "\((dic["name"] as! String))"
        cell.textLabel?.font =  UIFont(name: "Roboto-Regular", size: 14)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = items[indexPath.item] as! NSDictionary
        delegate?.didSelectInventory(NSString(format: "%@", dic["id"] as! CVarArg) as String)
        dismiss(animated: true)
    }
}
extension LoadInventoryView : UISearchBarDelegate {
    
}
