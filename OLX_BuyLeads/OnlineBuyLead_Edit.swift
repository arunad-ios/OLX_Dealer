//
//  OnlineBuyLead_Edit.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 03/04/25.
//

import Foundation
import UIKit


enum FieldType {
    case textField(placeholder: String)
    case textView(placeholder: String)
    case dropdown(options: [String])

}

struct SectionModel {
    let title: String
    var isExpanded: Bool
    let type: SectionType

}
enum SectionType {
    case form
    case custom
}
class VehicleinfoCell: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.text = ""
        label.numberOfLines = 0
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
class HistoryCell: UITableViewCell {
    let dateLabel = UILabel()
    let followupLabel = UILabel()
    let hotLabel = UILabel()
    let notesLabel = UILabel()
    let remarksLabel = UILabel()
    
    let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func setupViews() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.OLXBlueColor.cgColor
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = UIColor.systemBackground
        
        dateLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        followupLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        hotLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        hotLabel.textColor = .systemRed
        notesLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        remarksLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        notesLabel.numberOfLines = 0
        remarksLabel.numberOfLines = 0
        
        contentView.addSubview(containerView)
        [dateLabel, followupLabel, hotLabel, notesLabel, remarksLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            followupLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            followupLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            hotLabel.centerYAnchor.constraint(equalTo: followupLabel.centerYAnchor),
            hotLabel.leadingAnchor.constraint(equalTo: followupLabel.trailingAnchor, constant: 8),
            
            notesLabel.topAnchor.constraint(equalTo: followupLabel.bottomAnchor, constant: 8),
            notesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            remarksLabel.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 8),
            remarksLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            remarksLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
}

class TextFieldCell: UITableViewCell, UITextFieldDelegate {

    let textField = UITextField()
    var textChanged: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.borderStyle = .roundedRect
        contentView.addSubview(textField)
        textField.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])

        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }

    @objc func textDidChange(_ sender: UITextField) {
        textChanged?(sender.text ?? "")
    }

    required init?(coder: NSCoder) { fatalError() }
}
class DatePickerCell: UITableViewCell,UITextFieldDelegate {
    
    let textField = UITextField()
    let datePicker = UIDatePicker()
    var textChanged: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        textField.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        setupDatePicker()
    }
    @objc func textDidChange(_ sender: UITextField) {
        textChanged?(sender.text ?? "")
    }
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

        // Assign date picker to the textField inputView
        textField.inputView = datePicker

        // Optional: toolbar with done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([done], animated: false)
        textField.inputAccessoryView = toolbar
    }

    @objc private func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        textField.text = formatter.string(from: sender.date)
    }

    @objc private func doneTapped() {
        textField.resignFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class CheckboxCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let checkboxButton = UIButton(type: .system)
    
    var isChecked = false {
        didSet {
            let imageName = isChecked ? "check" : "uncheck"
            checkboxButton.setImage(UIImage(named: imageName, in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkboxButton)
        
        // Setup
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.setImage(UIImage(named: "uncheck", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)

        titleLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        titleLabel.textColor = .black
        // Layout
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        checkboxButton.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        isChecked = false
    }
    
    @objc private func toggleCheck() {
        isChecked.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ButtonCell: UITableViewCell {
    let button = UIButton(type: .system)
    var buttonAction: (() -> Void)?
    var imgView = UIImageView()
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

       // contentView.addSubview(button)
      //  contentView.addSubview(titleLabel)
        
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        
      //  imgView.translatesAutoresizingMaskIntoConstraints = false
      //  imgView.image = UIImage(named: "downarrow", in: .buyLeadsBundle, compatibleWith: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
      //  button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        button.contentHorizontalAlignment = .leading
        
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        contentView.addSubview(containerView)
        
        
        imgView = UIImageView(image: UIImage(named: "downarrow", in: .buyLeadsBundle, compatibleWith: nil))
        imgView.tintColor = .systemYellow
        imgView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imgView)
        
     
        containerView.addSubview(button)

        // Optional: style container
        containerView.backgroundColor =  UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        containerView.layer.cornerRadius = 5
        
        
        NSLayoutConstraint.activate([
            // Container in center of main view
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            containerView.heightAnchor.constraint(equalToConstant: 40),

            // Image at top center
           // imgView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            imgView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            imgView.widthAnchor.constraint(equalToConstant: 30),
            imgView.heightAnchor.constraint(equalToConstant: 30),
         //   imgView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            // Button at bottom
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-30),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

        ])
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, containerView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)

        ])
    
    }

    @objc func didTap() {
        buttonAction?()
    }

    required init?(coder: NSCoder) { fatalError() }
}



struct FormField {
    var placeholder: String
    var value: String
}
enum FormCellType {
    case label(String)
    case textField(placeholder: String, text: String)
    case textView(text: String)
    case button(title: String)
    case checkbox(title: String, isChecked: Bool)
}
enum FormRow {
    case textField(placeholder: String, text: String,ishidden : Bool)
    case button(title: String,key : String,ishidden : Bool)
    
}

