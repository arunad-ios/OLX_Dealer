//
//  OnlineBuyLeads.swift
//  CTE_BuyLeads
//
//  Created by Aruna on 25/03/25.
//

import Foundation
import UIKit


struct DealerInfo: Codable {
    let id: String
    let name: String
    let email: String
    let mobile: String
    let address : String
}


public class OnlineBuyLeads: UIViewController,TableCellDelegate,collectionCellDelegate,UISearchBarDelegate {
  
    
   
    
    private let apiService = ApiServices()
    private var items = NSMutableArray()
    private let tableView = UITableView()
    private var Buyleads = NSArray()
    private var data : [Any] = ["All","Hot","Inv Car","Archive","Appointment Fixed"]
    private var apidata : [Any] = []
    var status = ""
    var inventoryId = ""
    var noleadView = UIView()
    let noLeadLabel = UILabel()
    public var refresh = UIButton()
    public var searchButton = UIButton()

    var issearchenable = false
    
    let loadingView = LoadingView()
    let searchBar = UISearchBar()

    var filterParams = [String:Any]()
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchBuyLeads), name: Notification.Name("refreshLeads"), object: nil)

        if let frameworkDefaults = UserDefaults(suiteName: "com.Samplepod.OLX-BuyLeads") {
            frameworkDefaults.removePersistentDomain(forName: "com.Samplepod.OLX-BuyLeads")
            frameworkDefaults.synchronize()
        }
        FontLoader.registerFonts()
        self.title = "Online Buy Leads"
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white, // Title text color
                .font: UIFont(name: "Roboto-Medium", size: 18)! // Custom font and size
            ]
      
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            // Now you can access the window
            print("Got the window: \(window)")
            if let statusBarFrame = window.windowScene?.statusBarManager?.statusBarFrame {
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.backgroundColor = .appPrimary
                window.addSubview(statusBarView)
            }
        }
        
        
       
       
        navigationController?.navigationBar.isTranslucent = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // or .configureWithTransparentBackground()
        appearance.backgroundColor = .appPrimary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 👈 Title color here
        appearance.shadowColor = .clear // 🔥 removes the bottom line

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .appPrimary
        view.backgroundColor = .white
        
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back_arrow", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBArButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBArButton
        
        
        searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "search_white", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = searchBarButton
    
        setupTableView()
       }

    //MARK : navigation titleview
       func setupSearchBar() {
           let bgView = UIView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
           bgView.backgroundColor = .white
           bgView.layer.cornerRadius = 8
           searchButton.setImage(UIImage(named: "send", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
           searchButton.removeTarget(self, action:  #selector(didTapSearchButton), for: .touchUpInside)
           searchButton.addTarget(self, action: #selector(searchBuyLeads), for: .touchUpInside)
           searchBar.placeholder = "Search a name"
           searchBar.searchTextField.backgroundColor = .white
           searchBar.delegate = self

           // Set a fixed width
           let searchBarWidth = UIScreen.main.bounds.width - 40
           searchBar.frame = CGRect(x: 0, y: 0, width: searchBarWidth, height: 36)
           // Put it in the navigation bar
           navigationItem.titleView = searchBar
       }
      @objc private func didTapSearchButton() {
          issearchenable = true
        setupSearchBar()
      }
      @objc func searchBuyLeads()
      {
          fetchBuyLeads()
     }
       // MARK: - UISearchBarDelegate
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           print("Searching: \(searchText)")
       }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.text = ""
       }
    @objc func backButtonTapped()
    {
        if(issearchenable){
            issearchenable = false
            self.navigationItem.titleView = nil
            self.title = "Online Buy Leads"
            self.searchBar.text = ""
            self.searchBar.tintColor = .white
            self.searchBar.resignFirstResponder()
            self.fetchBuyLeads()
            searchButton.setImage(UIImage(named: "search_white", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
            searchButton.removeTarget(self, action:  #selector(searchBuyLeads), for: .touchUpInside)
            searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func dealerDetails()
    {
        loadingView.show(in: self.view, withText: "Loading Dealer Details...")
        self.noleadView.isHidden = true

        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.refresh_token)","Http-User-agent":"postman"] as! [String:String]

        let api = ApiServices()
        api.fetchdatawithGETAPI(headers: headers,url: "https://fcgapi.olx.in/dealer/users/me?id=\(MyPodManager.user_id)",authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Dealer Details: \(data)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    var fullAddress = ""
                        if  let dic = data["data"] as? NSDictionary{
                            if let addressDict = (dic["address"] as! NSArray).firstObject as? [String:Any] {
                                let street = addressDict["street_address"] as? String ?? ""
                                let city = addressDict["city"] as? String ?? ""
                                let state = addressDict["state"] as? String ?? ""
                                let postalCode = addressDict["postal_code"] as? Int ?? 0
                                let country = addressDict["country_code"] as? String ?? ""
                                fullAddress = [street, city, state, postalCode == 0 ? nil : "\(postalCode)", country]
                                    .compactMap { $0?.isEmpty == false ? $0 : nil }
                                    .joined(separator: ", ")
                                print("Full Address: \(fullAddress)")
                            }
                            
                            self.saveUserToFile(DealerInfo(id: dic["id"] as! String, name: dic["name"]! as! String, email: dic["phone"]! as! String, mobile: dic["email"]! as! String, address: fullAddress))
                        }
                        else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.loadingView.hide()
                            }
                        }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                  //  self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    func saveUserToFile(_ user: DealerInfo) {
        if let data = try? JSONEncoder().encode(user) {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("user.json")
            try? data.write(to: url)
        }
    }
    func stockFetchAPI()
    {
        loadingView.show(in: self.view, withText: "Loading Dealer Details...")
        self.noleadView.isHidden = true

        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.refresh_token)","Http-User-agent":"postman"] as! [String:String]

        let api = ApiServices()
        api.fetchdatawithGETAPI(headers: headers,url: "https://fcgapi.olx.in/dealer/v1/users/\(MyPodManager.user_id)/ads?page=1&size=50",authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    if  let dic = data["data"] as? NSArray{
                        InventorySaveDataIntoDB.sharedInstance.saveStockTitles(dic as Any)
                        }
                        else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.loadingView.hide()
                            }
                        }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                  //  self.showError(message: error.localizedDescription)
                }
            }
        }
    }
    func synchHomeAPI()
    {
        loadingView.show(in: self.view, withText: "Loading Authentiation...")
        self.noleadView.isHidden = true

        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.refresh_token)"] as! [String:String]
        
        let parameters = [
            "action": "homeapi",
            "api_id": "cteolx2024v1.0",
            "refresh_token":MyPodManager.refresh_token,
            "user_id":MyPodManager.user_id,
            "sync_time": UserDefaults.standard.value(forKey: "synchtime") ?? "",
            "system_info":"dflgjdflghdlfuhg",
            "device_id": Constant.uuid ?? ""
        ] as! [String:Any]
        
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    if((data["status"] as! String == "success")){
                        if  let dic = data["data"] as? NSDictionary{
                            UserDefaults.standard.set(dic["sync_time"], forKey: "synchtime")
                            self.fetchBuyLeads()
                            self.dealerDetails()
                            if(dic["sync_done"] as! String == "n"){
                                self.loadCities()
                                self.loadInventory()
                            }
                            else{
                            }
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
                }
            }
        }
    }
