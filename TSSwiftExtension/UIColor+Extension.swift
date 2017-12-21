//
//  UIColor+Extension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//
import UIKit
import Foundation

public extension UIColor{

    public static func colorHex(hex:String,alpha:Float) -> UIColor{
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if  cString.count<6 {
            return UIColor.clear
        }
        
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        if  cString.count != 6 {
            return UIColor.clear
        }
        
        let rStr = cString[0...1]
        let gStr = cString[2...3]
        let bStr = cString[4...5]
        
        var  r:CUnsignedInt = 0,g:CUnsignedInt = 0,b:CUnsignedInt = 0
        Scanner.init(string: rStr).scanHexInt32(&r)
        Scanner.init(string: gStr).scanHexInt32(&g)
        Scanner.init(string: bStr).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
        
    }
    
    public static func colorHex(hex:String) -> UIColor{
        return  self.colorHex(hex: hex, alpha: 1.0)
    }
}
