//
//  BuyLeadStatus_update.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 11/04/25.


import Foundation
import UIKit

class BuyLeadStatus_update : UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    
    let datePicker = UIDatePicker()
    let visiteddatePicker = UIDatePicker()

    var data: [SectionModel] = []
    var cars: [Any] = []
    var logs: [Any] = []
    var items = NSDictionary()

    var buyLeadData = [String:Any]()
    var Cities : [String] = []
    var subleads : [String] = []

    let topView = UIView()

    let popupView = UIView()
    let updateButton = UIButton(type: .system)
    
    
       // Top Horizontal Labels
        let contactname = UILabel()
        let contactnumber = UILabel()
        let closeBtn = UIButton()
        
        // Bottom Vertical Labels
        let statusLbl = UILabel()
        let bottomLabel2 = UILabel()

    private let tableView = UITableView()
    
    var leadStatus: [FormRow] = [
        .button(title: "Lead Classification",key:"clasification",ishidden: false),
       .button(title: "Lead Status",key:"leadstatus",ishidden: false),
       .button(title: "other",key:"leadsubstatus",ishidden: false),
       .textField(placeholder: "Date", text: "Date",ishidden: false),
       .button(title: "customerVisitedstatus",key:"visitedDate", ishidden: false),
       .textField(placeholder: "VisitedDate", text: "",ishidden: false),
        .textField(placeholder: "Note Against Status", text: "",ishidden: false),
        .button(title: "sendsms",key:"sendsms", ishidden: false)
   ]
    
    var expandedSections: Set<Int> = [] // Track expanded sections
    var dropdown: DropdownView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout(topviewheight: 100)
        self.tableView.reloadData()
        
        self.loadbuylead()
    }
    @objc func backButtonTapped()
    {
        self.navigationController?.popViewController(animated: true)
    }
    func setupViews() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        popupView.backgroundColor = .clear
        popupView.layer.cornerRadius = 12
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        
        
           // Top View
          // self.view.backgroundColor = .white
           topView.backgroundColor = .white
        self.view.addSubview(topView)

           // TableView
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderTopPadding = 1
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")
        tableView.register(VehicleinfoCell.self, forCellReuseIdentifier: "VehicleinfoCell")
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")
        tableView.register(ButtonCell.self, forCellReuseIdentifier: "ButtonCell")
        tableView.register(DatePickerCell.self, forCellReuseIdentifier: "DatePickerCell")
        tableView.register(CheckboxCell.self, forCellReuseIdentifier: "CheckboxCell")
        
        
           // Bottom Button
        updateButton.setTitle("Update", for: .normal)
        updateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        updateButton.backgroundColor = .systemBlue
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.layer.cornerRadius = 10
        updateButton.addTarget(self, action: #selector(updatebuylead), for: .touchUpInside)
        self.view.addSubview(updateButton)
       }

    func setupLayout(topviewheight : CGFloat) {
            popupView.translatesAutoresizingMaskIntoConstraints = false
           topView.translatesAutoresizingMaskIntoConstraints = false
           tableView.translatesAutoresizingMaskIntoConstraints = false
           updateButton.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
            
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
//
               // Top View
               topView.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor,constant: 25),
               topView.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor,constant: 25),
               topView.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor,constant: -50),
               topView.heightAnchor.constraint(equalToConstant: topviewheight),

               // Bottom Button
               updateButton.bottomAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
               updateButton.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor, constant: 70),
               updateButton.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -70),
               updateButton.heightAnchor.constraint(equalToConstant: 50),

               // TableView
               tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
               tableView.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor,constant: 25),
               tableView.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor,constant: -25),
               tableView.bottomAnchor.constraint(equalTo: updateButton.topAnchor, constant: -70)
           ])
           self.setupLabels()
           self.layoutLabels()
       }
    @objc func closeTopView() {
        self.dismiss(animated: false)
    }
    
    func setupLabels() {
          // Common style
        let allLabels = [contactname, contactnumber, statusLbl, bottomLabel2]
          for label in allLabels {
              label.textAlignment = .left
              label.textColor = .black
              label.backgroundColor = .clear
              label.font = UIFont(name: "Roboto-Regular", size: 14)
              label.layer.cornerRadius = 8
              label.clipsToBounds = true
          }
        closeBtn.addTarget(self, action: #selector(closeTopView), for: .touchUpInside)
        contactname.text =  (items["contact_name"]! as! String)
        contactnumber.text = "\(items["mobile_clicked"]! as! String)\(items["mobile"]! as! String)"
        closeBtn.setImage(UIImage(named: "close", in: .buyLeadsBundle, compatibleWith: nil),for: .normal)
        statusLbl.text = (items["status_text"]! as! String)
          bottomLabel2.text = (items["addeddate"]! as! String)
        bottomLabel2.backgroundColor = .blue
      

        
        if((items["contact_name"]! as! String).count != 0){
            let coloredText = NSMutableAttributedString(string:  "N : \(items["contact_name"]! as! String)")
            // 3️⃣ Apply Color to Part of the Text
            coloredText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: 1)) // "Hello" in blue
            coloredText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 4, length: (items["contact_name"]! as! String).count))  // "Swift" in red
            contactname.attributedText = coloredText
        }
        
        let phonenumber = (items["mobile"]! as! String)
        let name = "M"
        if((items["mobile"]! as! String).count != 0){
            let coloredText = NSMutableAttributedString(string:  "\(name) : \(items["mobile"]! as! String)")
            // 3️⃣ Apply Color to Part of the Text
            coloredText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: name.count)) // "Hello" in blue
            coloredText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: name.count+3, length: phonenumber.count))  // "Swift" in red
            contactnumber.attributedText = coloredText
        }
        if((items["mobile_clicked"]! as! String) != "y"){
            let callGesture = UITapGestureRecognizer(target: self, action: #selector(calltoBuyLead))
            contactnumber.addGestureRecognizer(callGesture)
        }
      }
      @objc func calltoBuyLead(sender : UITapGestureRecognizer){
        if let phoneURL = URL(string: "tel://\(items["mobile"]! as! String)"),
           UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL)
        } else {
            print("📵 Calling not supported on this device")
        }
    }
      func layoutLabels() {
          let topStack = UIStackView(arrangedSubviews: [contactname, contactnumber, closeBtn])
          topStack.axis = .horizontal
          topStack.distribution = .fillProportionally
          topStack.spacing = 10

          let bottomStack = UIStackView(arrangedSubviews: [statusLbl, bottomLabel2])
          bottomStack.axis = .vertical
          bottomStack.spacing = 0
          bottomStack.distribution = .fillProportionally

          topView.addSubview(topStack)
          topView.addSubview(bottomStack)

          topStack.translatesAutoresizingMaskIntoConstraints = false
          bottomStack.translatesAutoresizingMaskIntoConstraints = false

          NSLayoutConstraint.activate([
              // Top horizontal labels
              topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
              topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
              topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
              topStack.heightAnchor.constraint(equalToConstant: 40),
              
              // Bottom vertical labels
              bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 0),
              bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
              bottomStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
              bottomStack.heightAnchor.constraint(equalToConstant: 70)
          ])
      }
    func fetchinventory()
    {
        print(self.getMakeList())
    }
    public func getMakeList()->[String]{
        return InventoryAPIManager.sharedInstance.getVariants() as! [String]
    }
    
    func loadbuylead()
    {
        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
        let parameters = [
            "action":"loadbuylead",
            "dealer_id":MyPodManager.user_id,
            "buylead_id":UserDefaults.standard.value(forKey: "buylead_id")!,
                "api_id":"cteolx2024v1.0"
        ] as! [String:Any]
        
        
        let api = ApiServices()
        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
            switch result {
            case .success(let data):
                print("Response Data: \(data)")
                if  let dic = data["data"] as? NSDictionary{
                    if(data["status"] as! String == "success"){
                        DispatchQueue.main.async {
                            if  let dic = data["data"] as? NSDictionary{
                                self.buyLeadData = (dic["buylead"] as! NSDictionary) as! [String : Any]
                                self.cars = (self.buyLeadData["cars"] as! NSArray) as! [Any]
                                self.logs = (dic["log"] as! NSArray) as! [Any]
                                
                                self.leadStatus[0] = .button(title: self.buyLeadData["status_category"] as? String ?? "",key:"clasification",ishidden: false)
                                self.leadStatus[1] = .button(title: self.buyLeadData["status"] as? String ?? "",key:"leadstatus",ishidden: false)
                                self.leadStatus[2] = .button(title: self.buyLeadData["substatus"] as? String ?? "",key:"leadsubstatus",ishidden: false)
                                self.leadStatus[3] = .textField(placeholder: "Date", text: self.buyLeadData["status_date"] as? String ?? "",ishidden: false)
                                self.leadStatus[5] = .textField(placeholder: "customer visited Date", text: self.buyLeadData["customer_visited"] as? String ?? "",ishidden: false)
                                self.leadStatus[6] = .textField(placeholder: "Note Against Status", text: self.buyLeadData["statustext"] as? String ?? "",ishidden: false)
                                self.tableView.reloadData()
                            }
                            else{
                                print(data)
                            }
                        }
                    }
                    else{
                        OnlineBuyLeads().refreshToken()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
              
            }
        }
    }
    
    // MARK: - TableView DataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return  leadStatus.count// Show content only when expanded
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                switch leadStatus[indexPath.row] {
                      case .textField(let placeholder, let text,let isvisible):
                    if(indexPath.row == 6){
                        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
                        cell.textField.placeholder = placeholder
                        cell.textField.text = text
                        cell.textChanged = { [weak self] updatedText in
                            self!.leadStatus[indexPath.row] = .textField(placeholder: placeholder, text: updatedText,ishidden: isvisible)
                        }
                        cell.selectionStyle = .none
                        return cell
                    }
                    else{
                            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath) as! DatePickerCell
                            cell.textField.placeholder = placeholder
                            cell.textField.text = text
                            cell.textChanged = { [weak self] updatedText in
                                self!.leadStatus[indexPath.row] = .textField(placeholder: placeholder, text: updatedText,ishidden: false)
                            }
                        cell.textField.tintColor = .clear
                            let imageView = UIImageView(image: UIImage(systemName: "calendar"))
                            imageView.tintColor = .gray
                            imageView.contentMode = .scaleAspectFit
                            imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
                            cell.textField.leftView = imageView
                            cell.textField.leftViewMode = .always
                            cell.selectionStyle = .none
                            return cell

                    }
                case .button(let title,_,_):
                    if(indexPath.row == 4)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath) as! CheckboxCell
                        cell.titleLabel.text = "Customer Visited"
                        cell.checkboxButton.isSelected = cell.isChecked
                        cell.checkboxButton.addTarget(self, action: #selector(togglecustomerVisited), for: .touchUpInside)
                        cell.checkboxButton.tag = indexPath.row
                        cell.selectionStyle = .none
                        return cell
                    }
                    if(indexPath.row == 7)
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath) as! CheckboxCell
                        cell.titleLabel.text = "Send sms to customer"
                        cell.selectionStyle = .none
                        cell.checkboxButton.isSelected = cell.isChecked
                        cell.checkboxButton.addTarget(self, action: #selector(togglesendsms), for: .touchUpInside)
                        cell.checkboxButton.tag = indexPath.row
                        return cell
                    }
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell

                    if(indexPath.row == 0){
                        cell.button.setTitle(title, for: .normal)
                        cell.titleLabel.text = "Lead Classification"
                        cell.titleLabel.isHidden = false
                        cell.button.addTarget(self, action: #selector(clasifiedsDropdown), for: .touchUpInside)
                    }
                    if(indexPath.row == 1){
                        cell.button.setTitle(title, for: .normal)
                        cell.titleLabel.text = "Lead Status"
                        cell.titleLabel.isHidden = false
                        cell.button.addTarget(self, action: #selector(leadstatusDropdown), for: .touchUpInside)
                        cell.button.tag = indexPath.row
                    }
                    if(indexPath.row == 2){
                        cell.button.setTitle(title, for: .normal)
                        cell.titleLabel.isHidden = false
                        cell.button.addTarget(self, action: #selector(subleadstatusDropdown), for: .touchUpInside)
                        cell.button.tag = indexPath.row
                    }
                    cell.button.tag = indexPath.row
                    cell.buttonAction = {
                    print("Submit tapped!")
                    }
                    cell.selectionStyle = .none
                    return cell
                      }
    }
   
    // MARK: - TableView Headers (Expandable Sections)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch leadStatus[indexPath.row] {
            case .textField(_, _,let visible):
                if(visible){
                    return 0
                }
                return UITableView.automaticDimension
            case .button(_,_,let visible):
                if(visible)
                {
                    return 0
                }
                return UITableView.automaticDimension
            }
    }
   

    // MARK: - Expand/Collapse Logic

    @objc func toggleSection(_ sender: UIButton) {
        for i in 0..<data.count{
            if(i == sender.tag)
            {
                data[i].isExpanded.toggle()
            }
            else{
                data[i].isExpanded = false
            }
            tableView.reloadData()
        }
      
    }
    
    
    public func getStatesList()->[String]{
        return InventoryAPIManager.sharedInstance.getstates() as! [String]
    }
    public func getCitiesList(state : String)->[String]{
        return InventoryAPIManager.sharedInstance.getCities(state: state) as! [String]
    }
    public func getleadstatus()->[String]{
        return InventoryAPIManager.sharedInstance.getleadStatus() as! [String]
    }
    public func getsubleadstatus(leadState : String)->[String]{
        return InventoryAPIManager.sharedInstance.getsubleads(leadstate: leadState ) as! [String]
    }
    
    @objc func togglesendsms(sender : UIButton){
    
        switch leadStatus[sender.tag] {
        case .textField(_, _,_):
            
            break
        case .button(_,_,_):
            
            print(sender.tag)
            if(sender.isSelected){
                self.leadStatus[sender.tag] = .button(title: "sendsmsStatus", key: "y", ishidden: false)
            }
            else{
                self.leadStatus[sender.tag] = .button(title: "sendsmsStatus", key: "n", ishidden: false)
            }
            break
        }
       
    }
    
    @objc func togglecustomerVisited(sender : UIButton){
     
        switch leadStatus[sender.tag+1] {
        case .textField(_, let text,_):
            print(sender.tag)
            if(sender.isSelected){
                self.leadStatus[sender.tag+1] = .textField(placeholder: "VisitedDate", text: text, ishidden: true)
                self.leadStatus[sender.tag] = .button(title: "customerVisitedstatus", key: "y", ishidden: false)

                let indexPath = IndexPath(row: sender.tag+1, section: 2)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            else{
                self.leadStatus[sender.tag+1] = .textField(placeholder: "VisitedDate", text: text, ishidden: true)
                self.leadStatus[sender.tag] = .button(title: "customerVisitedstatus", key: "n", ishidden: false)

                let indexPath = IndexPath(row: sender.tag+1, section: 2)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .button(_,_,_):
            break
        }
       
    }
    //list of classifieds
    @objc func clasifiedsDropdown(sender : UIButton) {
        self.view.resignFirstResponder()
           dropdown?.removeFromSuperview()
            let items = ["VERY HOT","HOT","WARM","COOL"]
            let buttonFrame = sender.convert(sender.bounds, to: view)
           let dropdownHeight: CGFloat = min(CGFloat(items.count) * 44, 300)
           let dropdownFrame = CGRect(x: buttonFrame.origin.x,
                                      y: buttonFrame.maxY-40,
                                      width: buttonFrame.width+30,
                                      height: dropdownHeight)
        dropdown = DropdownView(items: items,headertitle: "Select Classification", frame: dropdownFrame)
           dropdown?.onItemSelected = { selected in
               self.leadStatus[sender.tag] = .button(title: "\(selected)", key: "clasification",ishidden: false)
               sender.setTitle("\(selected)", for: .normal)
           }
           if let dropdown = dropdown {
               view.addSubview(dropdown)
           }
       }
    
    //list of leads
    @objc func leadstatusDropdown(sender : UIButton) {
        self.view.resignFirstResponder()
           dropdown?.removeFromSuperview()
        let items = self.getleadstatus()
            let buttonFrame = sender.convert(sender.bounds, to: view)
           let dropdownHeight: CGFloat = min(CGFloat(items.count) * 44, 300)
        let dropdownFrame = CGRect(x: buttonFrame.origin.x,
                                   y: buttonFrame.maxY-40,
                                   width: buttonFrame.width+30,
                                   height: dropdownHeight)
           dropdown = DropdownView(items: items,headertitle: "Select Lead Status", frame: dropdownFrame)
           dropdown?.onItemSelected = { selected in
               self.leadStatus[sender.tag] = .button(title: "\(selected)", key: "leadstatus",ishidden: false)
               sender.setTitle("\(selected)", for: .normal)
               self.subleads = self.getsubleadstatus(leadState: "\(selected)")
               if(self.subleads.count == 0){
                   self.leadStatus[sender.tag+1] = .button(title: "Select Lead SubStatus", key: "leadsubstatus",ishidden: true)
                   let indexPath = IndexPath(row: sender.tag+1, section: 2)
                   self.tableView.reloadRows(at: [indexPath], with: .automatic)
               }
               else{
                   self.leadStatus[sender.tag+1] = .button(title: "Select Lead SubStatus",key: "leadsubstatus",ishidden: false)
                   let indexPath = IndexPath(row: sender.tag+1, section: 2)
                   self.tableView.reloadRows(at: [indexPath], with: .automatic)
               }
           }
           if let dropdown = dropdown {
               view.addSubview(dropdown)
           }
       }
    
    //list of sublieads
    @objc func subleadstatusDropdown(sender : UIButton) {
        self.view.resignFirstResponder()
           dropdown?.removeFromSuperview()
        let items = self.subleads
            let buttonFrame = sender.convert(sender.bounds, to: view)
           let dropdownHeight: CGFloat = min(CGFloat(items.count) * 44, 300)
        let dropdownFrame = CGRect(x: buttonFrame.origin.x,
                                   y: buttonFrame.maxY-40,
                                   width: buttonFrame.width+30,
                                   height: dropdownHeight)
           dropdown = DropdownView(items: items,headertitle: "Select Lead SubStatus", frame: dropdownFrame)
           dropdown?.onItemSelected = { selected in
               self.leadStatus[sender.tag] = .button(title: "\(selected)",key: "leadsubstatus",ishidden: false)
               sender.setTitle("\(selected)", for: .normal)
           }
           if let dropdown = dropdown {
               view.addSubview(dropdown)
           }
       }
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        print("Update button tapped")
    }
    func getleadStatusValues() -> [String: String] {
        var result: [String: String] = [:]
        for row in leadStatus {
            switch row {
            case .textField(let placeholder, let text,_):
                result[placeholder] = text
            case .button(let text,let key,_):
                result[key] = text
                print(text)
                continue
            }
        }
        return result
    }
    
    
   @objc func updatebuylead()
    {
        print(getleadStatusValues())
        let buyleadstatusDic = getleadStatusValues()

//        let headers = ["x-origin-Panamera":"dev","Api-Version":"155","Client-Platform":"web","Client-Language":"en-in","Authorization":"Bearer \(MyPodManager.access_token)","Http-User-agent":"postman"] as! [String:String]
//        let parameters = [
//            "action":"updatebuylead",
//              "dealer_id":MyPodManager.user_id,
//              "api_id":"cteolx2024v1.0",
//             "device_id":"4fee41be780ae0e7",
//              "buylead_id":UserDefaults.standard.value(forKey: "buylead_id")!,
//            "state":dic["State"]!,
//            "name":dic["First Name"]!,
//            "mobile":dic["Mobile"]!,
//            "city":dic["City"]!,
//            "customer_visited":buyleadstatusDic["City"]!,
//            "status_date":buyleadstatusDic["City"]!,
//            "status":buyleadstatusDic["City"]!,
//            "substatus":buyleadstatusDic["City"]!,
//            "statustext":buyleadstatusDic["City"]!,
//            "status_category":buyleadstatusDic[""]!
//        ] as! [String:Any]
//
//        let api = ApiServices()
//        api.sendRawDataWithHeaders(parameters: parameters, headers: headers,url: Constant.OLXApi,authentication: "") { result in
//            switch result {
//            case .success(let data):
//                print("Response Data: \(data)")
//                if(data["status"] as! String == "success"){
//                    DispatchQueue.main.async {
//
//                    }
//                }
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//
//            }
//        }
    }
}