//    public func getMakeList()->[String]{
//        return InventoryAPIManager.sharedInstance.getMakes() as! [String]
//    }
//    public func getModelList()->[String]{
//        return InventoryAPIManager.sharedInstance.getModels() as! [String]
//    }
//    public func getStatesList()->[String]{
//        return InventoryAPIManager.sharedInstance.getstates() as! [String]
//    }
    
      func loadInventory()
      {
          let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
          let parameters = [
              "action": "loadbuyleadstatus",
              "api_id": "cteolx2024v1.0",
              "dealer_id":MyPodManager.user_id
          ] as! [String:Any]
          
          let api = ApiServices()
          api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
              switch result {
              case .success(let data):
                  print("Response Data: \(data)")
                  DispatchQueue.main.async {
                      if  let dic = data["data"] as? NSDictionary{
                          InventorySaveDataIntoDB.sharedInstance.saveleadsandsubleadsIntoDB(response: dic)
                      }
                  }
              case .failure(let error):
                  print("Error: \(error.localizedDescription)")
                  DispatchQueue.main.async {
                  }
              }
          }
      }
    func loadCities()
    {
        loadingView.show(in: self.view, withText: "Loading Cities...")
        self.noleadView.isHidden = true
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
        let parameters = [
            "action":"loadcities",
               "device_id":Constant.uuid,
               "dealer_id":MyPodManager.user_id,
               "api_id": "cteolx2024v1.0"
        ] as! [String:Any]
        
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    if  let dic = data["data"] as? NSDictionary{
                        InventorySaveDataIntoDB.sharedInstance.saveStatesandcitiesIntoDB(response: dic)
                    }
                    else{
                        print(data)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.loadingView.hide()
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                }
            }
        }
    }
    func loadModels()
    {
        loadingView.show(in: self.view, withText: "Loading Models...")
        self.noleadView.isHidden = true
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]

        let parameters = [
            "action":"loadmodels",
                "device_id":Constant.uuid,
            "dealer_id":MyPodManager.user_id,
                "api_id": "cteolx2024v1.0"
        ] as! [String:Any]
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    if  let dic = data["data"] as? NSDictionary{
                        InventorySaveDataIntoDB.sharedInstance.saveMakesModelsAndVariantsIntoDB(response: dic)
                    }
                    else{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.loadingView.hide()
                        }
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.loadingView.hide()
                }
            }
        }
    }
   @objc func fetchBuyLeads()
    {
        loadingView.show(in: self.view, withText: "Loading Leads...")
        self.noleadView.isHidden = true
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
        
        let parameters = [ "action":"loadallbuylead",
                           "api_id": "cteolx2024v1.0",
                           "device_id":Constant.uuid!,
                           "dealer_id":MyPodManager.user_id,
                           "status_filters":self.status,
                           "car_inventory_id":self.inventoryId,
                           "show_apptfixed": UserDefaults.standard.value(forKey: "show_apptfixed") ?? "n",
                           "hotleads": UserDefaults.standard.value(forKey: "hotleads") ?? "n",
                           "show_archieve":UserDefaults.standard.value(forKey: "show_archieve") ?? "n",
                           "app_type":"olx",
                           "search_key":self.searchBar.text ?? "",
                           "android_version":"15"] as! [String:Any]
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
            switch result {
            case .success(let data):
              //  print("Response Data: \(data)")
              
                DispatchQueue.main.async {
                    self.loadingView.hide()
                    if  let dic = data["data"] as? NSDictionary{
                        guard  let result = dic["buyleads"] as? NSDictionary else {return}
                            self.Buyleads = result["buylead"] as! NSArray
                            self.apidata = (result["status_count"] as! NSArray) as! [Any]
                            var statusString = (self.data[0] as! String).replacingOccurrences(of: "[^a-zA-Z\\s]", with: "", options: .regularExpression)
                            statusString = statusString.replacingOccurrences(of: " ", with: "")
                            self.data[0] = "\(statusString) (\(self.Buyleads.count))"
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
                    self.showApiError(error.localizedDescription)
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
                    self.synchHomeAPI()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showApiError(error.localizedDescription)
                }
            }
        }
    }
 
    func showApiError(_ message: String) {
        let errorAlert = ApiErrorAlertView(message: message)
        self.present(errorAlert, animated: true)
    }
  
      
    @objc func retryNetworkRequest() {
          print("Retry button tapped! Retry network request here.")
           self.navigationController?.popViewController(animated: true)
      }
    private func setupTableView() {
        
        tableView.backgroundColor = .cellbg
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
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 5
        }
        tableView.register(OnlineBuyLeads_cell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(OnlineBuyLeads_collection.self, forCellReuseIdentifier: OnlineBuyLeads_collection.identifier)
      //  tableView.register(LeadTableViewCell.self, forCellReuseIdentifier: "LeadCell")
        
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
        
        refresh.backgroundColor = UIColor.OLXBlueColor
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
      
        self.synchHomeAPI()
        print(getStockList())
        if(getStockList().count != 0){
            
        }
        else{
            self.stockFetchAPI()
        }
      //  print(view.constraints)
    }
    public func getStockList()->[Ads]{
        return InventoryAPIManager.sharedInstance.getStocks() as! [Ads]
    }
    
  
}
extension OnlineBuyLeads: PopupTableViewDelegate {
    public func didSelectItem(_ item: String) {
        print("Selected item: \(item)")
        self.status = item
        self.data[0] = item
        self.fetchBuyLeads()
    }
}
extension OnlineBuyLeads: InventoryTableViewDelegate {
    public func didSelectInventory(_ item: String) {
        print("Selected item: \(item)")
        if(self.inventoryId == ""){
            self.inventoryId = item
        }
        else{
            self.inventoryId = ""
        }
        self.fetchBuyLeads()
    }
}
// MARK: - UITableViewDelegate & DataSource

