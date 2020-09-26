//
//  Int+Extension.swift
//  Calendar
//
//  Created by 刘宏立 on 2020/9/26.
//

import UIKit
import Foundation

enum Platform {
    case iPad
    case iPhone
}

let platform: Platform = {
    #if PAD
    return .iPad
    #else
    return .iPhone
    #endif
}()



extension Int {
    var px: CGFloat {
        switch platform {
        case .iPad:
            return UIScreen.main.bounds.width / 1024.0 * (CGFloat(self))
        case .iPhone:
            return UIScreen.main.bounds.width / 750.0 * (CGFloat(self))
        }
    }
}
