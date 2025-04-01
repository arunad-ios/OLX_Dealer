//
//  OnlineBuyLeads.swift
//  CTE_BuyLeads
//
//  Created by Chandini on 25/03/25.
//

import Foundation
import UIKit
class DynamicCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

public class OnlineBuyLeads: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let apiService = ApiServices()
    private var items = NSMutableArray()
    private let tableView = UITableView()
    private var Buyleads = NSArray()
    private var data : [Any] = []
    private var errorView: ErrorView?

    public override func viewDidLoad() {
        
        super.viewDidLoad()
        if Bundle(identifier: "com.Samplepod.OLX-BuyLeads") != nil {
            FontLoader.registerFont(withName: "Roboto-Regular")
            FontLoader.registerFont(withName: "Roboto-Bold")
        }
        self.title = "Online Buy Leads"
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white, // Title text color
                .font: UIFont.boldSystemFont(ofSize: 15) // Custom font and size
            ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(backButtonTapped))
        self.navigationController?.navigationItem.leftBarButtonItem = backButton
        setupTableView()
           
    }
    @objc func backButtonTapped()
    {
        self.navigationController?.popViewController(animated: true)
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
                    if  let dic = data["data"] as? NSDictionary{
                        guard  let result = dic["buyleads"] as? NSDictionary else { return }
                            self.Buyleads = result["buylead"] as! NSArray
                            self.data = (result["status_count"] as! NSArray) as! [Any]
                            self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    func showError(message: String) {
          // Remove existing error view if any
          errorView?.removeFromSuperview()
          
          // Create and add error view
          let errorView = ErrorView(errorMessage: message)
//          errorView.retryAction = {
//              errorView.removeFromSuperview()
//          }
          
          errorView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(errorView)
        errorView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        errorView.messageLabel.text = message
          NSLayoutConstraint.activate([
              errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              errorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
              errorView.heightAnchor.constraint(equalToConstant: errorView.messageLabel.frame.height + 150)
          ])
        errorView.retryButton.addTarget(self, action: #selector(retryNetworkRequest), for: .touchUpInside)
        errorView.messageLabel.text = message
          self.errorView = errorView
      }
      
    @objc func retryNetworkRequest() {
          print("Retry button tapped! Retry network request here.")
          errorView?.removeFromSuperview() // Remove error view on retry
      }
    private func setupTableView() {
        tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
     
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
//        let bundle = Bundle(for: BuyLeadsCell.self)
//        let nib = UINib(nibName: "BuyLeadsCell", bundle: bundle)
//        tableView.register(nib, forCellReuseIdentifier: "BuyLeadsCell")
        
        tableView.register(OnlineBuyLeads_cell.self, forCellReuseIdentifier: "CustomCell")

        tableView.register(OnlineBuyLeads_collection.self, forCellReuseIdentifier: OnlineBuyLeads_collection.identifier)

//        let bundle1 = Bundle(for: CollectionTableViewCell.self)
//        let nib1 = UINib(nibName: "CollectionTableViewCell", bundle: bundle1)
//        tableView.register(nib1, forCellReuseIdentifier: "CollectionTableViewCell")
        fetchBuyLeads()

    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 0
        }
        return 50
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width, height: 50))
        titleLabel.text = "FOLLOWUP"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Roboto-Medium", size: 14)

        headerView.addSubview(titleLabel)
        return headerView
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            if let cell = tableView.cellForRow(at: indexPath) as? OnlineBuyLeads_collection {
               cell.collectionView.layoutIfNeeded()
                return cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            }
        }
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }
        return Buyleads.count
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! OnlineBuyLeads_cell
            let response = Buyleads[indexPath.row] as! NSDictionary
            let cars = response["cars"] as! NSArray
            var make = ""
            for name in cars {
                let car = name as! NSDictionary
                if(make.count == 0){
                    make = "\(car["make"] as! String)"
                }
                else{
                    make = "\(make)\n\(car["make"] as! String)"
                }
            }
//            cell.configure(with: response["contact_name"]! as! String, statustext: response["status_text"]! as! String,make_text: make,cars)
            cell.configure(name: response["contact_name"]! as! String, status: response["status_text"]! as! String, date: make, cars: make)
            
            cell.visitedLabel.tag = indexPath.row
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(visitingStatus))
            cell.visitedLabel.addGestureRecognizer(tapGesture)
            cell.visitedLabel.isUserInteractionEnabled = true
            return cell
        }
        else{
                 let cell = tableView.dequeueReusableCell(withIdentifier: OnlineBuyLeads_collection.identifier, for: indexPath) as! OnlineBuyLeads_collection
                cell.configure(with: data)  // Pass data to cell
                return cell
        }
    }
    @objc func visitingStatus(sender:UITapGestureRecognizer)
    {
        let response = Buyleads[sender.view!.tag] as! NSDictionary
        self.showPopup(title: "Message!", message: "Customer Visited On: \n \(response["customer_visited"]! as! String)")
        
    }
    func showPopup(title: String, message: String) {
        let popup = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        popup.center = self.view.center
        popup.configure(title: title, message: message)
        self.view.addSubview(popup)
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? OnlineBuyLeads_collection {
            customCell.configure(with: data)  // Call your method to update UI
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
