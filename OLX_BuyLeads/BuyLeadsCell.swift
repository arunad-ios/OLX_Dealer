//
//  BuyLeadsCell.swift
//  CTE_BuyLeads
//
//  Created by Aruna on 25/03/25.
//

import Foundation
import UIKit

public class BuyLeadsCell: UITableViewCell {
    
    @IBOutlet var contact_name: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 22)
        label.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        return label
    }()
    
    @IBOutlet var status_text: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        return label
    }()
    @IBOutlet  var make: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        return label
    }()
    @IBOutlet var Inquiredcars: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor(red: 0/255.0, green: 42/255.0, blue: 57/255.0, alpha: 1.0)
        return label
    }()
    @IBOutlet var chatButton: UIButton! = {
        let button = UIButton(type: .custom)
        if let image = UIImage(named: "uncheck.svg") {
            print("Image loaded successfully")
            button.setImage(image, for: .normal)
        } else {
            print("Failed to load image")
        }
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = true
        return button
    }()
    @IBOutlet var visitedBtn: UIButton! = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = true
        return button
    }()
    public func configure(with contactname: String,statustext: String,make_text:String ) {
        contact_name.text = contactname
        status_text.text = statustext
        make.text = make_text
        Inquiredcars.text = "Inquired Cars"
    }
}
