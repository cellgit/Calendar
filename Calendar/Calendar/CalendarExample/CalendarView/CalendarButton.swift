//
//  CalendarButton.swift
//  ZJYIAEducation
//
//  Created by liuhongli on 2020/9/23.
//  Copyright © 2020 freedom HOU. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarButton: UIButton {
    
    
    open var imageContentMode: UIView.ContentMode = .center {
        didSet {
            imgView.contentMode = imageContentMode
        }
    }
    
    private lazy var imgView = UIImageView.init()
    
    override var isSelected: Bool {
        didSet {
            
        }
    }
    
    private var calendarView: JTACMonthView!
    
    convenience init(imageName: String, tag: Int, calendarView: JTACMonthView) {
        
        self.init(frame: .zero)
        self.calendarView = calendarView
        self.customButton(imageName: imageName, tag: tag)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(0xF8F8F8)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customButton(imageName: String, tag: Int) {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.px
        self.layer.masksToBounds = true
//        let imgView = UIImageView.init(image: UIImage.init(named: imageName))
        imgView.image = UIImage.init(named: imageName)
        self.addSubview(imgView)
        imgView.image = UIImage.init(named: imageName)
        imgView.isUserInteractionEnabled = false
        
        self.tag = tag
        imgView.tag = tag
        
        addAction()
        
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        imgView.contentMode = .center
    }
    
    func addAction() {
        self.addTarget(self, action: #selector(senderAction(sender:)), for: .touchUpInside)
    }
    
    
    @objc func senderAction(sender: UIButton) {
        switch self.tag { // self.tag == 0 前一页, self.tag == 1 下一页
        case 0:
            calendarView.scrollToSegment(.previous, triggerScrollToDateDelegate: true, animateScroll: true, extraAddedOffset: 0, completionHandler: nil)
        case 1:
            calendarView.scrollToSegment(.next, triggerScrollToDateDelegate: true, animateScroll: true, extraAddedOffset: 0, completionHandler: nil)
        default:
            break
        }
    }

}
