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
        label.textColor = .black
        return label
    }()
    
    @IBOutlet var status_text: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textColor = .black
        return label
    }()
    @IBOutlet  var make: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .black
        return label
    }()
    @IBOutlet var Inquiredcars: UILabel! = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .black
        return label
    }()
  
    public func configure(with contactname: String,statustext: String,make_text:String ) {
        contact_name.text = contactname
        status_text.text = statustext
        make.text = make_text
        Inquiredcars.text = "Inquired Cars"
    }
}
