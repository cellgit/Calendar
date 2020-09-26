//
//  UIView+Animation.swift
//  Calendar
//
//  Created by 刘宏立 on 2020/9/26.
//

import UIKit

extension UIView {
    func bounce() {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.1,
                       options: UIView.AnimationOptions.beginFromCurrentState,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
}

