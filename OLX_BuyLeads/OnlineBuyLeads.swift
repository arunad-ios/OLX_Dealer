//
//  OnlineBuyLeads.swift
//  CTE_BuyLeads
//
//  Created by Chandini on 25/03/25.
//

import Foundation
import UIKit

public class OnlineBuyLeads: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let apiService = ApiServices()
    private var items = NSMutableArray()

    private let tableView = UITableView()
    private var Buyleads = NSArray()
    private let data: [(String, UIImage?)] = [
        ("Item 1", UIImage(systemName: "star.fill")),
        ("Item 2", UIImage(systemName: "house.fill")),
        ("Item 3", UIImage(systemName: "heart.fill")),
        ("Item 4", UIImage(systemName: "bell.fill")),
        ("Item 5", UIImage(systemName: "gear"))
    ]

    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
     
        self.title = "Online Buy Leads"
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white, // Title text color
                .font: UIFont.boldSystemFont(ofSize: 15) // Custom font and size
            ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)
        view.backgroundColor = .white
       
        setupTableView()
    }
    func fetchBuyLeads()
    {
        let userinfo = MyPodManager.userinfo
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(userinfo["access_token"] as! String)","Http-User-agent":"postman"] as! [String:String]
        let parameters = [ "action":"loadallbuylead",
                           "api_id": "cteolx2024v1.0",
                           "device_id":"4fee41be780ae0e7",
                          "dealer_id":userinfo["user_id"] as! String] as! [String:Any]
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
            
                DispatchQueue.main.async {
                    let dic = data["data"] as! NSDictionary
                    let result = dic["buyleads"] as! NSDictionary
                    self.Buyleads = result["buylead"] as! NSArray
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    private func setupTableView() {
        let nib = UINib(nibName: "BuyLeadsCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "BuyLeadsCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
      
        fetchBuyLeads()

    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Buyleads.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyLeadsCell", for: indexPath) as! BuyLeadsCell

        let dic = Buyleads[indexPath.row] as! NSArray
        let response = dic[0] as! NSDictionary
        cell.configure(with: response["contact_name"]! as! String, statustext: response["status_text"]! as! String)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(data[indexPath.row].0)")
    }
}
