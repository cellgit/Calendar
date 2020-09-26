//
//  ViewController.swift
//  Calendar
//
//  Created by 刘宏立 on 2020/9/26.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var calendarButton: UIButton = {
        let b = UIButton.init(type: .custom)
        b.setTitle("Calendar", for: .normal)
        b.backgroundColor = UIColor.systemTeal
        return b
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        initialUI()
        
    }
    
    func initialUI() {
        
        calendarButton.addTarget(self, action: #selector(calendarAction(sender:)), for: .touchUpInside)
        
        view.addSubview(calendarButton)
        calendarButton.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(100)
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
    }
    
    
    @objc func calendarAction(sender: UIButton) {
        let vc = CalendarViewController.init()
        
        let nav = UINavigationController.init(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }


}

