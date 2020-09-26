//
//  WeekDayString.swift
//  Calendar
//
//  Created by 刘宏立 on 2020/9/26.
//

import Foundation

enum LanguageMode {
    case simpleChinese
    case traditionalChinese
    case english
}

struct WeekDayString {
    public static func day(_ day: Int, _ language: LanguageMode) -> String {
        switch language {
        case .english:
            return WeekDayString.dayWithEnglish(day)
        default:
            return WeekDayString.dayWithChinese(day)
        }
    }
    
    private static func dayWithChinese(_ day: Int) -> String {
        switch day {
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
    
    private static func dayWithEnglish(_ day: Int) -> String {
        switch day {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tus"
        case 4:
            return "Wed"
        case 5:
            return "Tur"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return ""
        }
    }
}

