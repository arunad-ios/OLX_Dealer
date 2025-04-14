//
//  CTEExtensions.swift
//  ObjAndSwift
//
//  Created by sivakoti guttula on 16/11/23.
//

import Foundation
import UIKit

extension UIApplication {
    
    class  func topViewController(_ viewController: UIViewController? =  UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
//        if let slide = viewController as? SlideMenuController {
//            return topViewController(slide.mainViewController)
//        }
        return viewController
    }
}
//extension UILabel {
////    class var localisedText:UILabel{
////        let label = UILabel()
////        label.text = LocalisationManager.localisedString(self.text)
////        return label
////    }
//    
//    
//    public var localisedText: String? {
//        get {
//            return self.text
//        }
//        set {
//            self.text = LocalisationManager.localisedString(newValue!)
//        }
//    }
//
//}
extension UIColor {
    
    class  var OLXBlueColor : UIColor {
        return UIColor(red: 23.0/255.0, green: 73.0/255.0, blue: 152.0/255.0, alpha: 1.0)
    }
    class  var CTERedColor: UIColor {
        return UIColor(red: 0.0/255.0, green: 57.0/255.0, blue: 111.0/255.0, alpha: 1.0)
    }
    class   var CTEGreenColor: UIColor {
        return UIColor(red: 41.0/255.0, green: 138.0/255.0, blue: 8.0/255.0, alpha: 1.0)
    }
    class   var CTEBlueColor: UIColor {
        return UIColor(red: 3.0/255.0, green: 142.0/255.0, blue: 216.0/255.0, alpha: 1.0)
    }
    class   var AARedColor: UIColor {
        return UIColor(red: 175.0/255.0, green: 1.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    }
    class   var AABlueColor: UIColor {
        return UIColor(red: 0.0/255.0, green: 57.0/255.0, blue: 111.0/255.0, alpha: 1.0)
    }
    class   var AAGrayColor: UIColor {
        return UIColor(red: 137.0/255.0, green: 137.0/255.0, blue: 137.0/255.0, alpha: 1.0)
    }

    class   var AAGreenColor: UIColor {
        return UIColor(red: 34.0/255.0, green: 150.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }
    class   var AAOrangeColor: UIColor {
        return UIColor(red: 215.0/255.0, green: 137.0/255.0, blue: 21.0/255.0, alpha: 1.0)
    }

}

extension UIImage {
    static func named(_ name: String) -> UIImage? {
        return UIImage(named: name, in: .buyLeadsBundle, compatibleWith: nil)
    }
}

@objc extension UIFont {
    
    class  func RobotoBold(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: fontsize)!
    }
    class  func RobotoLite(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: fontsize)!
    }
    class  func RobotoRegular(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: fontsize)!
    }
    class  func RobotoRegularItalic(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Italic", size: fontsize)!
    }
    class  func RobotoLiteItalic(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-LightItalic", size: fontsize)!
    }
    class  func RobotoCondRegular(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "RobotoCondensed-Regular", size: fontsize)!
    }
    class  func RobotoMedium(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: fontsize)!
    }
    class  func RobotoMediumItalic(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-MediumItalic", size: fontsize)!
    }
    class  func RobotoItalic(fontsize : CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Italic", size: fontsize)!
    }
    
}
extension UIImage {
    func tinted(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }

        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        let rect = CGRect(origin: .zero, size: size)

        context.setBlendMode(.normal)
        context.draw(cgImage, in: rect)

        context.setBlendMode(.sourceIn)
        context.fill(rect)

        let coloredImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
        UIGraphicsEndImageContext()

        return coloredImage
    }
}
extension String {
    
//    func validateNullString(checkstr: String?) -> String {
//        var returnstr: String? = "\(checkstr!)"
//        if (returnstr?.count) == 0 || (returnstr == "<null>") || (returnstr?.isEqual(NSNull()))! || returnstr == nil {
//            returnstr = ""
//        }
//        return returnstr!
//    }
    
    func checkValidationBasedOnRegexAngText(text:String , regex:String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: text)
    }
    
    func isValidEmail(emailStr: String) -> Bool {
        //   let stricterFilter: Bool = false
        let stricterFilterString: String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
      //  let stricterFilterString: String =  "(?!.*?\\.\\.)[a-z0-9A-Z.-_]{2,70}@[a-zA-Z][a-z0-9A-Z.-_]{1,70}.[a-zA-Z]{2,10}"
        // let laxString: String = ".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*"
        // let emailRegex: String = stricterFilter ? stricterFilterString : laxString
        let emailTest = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
        return emailTest.evaluate(with: emailStr)
    }
    
    func isValidPanCardNumber(cardNumber: String) -> Bool {
        let emailRegex: String = "[A-Z]{3}P[A-Z]{1}[0-9]{4}[A-Z]{1}"
        let cardTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return cardTest.evaluate(with: cardNumber)
    }
    
    func isValidateRegistrationNumber1(regNumber:String) -> Bool {
        let regRegex: String = "^[A-Z]{2}[0-9]{1}[a-zA-Z0-9]{5,30}"
        let cardTest = NSPredicate(format: "SELF MATCHES %@", regRegex)
        return cardTest.evaluate(with: regNumber)

    }
    
    func isValidateRegistrationNumber(regNumber:String) -> Bool {
        let regRegex: String = "^[a-zA-Z0-9]{5,11}"
      //  let regRegex: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,11}$"
        let cardTest = NSPredicate(format: "SELF MATCHES %@", regRegex)
        return cardTest.evaluate(with: regNumber)
        
    }

//        func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
//
//            return ceil(boundingBox.height)
//        }
//
//        func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
//            let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
//
//            return ceil(boundingBox.width)
//        }

    
}

//extension Data {
//    
//    func setImagePropertiesOfdata(from image: UIImage?,imagemetaData metadata: NSDictionary!) -> Data? {
//        let data = NSMutableData()
//        let imageDestinationRef = CGImageDestinationCreateWithData(data as CFMutableData, kUTTypeJPEG, 1, nil)!
//        CGImageDestinationAddImage(imageDestinationRef, (image?.cgImage!)!, metadata)
//               CGImageDestinationFinalize(imageDestinationRef)
//               return data as Data
//    }
//    
//    func gpsMetaDataDictionary() -> [AnyHashable : Any]? {
//        
//        var locDict: [AnyHashable : Any] = [:]
//
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
//        formatter.locale = Locale(identifier: "en_US")
//
//        let capture_time = formatter.string(from: date)
//        locDict[kCGImagePropertyGPSTimeStamp as String] = "\(capture_time)"
//        locDict[kCGImagePropertyGPSLatitude as String] = "\(Constant.myappdelegate.userLatitued ?? 0)"
//        locDict[kCGImagePropertyGPSLongitude as String] = "\(Constant.myappdelegate.userLongitude ?? 0)"
//        
//        return locDict
//    }
//
//}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812
    
    static let IS_IPHONE_X_AND_MORE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH >= 812
    
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1366.0
    static let IS_IPHONE_XSMAX      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 2688
    static let IS_IPHONE_XR         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1792
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
