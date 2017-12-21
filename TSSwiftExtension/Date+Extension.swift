//
//  Date+Extension.swift
//  TSSwiftExtension
//
//  Created by 李棠松 on 2017/12/21.
//  Copyright © 2017年 李棠松. All rights reserved.
//

import Foundation

public extension Date{
    //    static let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.chinese)!
    private static let calendar = Calendar.current
    private static let displayFormatter =  DateFormatter()
    
    
    ///一周的星期几
    public  var weekday : Int {
        return  Date.calendar.dateComponents([.weekday], from: self).weekday!
    }
    
    /// 获取当前日期的年
    public var year : Int {
        return Date.calendar.dateComponents([.year], from: self).year!
    }
    /// 获取当前日期的月
    public  var month : Int {
        
        return  Date.calendar.dateComponents([.month], from: self).month!
    }
    /// 获取当前日期的日
    public  var day : Int {
        
        return  Date.calendar.dateComponents([.day], from: self).day!
    }
    /// 获取当前日期的小时
    public  var hour : Int {
        
        return  Date.calendar.dateComponents([.hour], from: self).hour!
    }
    /// 获取当前日期的分钟
    public  var minute : Int {
        return  Date.calendar.dateComponents([.minute], from: self).minute!
    }
    /// 获取当前日期的秒
    public  var second : Int {
        return  Date.calendar.dateComponents([.second], from: self).second!
    }
    /// 该月有多少天
    public var daysCountInMonth : Int {
        return Date.getDaysInMonth(year: self.year, month: self.month)
    }
    /// 该年的第几周
    public  var weekOfYear : Int{
        return Date.calendar.dateComponents([.weekOfYear], from: self).weekOfYear!
    }
    /// 该月的第几周
    public  var weekOfMonth : Int{
        return Date.calendar.dateComponents([.weekOfMonth], from: self).weekOfMonth!
    }
    
    public  var weeksOfYear : Int{
        return Date.calendar.range(of: .weekOfYear, in: .year, for: self)!.count
    }
    /// 日期格式化
    ///
    /// - Parameters:
    ///   - from: 日期字符串
    ///   - format: 格式
    /// - Returns: Date
    public static func stringTodate (from : String , format : String) -> Date {
        Date.displayFormatter.dateFormat = format;
        let date = Date.displayFormatter.date(from: from)
        assert(date != nil,"格式不正确")
        return date!
    }
    
    /// 日期转字符串
    ///
    /// - Parameter format: 格式
    /// - Returns: String
    public  func dateToString (format : String) -> String {
        Date.displayFormatter.dateFormat = format
        return Date.displayFormatter.string(from: self)
        
    }
    
    /// 日期转字符串
    ///
    /// - Parameters:
    ///   - from: 要转换的日期
    ///   - format: 格式
    /// - Returns: String
    public static func dateToString (from : Date , format : String) -> String {
        return from.dateToString(format: format)
    }
    
    /// 获取日期当前周 开始的日期
    
    public var startOfWeek : Date {
        
        var componentsToSubtract = DateComponents()
        componentsToSubtract.day = -self.weekday+2
        if self.weekday == 1 {
            componentsToSubtract.day = -6
        }
        let startOfWeek = Date.calendar.date(byAdding: componentsToSubtract, to: self)
        return startOfWeek!
    }
    
    /// 获取日期当前周 结束的日期
    
    public var endOfWeek : Date {
        var componentsToSubtract = DateComponents()
        //        if self.weekday==2 && self.month == 12 {
        //            componentsToSubtract
        //        }
        componentsToSubtract.day = -self.weekday+2+6
        if self.weekday == 1 {
            componentsToSubtract.day = 0
        }
        let endOfWeek = Date.calendar.date(byAdding: componentsToSubtract, to: self)
        return endOfWeek!
    }
    //
    
    
    /// 获取指定月的天数
    ///
    /// - Parameters:
    ///   - year: year
    ///   - month: month
    /// - Returns: return Int
    public static func getDaysInMonth (year : Int , month : Int) -> Int{
        
        return calendar.range(of: .day, in: .month, for: Date.stringTodate(from: "\(year)-\(month)", format: "yyyy-MM"))!.count;
        
        
    }
    /// 日期差
    ///
    /// - Parameters:
    ///   - date1: date1
    ///   - date2: date2
    /// - Returns: return int
    public static func getDaysDifferent (date1 : Date , date2 : Date) -> Int {
        var temp1 = date1
        temp1 = temp1.changeHour(hour: 0)
        temp1 = temp1.changeMinute(minute: 0)
        temp1 = temp1.changeSecond(second:0)
        
        var temp2 = date2
        temp2 = temp2.changeHour(hour: 0)
        temp2 = temp2.changeMinute(minute: 0)
        temp2 = temp2.changeSecond(second:0)
        return Date.calendar.dateComponents([.day], from: temp1, to: temp2).day!
        
    }
    
