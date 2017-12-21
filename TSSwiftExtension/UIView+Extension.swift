//
//  UIView+Extension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//

import UIKit
public extension UIView {
    
   
    
    func addShadow(color: UIColor = .gray,
                   opacity: Float = 0.4,
                   offset: CGSize = CGSize.init(width: 0, height: 1),
                   radius: CGFloat = 3){
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset  = offset// 阴影的范围
        self.layer.shadowRadius = radius
    }
    
    public var ts_origin : CGPoint {
        get{
            return  self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    public var ts_x : CGFloat {
        get{
            return  self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var ts_y : CGFloat {
        get{
            return  self.frame.origin.y
        }
        set{
            
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    
    public var ts_maxX : CGFloat {
        get{
            return  self.ts_x+self.ts_width
        }
    }
    
    public var ts_maxY : CGFloat {
        get{
            return  self.ts_y+self.ts_height
        }
        
    }
    
    public var ts_width : CGFloat {
        get{
            return  self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var ts_height : CGFloat {
        get{
            return  self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var ts_size : CGSize {
        get{
            return  self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    
    public var ts_centerX : CGFloat {
        get{
            return  self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    public var ts_centerY : CGFloat {
        get{
            return  self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    //寻找键盘
    func haveKeyBoardWindow() -> Bool{
        let windows = UIApplication.shared.windows
        for window in windows {
            if NSStringFromClass(type(of: window)) == "UIRemoteKeyboardWindow" {
                return true
            }
        }
        
        return false
    }
}
extension CALayer{
    
    enum GradientDirection {
        case horizontal
        case vertical
    }
    
    public var ts_origin : CGPoint {
        get{
            return  self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    public var ts_x : CGFloat {
        get{
            return  self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var ts_y : CGFloat {
        get{
            return  self.frame.origin.y
        }
        set{
            
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var ts_width : CGFloat {
        get{
            return  self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var ts_height : CGFloat {
        get{
            return  self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var ts_size : CGSize {
        get{
            return  self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    
    
    
   
    
    func rounding(corners: UIRectCorner, cornerRadii:CGSize,color: UIColor){
        let maskPath = UIBezierPath(roundedRect:self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.mask = maskLayer
        
        //添加border
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.bounds
        borderLayer.path = maskPath.cgPath
        borderLayer.lineWidth = 0.5
        borderLayer.strokeColor = color.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        let layers = self.sublayers!
        
        if layers.last!.isKind(of: CAShapeLayer.self) {
            layers.last?.removeFromSuperlayer()
        }
        self.addSublayer(borderLayer)
        
    }
    
    
    
}





