//
//  UILabel+Extension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//

import UIKit
private var UILabelIsCopyable = "UILabelIsCopyable"
extension UILabel{
    func iconText(iconStr:String){
        let str: String = "\\U"+iconStr
        let textStr = String.replaceUnicode(unicodeStr: str)
        self.text = textStr
    }
    
    var isCopyable: Bool{
        get{
            return objc_getAssociatedObject(self, &UILabelIsCopyable) as? Bool ?? {
                self.isCopyable = false
                return false
                }()
        }
        set{
            if newValue == true {
                self.attachTapHandler()
            }
            return objc_setAssociatedObject(self, &UILabelIsCopyable, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private func attachTapHandler(){
        self.isUserInteractionEnabled = true
        let g = UILongPressGestureRecognizer.init(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(g)
    }
    
    @objc private func handleTap(){
        if UIMenuController.shared.isMenuVisible != true{
            self.becomeFirstResponder()
            let item = UIMenuItem.init(title: "复制", action: #selector(copyText))
            UIMenuController.shared.menuItems = [item]
            UIMenuController.shared.setTargetRect(self.frame, in: self.superview!)
            UIMenuController.shared.setMenuVisible(true, animated: true)
            
        }
        
    }
    open override var canBecomeFirstResponder: Bool{
        return true
    }
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if [#selector(copyText)].contains(action) {
            return true
        }
        return false
    }
    @objc private func copyText(){
        let pBoard = UIPasteboard.general
        if self.text != nil {
            pBoard.string = self.text
        } else {
            pBoard.string = self.attributedText?.string
        }
    }
}