    //CST时间字符串转日期
    public static func CSTTimeToDate (CST:String) -> Date? {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale.init(identifier: "en_US")
        inputFormatter.dateFormat = "EEE MMM dd HH:mm:ss 'CST' yyyy"
        
        return inputFormatter.date(from: CST)
    }
    
    
    ///更换年数
    func changeYear(year: Int) -> Date {
        var yearFormat = ""
        for _ in  0..<"\(year)".count{
            yearFormat += "y"
        }
        let dataStr = "\(year)-\(self.month)-\(self.day) \(self.hour):\(self.minute):\(self.second)"
        return Date.stringTodate(from: dataStr, format: "\(yearFormat)-MM-dd HH:mm:ss")
    }
    ///更换月
    func changeMonth(month: Int) -> Date {
        var monthFormat = ""
        for _ in  0..<"\(month)".count{
            monthFormat += "M"
        }
        let dataStr = "\(self.year)-\(month)-\(self.day) \(self.hour):\(self.minute):\(self.second)"
        return Date.stringTodate(from: dataStr, format: "yyyy-\(monthFormat)-dd HH:mm:ss")
    }
    ///更换天数
    func changeDay(day: Int) -> Date {
        var dayFormat = ""
        for _ in  0..<"\(day)".count{
            dayFormat += "d"
        }
        let dataStr = "\(self.year)-\(self.month)-\(day) \(self.hour):\(self.minute):\(self.second)"
        return Date.stringTodate(from: dataStr, format: "yyyy-MM-\(dayFormat) HH:mm:ss")
    }
    ///更换小时数
    func changeHour(hour: Int) -> Date {
        var hourFormat = ""
        for _ in  0..<"\(hour)".count{
            hourFormat += "H"
        }
        let dataStr = "\(self.year)-\(self.month)-\(self.day) \(hour):\(self.minute):\(self.second)"
        return Date.stringTodate(from: dataStr, format: "yyyy-MM-dd \(hourFormat):mm:ss")
    }///更换分钟数
    func changeMinute(minute: Int) -> Date {
        var minuteFormat = ""
        for _ in  0..<"\(minute)".count{
            minuteFormat += "m"
        }
        let dataStr = "\(self.year)-\(self.month)-\(self.day) \(self.hour):\(minute):\(self.second)"
        return Date.stringTodate(from: dataStr, format: "yyyy-MM-dd HH:\(minuteFormat):ss")
    }
    ///更换秒数
    func changeSecond(second: Int) -> Date {
        var secondFormat = ""
        for _ in  0..<"\(second)".count{
            secondFormat += "s"
        }
        let dataStr = "\(self.year)-\(self.month)-\(self.day) \(self.hour):\(self.minute):\(second)"
        return Date.stringTodate(from: dataStr, format: "yyyy-MM-dd HH:mm:\(secondFormat)")
    }
    
    /// 根据周获取开始日期和结束日期
    ///
    /// - Parameters:
    ///   - week: 周数
    ///   - year: 年数
    /// - Returns: (开始时间,结束时间)
    public static func getWeekTimeBeginEnd(week:Int,year:Int) -> (startDate:Date,endDate:Date) {
        //week当中的一天
        let weekDate = Date.stringTodate(from: "\(year)-01-01", format: "yyyy-MM-dd").addingTimeInterval(TimeInterval((week-1)*7*24*60*60))
        
        return (weekDate.startOfWeek,weekDate.endOfWeek)
    }
    
}
