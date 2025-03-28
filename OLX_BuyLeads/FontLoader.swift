//
//  FontLoader.swift
//  OLX_BuyLeads
//
//  Created by Chandini on 26/03/25.
//

import Foundation
import UIKit

public class FontLoader {
    public static func registerFont(withName name: String) {
        guard let fontURL = Bundle(for: FontLoader.self).url(forResource: name, withExtension: "ttf") else {
            print("⚠️ Font \(name) not found in bundle!")
            return
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            print("⚠️ Failed to load font: \(name)")
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("⚠️ Error registering font: \(error.debugDescription)")
        } else {
            print("✅ Font \(name) registered successfully!")
        }
    }
}
