//
//  NSArray+Extension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//

import UIKit

extension NSArray{

    func obj(at index:Int)->Element?{
        
        if index<self.count {
            return self[index]
        }
        return nil
    }

}

extension Array{
    func obj(at index:Int)->Element?{
        
        if index<self.count {
            return self[index]
        }
        return nil
    }
    
    mutating func removeObj(object: Element){
        let array = NSArray.init(array: self)
        let index = array.index(of: object)
        self.remove(at: index)
    }
    
    
    
    
}

extension Dictionary{
    
    func filterOptionalValue()->[String:Any]{
        if var dic = self as? [String:Any]{
            for (key,value) in dic {
                if let temp = value as? String{
                    dic[key] = temp
                }
                if let temp = value as? Int{
                    dic[key] = temp
                }
                
            }
            return dic
        }
        return [:]
    }
    func allKeys()->[String]{
        var temp:[String] =  []
        if let dic = self as? [String:Any]{
            for (key,_) in dic {
                temp.append(key)
            }
        }
        
        
        return temp
    }
}
