//
//  Constant.swift
//  InventorySwift
//
//  Created by Vikram on 10/08/24.
//


import Foundation
import UIKit
struct Constant {
    static let OLXApi = "https://fcgapi.olx.in/dealer/mobile_api"
    //  static let OLXApi = "https://testolxapi4.cartradeexchange.com/mobile_api"
    static let uuid = UIDevice.current.identifierForVendor?.uuidString
}

extension UIColor {
    static let appPrimary = UIColor(red: 23.0/255.0, green: 73.0/255.0, blue: 152.0/255.0, alpha: 1.0)
    static let appSecondary = UIColor(named: "AppSecondary") ?? UIColor.gray
}
