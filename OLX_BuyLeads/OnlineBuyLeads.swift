//
//  OnlineBuyLeads.swift
//  CTE_BuyLeads
//
//  Created by Aruna on 25/03/25.
//

import Foundation
import UIKit

public class OnlineBuyLeads: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let apiService = ApiServices()
    private var items = NSMutableArray()

    private let tableView = UITableView()
    private let data: [(String, UIImage?)] = [
        ("Item 1", UIImage(systemName: "star.fill")),
        ("Item 2", UIImage(systemName: "house.fill")),
        ("Item 3", UIImage(systemName: "heart.fill")),
        ("Item 4", UIImage(systemName: "bell.fill")),
        ("Item 5", UIImage(systemName: "gear"))
    ]
//    private func fetchData() {
//            let url = "https://jsonplaceholder.typicode.com/posts" // Sample API
//        apiService.fetchData(from: url) { (result: Result<Data, Error>) in
//            switch result {
//            case .success(let data):
//                do {
//                    let decodedData = try JSONDecoder().decode(self, from: data)
//                    self.items = decodedData
//                } catch {
//                    print("Decoding error: \(error)")
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
//        }
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
        let userinfo = MyPodManager.userinfo
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IlAzOVZuNlJZIn0.eyJncmFudFR5cGUiOiJlbWFpbCIsImNsaWVudFR5cGUiOiJ3ZWIiLCJ0b2tlblR5cGUiOiJhY2Nlc3NUb2tlbiIsImlzTmV3VXNlciI6ZmFsc2UsImlhdCI6MTc0MjkwMzE4NiwiZXhwIjoxNzQyOTA0MDg2LCJhdWQiOiJvbHhpbiIsImlzcyI6Im9seCIsInN1YiI6IjQwMDgwNjgyMCIsImp0aSI6IjdjMGRjZWU1NTBlMTFmMmY3MDE4NjQyMmQ3ZWYzMjkyYjZmZDNkM2QifQ.M05JWIJ7qjxajU8EPCGLlFwxuP8izdZoKpsZZVdNgSE5hIg8Po0iE2fUbUmcbVsxsltwnEyLbiNJHeAh138VYyYbr1C8fOhIOjjZDzWODug9tjAE28BHr6V5znvQDYP_Ppm5xokxskC5kuhXgN8Ex74ucpCXh-6nMipYxSsxA1F8SdkY_3z5AJS029Vt4sUtYv1BsorVxEihDWBqpxvlInS_fptR1QvOAdtcxp_OTu43pYpBtT4tc6S9W4kwbLKJWay9sJToWV376TxdSoOY-A5WmZOPvE2u930uIyJvVf0Wlq7nppmTrBIoo-ZwonETOJXkxRsci3jrfowBw0Gxqg"] as! [String:String]
        let parameters = ["action":"loadallematchinventory",
                          "api_id": "cteolx2024v1.0",
                          "device_id":"4fee41be780ae0e7",
                          "dealer_id":userinfo["user_id"] as! String] as! [String:Any]
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers) { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                DispatchQueue.main.async {
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        setupTableView()
    }

    private func setupTableView() {
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
        tableView.register(BuyLeadsCell.self, forCellReuseIdentifier: BuyLeadsCell.identifier)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BuyLeadsCell.identifier, for: indexPath) as? BuyLeadsCell else {
            return UITableViewCell()
        }
        let (title, image) = data[indexPath.row]
        cell.configure(with: title, image: image)
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(data[indexPath.row].0)")
    }
}
