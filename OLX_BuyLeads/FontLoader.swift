//
//  FontLoader.swift
//  OLX_BuyLeads
//
//  Created by Aruna on 26/03/25.
//

import Foundation
import UIKit

public class FontLoader {
    public static func registerFonts() {
           let fontNames = ["Roboto-Black", "Roboto-BlackItalic","Roboto-Bold","Roboto-BoldItalic","Roboto-Italic","Roboto-Light","Roboto-Medium","Roboto-Regular","Roboto-Thin","Roboto-ThinItalic"] // Add your font names here

           for fontName in fontNames {
               registerFont(withName: fontName)
           }
       }
    public static func registerFont(withName name: String) {
        guard let fontURL = Bundle(for: FontLoader.self).url(forResource: name, withExtension: "ttf") else {
            return
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
        } else {
        }
    }
}