extension OnlineBuyLeads: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0)
        {
            return 0
        }
        return 35
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width, height: 30))
        let statusString = (self.data[0] as! String).replacingOccurrences(of: "[^a-zA-Z\\s]", with: "", options: .regularExpression)
        titleLabel.text = statusString.uppercased()
        titleLabel.textColor = .white
        titleLabel.font = .appFont(.bold, size: 14)
        headerView.addSubview(titleLabel)
        return headerView
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 70
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
            cell.collectionView.tag = indexPath.row
            cell.configure(name: response["contact_name"]! as! String, status: response["status_text"]! as! String, date: make, cars: cars as! [Any],phonenumber: response["mobile"]! as! String)
            
            //change status category backgourd based on category
            cell.status_category.setTitle(" \((response["status_category"]! as! String)) ", for: .normal)
            if let original = UIImage(named: "tag", in: .buyLeadsBundle, compatibleWith: nil) {
                    if((response["status_category"]! as! String).count == 0){
                        cell.status_category.isHidden = true
                    }else{
                        cell.status_category.isHidden = false
                        if((response["status_category"]! as! String) == "HOT" || (response["status_category"]! as! String) == "VERY HOT"){
                            let tinted = original.tinted(with: .systemRed)
                            cell.status_category.setBackgroundImage(tinted, for: .normal)
                        }
                        else if((response["status_category"]! as! String) == "COLD"){
                            let tinted = original.tinted(with: .appPrimary)
                            cell.status_category.setBackgroundImage(tinted, for: .normal)
                        }
                        else{
                            let tinted = original.tinted(with: .systemOrange)
                            cell.status_category.setBackgroundImage(tinted, for: .normal)
                        }
                    }
            }
            cell.delegate = self
            if((response["customer_visited"]! as! String).count != 0){
                cell.visitedLabel.alpha = 1.0
            }
            else{
                cell.visitedLabel.alpha = 0.0
            }
            cell.visitedLabel.tag = indexPath.row
            
            //show visiting popup
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(visitingStatus))
            cell.visitedLabel.addGestureRecognizer(tapGesture)
            cell.visitedLabel.isUserInteractionEnabled = true
            cell.contentView.backgroundColor = .cellbg
            
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
            
            //delete Dealer
            
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(deleteBuyLead), for: .touchUpInside)
            
            //update BuyLead
            cell.editBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editBuylead), for: .touchUpInside)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: OnlineBuyLeads_collection.identifier, for: indexPath) as! OnlineBuyLeads_collection
            cell.delegate = self
            cell.configure(with: data)  // Pass data to cell
            cell.contentView.backgroundColor = .cellbg
            return cell
        }
    }
    @objc func selectedCellitem(item: Int)
    {
        if(item == 0){
            let popupVC = FilterTableViewController()
            popupVC.configure(with: self.apidata)
            popupVC.modalPresentationStyle = .overFullScreen
            popupVC.delegate = self
            present(popupVC, animated: true)
        }
        else{
            if(item == 2){
                let inventoryVC = LoadInventoryView()
                inventoryVC.delegate = self
                present(inventoryVC, animated: true)
            }
            else{
                self.fetchBuyLeads()
            }
        }
    }
    @objc func deselectedCellitem(item: Int)
    {
        if(item == 2){
            self.inventoryId = ""
            self.fetchBuyLeads()
        }
        else{
            self.fetchBuyLeads()
        }
    }
    //Delete BuyLead
    @objc func deleteBuyLead(sender : UIButton)
    {
        let response =  Buyleads[sender.tag] as! [String : Any]
        let alert = CustomAlertViewController(
            title: "Delete Lead",
            message: "Do you want to delete this Lead?",
            confirmTitle: "Delete",
            cancelTitle: "Cancel",
            confirmAction: {
                print("Deleted")
                self.deleteDealer(dealer_id: response["buylead_id"] as! String)
            },
            cancelAction: {
                print("Cancelled")
            })

        self.present(alert, animated: true)
        
//        let deleteVC = AlertViewController()
//        deleteVC.items =  Buyleads[sender.tag] as! [String : Any]
//        deleteVC.message = "Are you sure do you want to delete this lead?"
//        deleteVC.modalPresentationStyle = .overCurrentContext
//        present(deleteVC, animated: false)
    }
    
    func deleteDealer(dealer_id : String)
    {
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
            let parameters = [
                               "api_id":"cteolx2024v1.0",
                                 "device_id":Constant.uuid,
                                 "action":"archivebuylead",
                                 "buylead_id":dealer_id,
                               "dealer_id":MyPodManager.user_id
            ] as! [String:Any]
            let api = ApiServices()
            api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
                switch result {
                case .success(let data):
                    print("Response Data: \(data)")
                    DispatchQueue.main.async {
                        if  let dic = data["data"] as? NSDictionary{
                            if(data["status"] as! String == "success"){
                            let alert = CustomAlertViewController(
                                title: "Success",
                                message: dic["message"] as! String,
                                confirmTitle: "Ok",
                                cancelTitle: "Cancel",
                                confirmAction: {
                                    print("Deleted")
                                    self.fetchBuyLeads()
                                },
                                cancelAction: {
                                    print("Cancelled")
                                })
                            alert.cancelButton.alpha = 1.0
                            self.present(alert, animated: true)
                            }
                            else{
                                let alert = CustomAlertViewController(
                                    title: "Failed",
                                    message: dic["error"] as! String,
                                    confirmTitle: "Ok",
                                    cancelTitle: "Cancel",
                                    confirmAction: {
                                        print("Deleted")
                                        self.fetchBuyLeads()
                                    },
                                    cancelAction: {
                                        print("Cancelled")
                                    })
                                alert.cancelButton.alpha = 0.0
                                self.present(alert, animated: true)
                            }
                        }
                        else{
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
                        self.showApiError(error.localizedDescription)
                    }
                }
            }
    }
    func deleteDealerCar(carid : String,buyLead_id:String)
    {
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
            let parameters = [
                "action":"archivebuyleadcar",
               "api_id":"cteolx2024v1.0",
                "device_id":Constant.uuid,
                "buylead_id":buyLead_id,
                "carid":carid,
                "dealer_id":MyPodManager.user_id
             ] as! [String:Any]
            let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
                switch result {
                case .success(let data):
                    print("Response Data: \(data)")
                    DispatchQueue.main.async {
                        if  let dic = data["data"] as? NSDictionary{
                            if(data["status"] as! String == "success"){
                                let alert = CustomAlertViewController(
                                    title: "Success",
                                    message: "BuyLead Car Deleted Successfully!",
                                    confirmTitle: "Ok",
                                    cancelTitle: "Cancel",
                                    confirmAction: {
                                        print("Deleted")
                                        self.fetchBuyLeads()
                                    },
                                    cancelAction: {
                                        print("Cancelled")
                                    })
                                alert.cancelButton.alpha = 0.0
                                self.present(alert, animated: true)
                            }
                            else{
                                let alert = CustomAlertViewController(
                                    title: "Failed",
                                    message: dic["error"] as! String,
                                    confirmTitle: "Ok",
                                    cancelTitle: "Cancel",
                                    confirmAction: {
                                        print("Deleted")
                                        self.fetchBuyLeads()
                                    },
                                    cancelAction: {
                                        print("Cancelled")
                                    })
                                alert.cancelButton.alpha = 0.0
                                self.present(alert, animated: true)
                            }
                        }
                        else{
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
                        self.showApiError(error.localizedDescription)
                    }
                }
            }
    }
    
    //redirect to edit page
    @objc func editBuylead(sender : UIButton)
    {
        let response = Buyleads[sender.tag] as! NSDictionary
        UserDefaults.standard.set(response["buylead_id"]!, forKey: "buylead_id")
        let editVC = OnlineBuyLead_Edit()
        editVC.items = response
        editVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    @objc func calltoBuyLead(sender : UITapGestureRecognizer){
        let response = Buyleads[sender.view!.tag] as! NSDictionary
        self.phoneClicked(dic: response)
        if let phoneURL = URL(string: "tel://\(response["mobile"]! as! String)"),
           UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL)
        } else {
            print("📵 Calling not supported on this device")
            let response = Buyleads[sender.view!.tag] as! NSDictionary
            UserDefaults.standard.set(response["buylead_id"]!, forKey: "buylead_id")
        }
    }
    func phoneClicked(dic : NSDictionary)
    {
        let response = dic

            self.noleadView.isHidden = true
            let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]

            let parameters = [
                "action":"submitbuyleadphoneclicksv1",
                "dealer_id":MyPodManager.user_id,
                    "api_id": "cteolx2024v1.0",
                   "buylead_id":response["buylead_id"]!,
                "name":response["contact_name"]!,
                   "start_time":"2025-01-29 10:05:27",
                   "mobile":response["mobile"]!,
                   "date_app":response["addeddate"]!,
                   "status_text":response["status_text"]!
            ] as! [String:Any]
            let api = ApiServices()
            api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
                switch result {
                case .success(let data):
                    print("Response Data: \(data)")
                    DispatchQueue.main.async {
                        self.loadingView.hide()
                        if  let dic = data["data"] as? NSDictionary{
                            if(data["status"] as! String == "success"){
                                let popup = BuyLeadStatus_update()
                                popup.items = response as! [String : Any] as NSDictionary
                                popup.modalPresentationStyle = .automatic
                                self.present(popup, animated: true)
                            }
                            else{
                            }
                        }
                        else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.loadingView.hide()
                            }
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.loadingView.hide()
                    }
                }
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
    
    func chatwithDealer(item: String) {
        print("Selected item from collectionView: \(item)")
          // Perform action (e.g., navigate to another screen)
        let userInfo_host: [String: Any] = [
            "olx_buyer_id": item,
            "user_id": MyPodManager.user_id
        ]
        MyPodManager.navigatetoHost(userinfo: userInfo_host)
    }
    //delete car
    func deleteCar(item: [String : Any], tag: Int) {
    
        let response =  Buyleads[tag] as! [String : Any]

        let alert = CustomAlertViewController(
            title: "Delete Car",
            message: "Do you want to remove this \(item["make"] ?? "")?",
            confirmTitle: "Delete",
            cancelTitle: "Cancel",
            confirmAction: {
                print("Deleted")
                self.deleteDealerCar(carid: item["id"] as! String,buyLead_id:  response["buylead_id"] as! String)
            },
            cancelAction: {
                print("Cancelled")
            })

        self.present(alert, animated: true)
        
        
//        let deleteVC = AlertViewController()
//        deleteVC.items = item
//        deleteVC.message = "Are you sure do you want to delete \(item["make"])?"
//        deleteVC.modalPresentationStyle = .overCurrentContext
//        present(deleteVC, animated: false)
    }
    
    @objc func navigateToHostVC(sender : UITapGestureRecognizer) {
        let popup = SendSMSPopupViewController()
        popup.items = Buyleads[sender.view!.tag] as! [String : Any]
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        present(popup, animated: true)
      }
    @objc func visitingStatus(sender:UITapGestureRecognizer)
    {
        let response = Buyleads[sender.view!.tag] as! NSDictionary
        if((response["customer_visited"]! as! String).count != 0){
          //  self.showPopup(title: "Message!", message: "Customer Visited On: \n \(response["customer_visited"]! as! String)")
            
            self.showApiError( "Customer Visited On: \n \(response["customer_visited"]! as! String)")
        }
    }
    func showPopup(title: String, message: String) {
//        let popup = CustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
//        popup.center = self.view.center
//        popup.configure(title: title, message: message)
//        self.view.addSubview(popup)
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? OnlineBuyLeads_collection {
            customCell.configure(with: data)  // Call your method to update UI
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
