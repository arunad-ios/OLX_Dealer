//
//  Buyleads.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 25/03/25.
//

import Foundation
import CoreData
import UIKit

@objc public protocol HostAppToPodDelegate {
    func sendDataToPod(data: [String:Any])
    func navigateToHostApp(item: [String:Any])

    
}
public class MyPodManager {
    public static var userinfo = [String:Any]()
    public static var delegate: HostAppToPodDelegate?

    public static func requestDataFromHost(userinfo : [String:Any]) {
        self.userinfo = userinfo
        delegate?.sendDataToPod(data: userinfo)
    }
    public static func navigatetoHost(userinfo : [String:Any]) {
        delegate?.navigateToHostApp(item: userinfo)
    }
    
}

public class SDKAlertManager {
    public static func showAlert() {
        guard let topVC = UIApplication.shared.windows.first?.rootViewController else {
            print("No root view controller found")
            return
        }
        let alert = UIAlertController(title: "SDK Alert", message: "Hello from SDK!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
}

public  class Inventory{
    
    public var user_id = ""
    public init(){}
    public func printMessage(messageString:String){
        print(messageString + "from CTE_Buyleads Framework ")
    }
    
    @objc func receiveData(_ notification: Notification) {
        if let data = notification.userInfo?["data"] as? String {
            print("Pod received data from Host App: \(data)")
        }
    }
}


