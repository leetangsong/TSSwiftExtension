//
//  String+Extension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//

import UIKit


public extension String{
    
    static func uuidString() -> String{
        let myUUID :CFUUID = CFUUIDCreate(nil)
        let UUIDString :CFString = CFUUIDCreateString(nil, myUUID)
        let resultString:String = CFStringCreateCopy(nil, UUIDString) as String
        
        return resultString.replacingOccurrences(of: "-", with: "").lowercased()
        
        
    }
    
    public  var isHtmlStr : Bool{
        let components = self.components(separatedBy: CharacterSet.init(charactersIn: "<>"))
        
        for str in components {
            if str.hasSuffix("html") || str.hasSuffix("!DOCTYPE") {
                return true
            }
        }
        
      return false
    }
    
    public var md5Str : String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
            return String(format: hash as String)
       
        
    }
    
    public var lenth : Int {
        return self.characters.count
    }

    public static func replaceUnicode(unicodeStr:String) -> String {
        let tempStr1 = unicodeStr.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\""+tempStr2+"\""
        let tempData = tempStr3.data(using: .utf8)
        
        let returnStr : String = try! PropertyListSerialization.propertyList(from: tempData!, options: .mutableContainers, format: nil) as! String
        
        
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
        
    }
    
    
    public func getSize(font:UIFont,constrainedToSize:CGSize) -> CGSize{
        var resultSize = CGSize.zero
        if self.lenth<=0 {
            return resultSize
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        let attributes : [String : Any] = [NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle]
        
        resultSize = NSString.init(string: self).size(attributes: attributes)
        
        return resultSize
    }
    
    
    public func getHeight(font:UIFont,constrainedToSize:CGSize) -> CGFloat{
        return self.getSize(font: font, constrainedToSize: constrainedToSize).height
    }
    
    public func getWidth(font:UIFont,constrainedToSize:CGSize) -> CGFloat{

        return self.getSize(font: font, constrainedToSize: constrainedToSize).width
    }
    
    public func encodeString() -> String {
        
        let encodedValue =  CFURLCreateStringByAddingPercentEscapes(nil,self as CFString, nil,"!*'();:@&=+$,/?%#[]" as CFString, CFStringBuiltInEncodings.UTF8.rawValue) as String
        
        return encodedValue
    }
    
    ///通过下标获取
    ///
    /// - Parameter r: [开始下标,结束下标]
    subscript (r: ClosedRange<Int>) -> String{
        get{
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return self[startIndex...endIndex]
            
        }
    }
    ///通过下标获取
    ///
    /// - Parameter r: [下标]
    subscript (r:Int) -> Character{
        get{
            let startIndex = self.index(self.startIndex, offsetBy: r)
            return self[startIndex]
            
        }
    }
    
    func jsonStringFilter()->String{
        var str_Json = NSString.init(string: self)
        str_Json = str_Json.replacingOccurrences(of: "(\\\\)", with: "\\\\\\\\", options: [NSString.CompareOptions.regularExpression], range: NSMakeRange(0, str_Json.length)) as NSString
        str_Json = str_Json.replacingOccurrences(of: "(\r)", with: "\\\\r", options: [NSString.CompareOptions.regularExpression], range: NSMakeRange(0, str_Json.length)) as NSString
        str_Json = str_Json.replacingOccurrences(of: "(\n)", with: "\\\\n", options: [NSString.CompareOptions.regularExpression], range: NSMakeRange(0, str_Json.length)) as NSString
        return str_Json as String
    }
  
    
    
    
}



