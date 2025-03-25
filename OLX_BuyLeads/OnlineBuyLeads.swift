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
