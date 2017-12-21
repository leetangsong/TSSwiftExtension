//
//  NSObject+Extension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//

import UIKit
extension NSObject{
     func getPropertyNameList () -> [String]{
        //保存属性的个数
        var outCount : UInt32 = 0
        //保存属性名称的数组
        var list : [String] = []
        
        //获取属性集合
        let property = class_copyPropertyList(type(of:self), &outCount)
        //解包
        guard let propertyList = property else {
            return list
        }
        
        for i in 0 ..< Int(outCount){
            //取出单个属性
            let property = propertyList[i]
            
            //获取属性的名字
            guard let char_f = property_getName(property) else{
                continue
            }
            //转换为String
            
            if let key = NSString.init(cString: char_f, encoding: String.Encoding.utf8.rawValue) {
                //添加到数组
                
                list.append(key as String)
            }
        }
        return list
    }
    
}


extension NSObject{
    public func objEncode(with aCoder: NSCoder) {
        //获取当前类的所有属性名
        let nameList = getPropertyNameList()
        //进行归档
        for key in nameList{
            //KVC取值
            if let value = value(forKey: key){
                ////归档.此处注意归档的方法中要使用带 forKey参数的
                aCoder.encode(value, forKey: key)
            }
        }
    }
    public func objDeEncode(coder aDecoder: NSCoder) {
        //获取当前类的所有属性名
        let nameList = getPropertyNameList()
        //进行解档
        for key in nameList{
            //从aDecoder中取值
            let value = aDecoder.decodeObject(forKey: key)
            //赋值给自己
            setValue(value, forKey: key)
        }
    }
    
    
    
    
}
