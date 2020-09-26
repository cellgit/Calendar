//
//  CalendarViewController.swift
//  Calendar
//
//  Created by 刘宏立 on 2020/9/26.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.cornerRadius = 8
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var calendarView = CalendarView.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        initialUI()
    }
    
    func initialUI() {
        view.addSubview(contentView)
        contentView.addSubview(calendarView)
        contentView.backgroundColor = .white
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.left.equalTo(view).offset(40.px)
            $0.right.equalTo(view).offset(-40.px)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(130.px)
        }
        
        calendarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        contentView.snp.updateConstraints {_ in
            //
        }
    }
    
    override func viewWillLayoutSubviews() {
        contentView.snp.updateConstraints {_ in
            //
        }
    }
    

}