//edit Buylead

class OnlineBuyLead_Edit : UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    
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
    let updateButton = UIButton(type: .system)
    
    
    // Top Horizontal Labels
        let contactname = UILabel()
        let contactnumber = UILabel()
        let closeBtn = UIButton()
        
        // Bottom Vertical Labels
        let statusLbl = UILabel()
        let bottomLabel2 = UILabel()

    private let tableView = UITableView()
  
    
 var formData: [FormRow] = [
    .textField(placeholder: "First Name", text: "",ishidden: false),
    .textField(placeholder: "Email", text: "",ishidden: false),
    .textField(placeholder: "Mobile Number", text: "",ishidden: false),
    .button(title: "Select State",key: "State",ishidden: false),
    .button(title: "Select City",key:"City",ishidden: false)
]
    
    
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
        self.title = "Edit Buy Lead"
        data = [
                   SectionModel(title: "Customer Details", isExpanded: false, type: .form),
                   SectionModel(title: "Vehicle Details", isExpanded: false,type: .custom),
                   SectionModel(title: "Lead Status", isExpanded: false,type: .form),
                   SectionModel(title: "Lead History", isExpanded: true,type: .custom)
               ]
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back_arrow", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBArButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBArButton
        
        
        self.setupViews()
        self.setupLayout(topviewheight: 100)
        self.loadbuylead()
    }
    @objc func backButtonTapped()
    {
            self.navigationController?.popViewController(animated: true)
    }
    func setupViews() {
           // Top View
           self.view.backgroundColor = .white
        topView.backgroundColor = .white
           view.addSubview(topView)

           // TableView
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
           view.addSubview(tableView)
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
           view.addSubview(updateButton)
       }

    func setupLayout(topviewheight : CGFloat) {
           topView.translatesAutoresizingMaskIntoConstraints = false
           tableView.translatesAutoresizingMaskIntoConstraints = false
           updateButton.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
               // Top View
               topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               topView.heightAnchor.constraint(equalToConstant: topviewheight),

               // Bottom Button
               updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
               updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               updateButton.heightAnchor.constraint(equalToConstant: 50),

               // TableView
               tableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
               tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: updateButton.topAnchor, constant: -12)
           ])
           self.setupLabels()
           self.layoutLabels()
       }
    @objc func closeTopView() {
        self.setupLayout(topviewheight: 0)
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
        let boldFont = UIFont(name: "Roboto-Bold", size: 12)
        let regular = UIFont(name: "Roboto-Regular", size: 12)

        
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
          bottomStack.spacing = 5
          bottomStack.distribution = .fillProportionally

          topView.addSubview(topStack)
          topView.addSubview(bottomStack)

          topStack.translatesAutoresizingMaskIntoConstraints = false
          bottomStack.translatesAutoresizingMaskIntoConstraints = false

          NSLayoutConstraint.activate([
              // Top horizontal labels
              topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
              topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
              topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
              topStack.heightAnchor.constraint(equalToConstant: 40),
              
              // Bottom vertical labels
              bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 0),
              bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
              bottomStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
              bottomStack.heightAnchor.constraint(equalToConstant: 100)
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
                                
                                self.formData[0] = .textField(placeholder: "First Name", text: self.buyLeadData["name"] as? String ?? "",ishidden: false)
                                self.formData[1] = .textField(placeholder: "Mobile", text: self.buyLeadData["mobile"] as? String ?? "",ishidden: false)
                                self.formData[2] = .textField(placeholder: "Enter Email", text: self.buyLeadData["email"] as? String ?? "",ishidden: false)
                                self.formData[3] = .button(title: self.buyLeadData["state"] as? String ?? "",key : "State",ishidden: false)
                                self.formData[4] = .button(title: self.buyLeadData["city"] as? String ?? "",key : "City",ishidden: false)
                         
                                
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
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return data[section].isExpanded ? cars.count : 0 // Show content only when expanded
        }
        if(section == 3){
            return data[section].isExpanded ? logs.count : 0 // Show content only when expanded
        }
        if(section == 0){
            return data[section].isExpanded ? formData.count : 0 // Show content only when expanded
        }
        return data[section].isExpanded ? leadStatus.count : 0 // Show content only when expanded
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = data[indexPath.section].type
        switch sectionType {
        case .form:
            if(indexPath.section == 2){
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
//                        if(cell.isChecked)
//                        {
//                        self.leadStatus[indexPath.row+1] = .button(title: "",ishidden: true)
//                            let indexPath = IndexPath(row: indexPath.row+1, section: indexPath.section)
//                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
//                        }
//                        else{
//                            self.leadStatus[indexPath.row+1] = .button(title: "",ishidden: false)
//                            let indexPath = IndexPath(row: indexPath.row+1, section: indexPath.section)
//                            self.tableView.reloadRows(at: [indexPath], with: .automatic)
//                        }
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
                switch formData[indexPath.row] {
                      case .textField(let placeholder, let text,let visible):
                          let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
                          cell.textField.placeholder = placeholder
                          cell.textField.text = text
                          cell.textChanged = { [weak self] updatedText in
                              self?.formData[indexPath.row] = .textField(placeholder: placeholder, text: updatedText,ishidden: visible)
                          }
                          return cell
                        case .button(let title,_,_):
                          let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
                          cell.button.setTitle(title, for: .normal)
                    if(indexPath.row == 3){
                        cell.button.removeTarget(self, action: #selector(showcitiesDropdown), for: .touchUpInside)
                        cell.button.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
                        cell.titleLabel.isHidden = true
                    }
                    if(indexPath.row == 4){
                        cell.button.removeTarget(self, action: #selector(showDropdown), for: .touchUpInside)
                        cell.button.addTarget(self, action: #selector(showcitiesDropdown), for: .touchUpInside)
                        cell.titleLabel.isHidden = true
                    }
                    cell.button.tag = indexPath.row
                          cell.buttonAction = {
                              print("Submit tapped!")
                              // Access formData to get the values
                          }
                    cell.selectionStyle = .none
                          return cell
                      }
            
        case .custom:
            if(indexPath.section == 3){
                let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
                let dic = logs[indexPath.row] as! NSDictionary
                cell.dateLabel.text = "\(dic["updated_date_time"] as! String)"
                cell.followupLabel.text = "\(dic["status"] as! String)"
                cell.hotLabel.text = "\(dic["lead_classification"] as! String)"
                cell.hotLabel.textColor = "\(dic["lead_classification"] as! String)".contains("HOT") ? .systemRed : .systemBlue
                cell.notesLabel.text = "Notes: \(dic["notes"] as! String)"
                cell.remarksLabel.text = "Remarks: \(dic["notes"] as! String)"
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleinfoCell", for: indexPath) as! VehicleinfoCell
            let dic = cars[indexPath.row] as! NSDictionary
            cell.label.text = "\(dic["make"] as! String)"
            cell.selectionStyle = .none
            return cell
            
        }
    }
   
    // MARK: - TableView Headers (Expandable Sections)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section == 2){
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
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1.0)
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 10, width: tableView.frame.width - 50, height: 30))
        titleLabel.text = data[section].title
        titleLabel.textColor = UIColor.OLXBlueColor
        headerView.addSubview(titleLabel)

        let expandButton = UIButton(frame: CGRect(x: tableView.frame.width - 40, y: 10, width: 30, height: 30))
        expandButton.setImage(UIImage(named: expandedSections.contains(section) ? "uparrow" : "downarrow_new", in: .buyLeadsBundle, compatibleWith: nil), for: .normal)
        expandButton.addTarget(self, action: #selector(toggleSection(_:)), for: .touchUpInside)
        expandButton.tag = section
        headerView.addSubview(expandButton)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
    
    //list of states
    @objc func showDropdown(sender : UIButton) {
        self.view.resignFirstResponder()
           dropdown?.removeFromSuperview()
            let items = self.getStatesList()
            let buttonFrame = sender.convert(sender.bounds, to: view)
           let dropdownHeight: CGFloat = min(CGFloat(items.count) * 44, 300)
        let dropdownFrame = CGRect(x: buttonFrame.origin.x,
                                   y: buttonFrame.maxY-40,
                                   width: buttonFrame.width+30,
                                   height: dropdownHeight)
           dropdown = DropdownView(items: items,headertitle: "Select State", frame: dropdownFrame)
           dropdown?.onItemSelected = { selected in
               self.formData[sender.tag] = .button(title: "\(selected)",key: "State",ishidden: false)
               sender.setTitle("\(selected)", for: .normal)
               self.Cities = self.getCitiesList(state: "\(selected)")
           }
           if let dropdown = dropdown {
               view.addSubview(dropdown)
           }
       }
    //list of cities
    @objc func showcitiesDropdown(sender : UIButton) {
           self.view.resignFirstResponder()
           dropdown?.removeFromSuperview()
             let items = self.Cities
            let buttonFrame = sender.convert(sender.bounds, to: view)
           let dropdownHeight: CGFloat = min(CGFloat(items.count) * 44, 300)
            let dropdownFrame = CGRect(x: buttonFrame.origin.x,
                                   y: buttonFrame.maxY-40,
                                   width: buttonFrame.width+30,
                                   height: dropdownHeight)
           dropdown = DropdownView(items: items,headertitle: "Select City", frame: dropdownFrame)
           dropdown?.onItemSelected = { selected in
               self.formData[sender.tag] = .button(title: "\(selected)",key: "City",ishidden: false)
               sender.setTitle("\(selected)", for: .normal)
           }
           if let dropdown = dropdown {
               view.addSubview(dropdown)
           }
       }
 
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        print("Update button tapped")
    }
    
    func getFormValues() -> [String: String] {
        var result: [String: String] = [:]
        for row in formData {
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
        print(getFormValues())
        print(getleadStatusValues())
        let dic = getFormValues()
        let buyleadstatusDic = getFormValues()

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
