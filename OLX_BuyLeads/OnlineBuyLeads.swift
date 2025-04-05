//
//  OnlineBuyLeads.swift
//  CTE_BuyLeads
//
//  Created by Aruna on 25/03/25.
//

import Foundation
import UIKit


public class OnlineBuyLeads: UIViewController, UITableViewDelegate, UITableViewDataSource,TableCellDelegate,collectionCellDelegate {
    private let apiService = ApiServices()
    private var items = NSMutableArray()
    private let tableView = UITableView()
    private var Buyleads = NSArray()
    private var data : [Any] = ["All","Hot","Inv Car","Archive","Appointment Fixed"]
    private var errorView: ErrorView?
    private var apidata : [Any] = []
    var status = ""
    var noleadView = UIView()
    let noLeadLabel = UILabel()
    public var refresh = UIButton()
    
    let loadingView = LoadingView()

    public override func viewDidLoad() {
        
        super.viewDidLoad()
        FontLoader.registerFonts()
        self.title = "Online Buy Leads"
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white, // Title text color
                .font: UIFont.boldSystemFont(ofSize: 15) // Custom font and size
            ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0)
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action:  #selector(backButtonTapped))
        self.navigationController?.navigationItem.leftBarButtonItem = backButton
        setupTableView()
           
    }
    @objc func backButtonTapped()
    {
        self.navigationController?.popViewController(animated: true)
    }
   @objc func fetchBuyLeads()
    {
        //{verified=n, spage=1,  car_inventory_id=,  showcv=,}
        
        loadingView.show(in: self.view, withText: "Loading Leads...")
        self.noleadView.isHidden = true

        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
        
        let parameters = [ "action":"loadallbuylead",
                           "api_id": "cteolx2024v1.0",
                           "device_id":"4fee41be780ae0e7",
                           "dealer_id":MyPodManager.user_id,
                           "status_filters":self.status,
                           "show_apptfixed":"n",
                           "hotleads":"n",
                           "show_archieve":"n",
                           "app_type":"olx",
                           "search_key":"",
                           "android_version":"15"] as! [String:Any]
        
        
        
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: "https://fcgapi.olx.in/dealer/mobile_api",authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
              
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    if  let dic = data["data"] as? NSDictionary{
                        guard  let result = dic["buyleads"] as? NSDictionary else {return}
                            self.Buyleads = result["buylead"] as! NSArray
                            self.apidata = (result["status_count"] as! NSArray) as! [Any]
                            self.tableView.reloadData()
                           if(self.Buyleads.count == 0){
                            self.noleadView.isHidden = false
                           }else{
                            self.noleadView.isHidden = true
                           }
                    }
                    else{
                        print(data)
                        let dic = data 
                        if(dic["error"] as! String == "INVALID_TOKEN")
                        {
                            self.refreshToken()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.loadingView.hide()
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    func refreshToken()
    {
        let headers = ["x-origin-Panamera":"dev","Api-Version":"134","client-language":"en-in","Authorization":"Bearer \(MyPodManager.refresh_token)"] as! [String:String]
        let parameters = ["user_id":MyPodManager.user_id] as! [String:Any]
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: "https://fcgapi.olx.in/dealer/v1/auth/refresh_token",authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                DispatchQueue.main.async {
                    MyPodManager.requestDataFromHost(accesstoken: data["access_token"] as! String, userid: data["user_id"] as! String, refreshtoken: data["refresh_token"] as! String)
                self.fetchBuyLeads()
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
        tableView.estimatedRowHeight = 60
     
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
        
        tableView.register(OnlineBuyLeads_cell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(OnlineBuyLeads_collection.self, forCellReuseIdentifier: OnlineBuyLeads_collection.identifier)
        
        
        noleadView.backgroundColor = .clear
        // Add the view to the parent view
        view.addSubview(noleadView)

        // Enable Auto Layout
        noleadView.translatesAutoresizingMaskIntoConstraints = false
        noleadView.layer.cornerRadius = 5
        self.view.addSubview(noleadView)
        self.view.bringSubviewToFront(noleadView)

        // Center the view horizontally and vertically
        NSLayoutConstraint.activate([
            noleadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noleadView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noleadView.widthAnchor.constraint(equalToConstant: 150), // Example width
            noleadView.heightAnchor.constraint(equalToConstant: 80) // Example height
        ])
        
           
        noLeadLabel.text = "No Leads Found"
        noLeadLabel.textColor = .lightGray
        noLeadLabel.backgroundColor = .clear
        
        refresh.backgroundColor = UIColor(red: 0/255, green: 71/255, blue: 149/255, alpha: 1.0)
        refresh.setTitle("Refresh", for: .normal)
        refresh.addTarget(self, action: #selector(fetchBuyLeads), for: .touchUpInside)
        refresh.layer.cornerRadius = 5.0
        
        
        
        let stackView = UIStackView(arrangedSubviews: [noLeadLabel,refresh])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        noleadView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: noleadView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: noleadView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: noleadView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: noleadView.bottomAnchor, constant: -10)
        ])
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.isUserInteractionEnabled = true
        
        
      

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
            cell.configure(name: response["contact_name"]! as! String, status: response["status_text"]! as! String, date: make, cars: cars as! [Any],phonenumber: response["mobile"]! as! String)
            cell.delegate = self

            cell.visitedLabel.tag = indexPath.row
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(visitingStatus))
            cell.visitedLabel.addGestureRecognizer(tapGesture)
            cell.visitedLabel.isUserInteractionEnabled = true
            cell.contentView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
            
            //navigate to chat screen from SDK to OLX App
            cell.chatBtn.isUserInteractionEnabled = true
            cell.chatBtn.tag =  indexPath.row
            let chatGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToHostVC))
            cell.chatBtn.addGestureRecognizer(chatGesture)
            
            //make a call
            cell.nameLabel.tag = indexPath.row
            let callGesture = UITapGestureRecognizer(target: self, action: #selector(calltoBuyLead))
            cell.nameLabel.addGestureRecognizer(callGesture)
            cell.nameLabel.isUserInteractionEnabled = true
            
            cell.editBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editBuylead), for: .touchUpInside)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: OnlineBuyLeads_collection.identifier, for: indexPath) as! OnlineBuyLeads_collection
            cell.delegate = self
            cell.configure(with: data)  // Pass data to cell
            cell.contentView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
            return cell
        }
    }
    @objc func selectedCellitem(item: String)
    {
        let popupVC = FilterTableViewController()
        popupVC.configure(with: self.apidata)
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.delegate = self
        present(popupVC, animated: true)
    }
    
    @objc func editBuylead(sender : UIButton)
    {
        let editVC = OnlineBuyLead_Edit()
        editVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    @objc func calltoBuyLead(sender : UITapGestureRecognizer){
        let response = Buyleads[sender.view!.tag] as! NSDictionary
        if let phoneURL = URL(string: "tel://\(response["mobile"]! as! String)"),
           UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL)
        } else {
            print("📵 Calling not supported on this device")
        }
    }
    func collectionViewCellDidSelect(item: String) {
        print("Selected item from collectionView: \(item)")
          // Perform action (e.g., navigate to another screen)
        let userInfo_host: [String: Any] = [
            "olx_buyer_id": item,
            "user_id": MyPodManager.user_id
        ]
        MyPodManager.navigatetoHost(userinfo: userInfo_host)
      }
    
    @objc func navigateToHostVC(sender : UITapGestureRecognizer) {
        let response = Buyleads[sender.view!.tag] as! NSDictionary

        let userInfo_host: [String: Any] = [
            "olx_buyer_id": response["olx_buyer_id"]!,
            "user_id": MyPodManager.user_id
        ]
        NotificationCenter.default.post(name: Notification.Name("OpenChat"), object: userInfo_host)

      }
    @objc func visitingStatus(sender:UITapGestureRecognizer)
    {
        let response = Buyleads[sender.view!.tag] as! NSDictionary
        if((response["customer_visited"]! as! String).count != 0){
            self.showPopup(title: "Message!", message: "Customer Visited On: \n \(response["customer_visited"]! as! String)")
        }
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
extension OnlineBuyLeads: PopupTableViewDelegate {
    public func didSelectItem(_ item: String) {
        print("Selected item: \(item)")
        self.status = item
        self.fetchBuyLeads()
    }
}
