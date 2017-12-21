//
//  UIImageExtension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//

import UIKit

public extension UIImage {
   
    public  func image(color:UIColor) -> UIImage{
    
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let  context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.setBlendMode(.normal)
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context!.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    
    public  static func image(color:UIColor) -> UIImage {
         let rect = CGRect.init(x: 0, y: 0, width: 1.0, height:1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return newImage
    }
    
    public  func imageToNewSize(size:CGSize) -> UIImage {
        
        let maxLength = 500*1024
        let compression: CGFloat = 1
        var data = UIImageJPEGRepresentation(self, compression)
        if data!.count < maxLength{
            return self
        }
        var resultImage = UIImage.init(data: data!)
        var lastDataLength = 0
        while data!.count > maxLength && data!.count != lastDataLength{
            lastDataLength = data!.count
            let ratio = Float(maxLength) / Float(data!.count)
            let size = CGSize.init(width: Int(resultImage!.size.width * CGFloat(sqrtf(ratio))), height: Int(resultImage!.size.height * CGFloat(sqrtf(ratio))))
            
            UIGraphicsBeginImageContext(size)
            resultImage?.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            data = UIImageJPEGRepresentation(resultImage!, compression)
        }
        
        return resultImage!
        
    }
    
    
    /// 根据设定最大值压缩图片返回二进制
    ///
    /// - Parameter maxLength: 最大值
    /// - Returns: 二进制
    @objc func compress(maxLength: Int) -> Data{
        
        var compression: CGFloat = 1
        var data = UIImageJPEGRepresentation(self, compression) ?? UIImageJPEGRepresentation(UIImage(), compression)!
        guard data.count > maxLength || data.count < 150*1024 else { return data }
        var max: CGFloat = 1
        var min: CGFloat = 0
        while (data.count > maxLength || data.count < 150*1024) {
            compression = (max + min) / 2
            data = UIImageJPEGRepresentation(self.imageToNewWidth(self.size.width*compression), compression) ?? UIImageJPEGRepresentation(UIImage(),compression)!
            if CGFloat(data.count)<CGFloat(maxLength)*0.9 {
                min = compression
            }else if data.count > maxLength{
                max = compression
            }
        }
        
        return data
        
    }
    
    public  func imageToNewWidth(_ newWidth: CGFloat) -> UIImage {
        
        let imageWidth = self.size.width
        let imageHeight = self.size.height
        let width = newWidth
        let height = imageHeight/(imageWidth/width)
        let widthScale = imageWidth/width
        let heightScale = imageHeight/height
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: width, height: height), false, UIScreen.main.scale)
        if widthScale > heightScale {
            self.draw(in: CGRect.init(x: 0, y: 0, width: imageWidth/heightScale, height: height))
        }else{
            self.draw(in: CGRect.init(x: 0, y: 0, width: width, height: imageHeight/widthScale))
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }
  
    
   
//    public func addwaterStain(text: String)-> UIImage{
//        let size = 18*self.size.width/Screen_Width
//        let font = UIFont.systemFont(ofSize: size)
//        let dic = [NSFontAttributeName:font,NSForegroundColorAttributeName:HexColor(hex: "#f7a715")]
//        let textSize = NSString.init(string: text).boundingRect(with: CGSize.init(width: self.size.width, height: 999), options: .usesLineFragmentOrigin, attributes: dic, context: nil).size
//        UIGraphicsBeginImageContext(self.size)
//        self.draw(in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height))
//        let  border:CGFloat = 20
//        let re = CGRect.init(origin: CGPoint.init(x: border, y: self.size.height - textSize.height - border), size: textSize)
//        NSString.init(string: text).draw(in: re, withAttributes: dic)
//
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//
//        UIGraphicsEndImageContext()
//        return newImage
//    }
}


