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
    private var data : [Any] = []

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
                    let myView = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
                    myView.errormessage = error.localizedDescription
//                    let labelSize = myView.label.sizeThatFits(CGSize(width: myView.label.frame.width, height: CGFloat.greatestFiniteMagnitude))
//                    var frame = myView.frame
//                    frame.size.height = labelSize.height
//                    myView.frame = frame
                    myView.setupView()
                    myView.center = self.view.center
                    self.view.addSubview(myView)
                }
            }
        }
    }

    private func setupTableView() {
     

        tableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
     
     
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
        let bundle = Bundle(for: BuyLeadsCell.self)
        let nib = UINib(nibName: "BuyLeadsCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "BuyLeadsCell")
        
        let bundle1 = Bundle(for: CollectionTableViewCell.self)
        let nib1 = UINib(nibName: "CollectionTableViewCell", bundle: bundle1)
        tableView.register(nib1, forCellReuseIdentifier: "CollectionTableViewCell")
        
        
        insertCustomView(at: IndexPath(row: 0, section: 0))  // Inserts after row 2
        fetchBuyLeads()

    }
    func insertCustomView(at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let customView = UIView(frame: CGRect(x: 10, y: cell.frame.maxY, width: tableView.frame.width - 20, height: 100))
        customView.backgroundColor = .purple
        let label = UILabel(frame: customView.bounds)
        label.text = "Inserted View"
        label.textAlignment = .center
        label.textColor = .white
        customView.addSubview(label)
        tableView.addSubview(customView)
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
        if let cell = tableView.cellForRow(at: indexPath) as? CollectionTableViewCell {
               cell.collectionView.layoutIfNeeded()
               return cell.collectionView.collectionViewLayout.collectionViewContentSize.height
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "BuyLeadsCell", for: indexPath) as! BuyLeadsCell
            
            let response = Buyleads[indexPath.row] as! NSDictionary
            let cars = response["cars"] as! NSArray
            var make = ""
            for name in cars {
                let car = name as! NSDictionary
                if(make.count == 0){
                    make = "\(car["make"] as! String),\(car["make"] as! String)\n\(car["make"] as! String)"
                }
                else{
                    make = "\(make),\(car["make"] as! String)"
                }
            }
            //        let response = dic[0] as! NSDictionary
            cell.configure(with: response["contact_name"]! as! String, statustext: response["status_text"]! as! String,make_text: make)
            return cell
        }
        else{
                  let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as! CollectionTableViewCell
                     cell.configure(with: data)  // Pass data to cell
                     cell.collectionView.layoutIfNeeded()
                   return cell
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
