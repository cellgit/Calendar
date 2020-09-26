//
//  DateCell.swift
//  SWPlayer
//
//  Created by liuhongli on 2020/9/18.
//  Copyright © 2020 lhl. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SwifterSwift

class DateCell: JTACDayCell {
    
    struct DateCellConst {
        static let selectViewHeightConst: CGFloat = 90.px
        static let selectViewWidthConst: CGFloat = 60.px
    }
    
    let outsideMonthColor = ThemeColor.lightGray
    let monthColor = UIColor.white//UIColor.init(0x333333)
//    let selectedMonthColor = UIColor.init(0x666666)
    let selectedMonthColor = UIColor.white
    let currentDateSelectedViewColor = UIColor.white
    
    
    open var cellState: CellState? {
        didSet {
            guard let cellState = cellState else { return }
            self.update(cellState: cellState)
        }
    }
    
    func update(cellState: CellState) {
        weekLabel.text = WeekDayString.day(cellState.day.rawValue, .simpleChinese)
        
        if cellState.date.day == 1 {
//            dateLabel.text = cellState.text + "/\(cellState.date.month.string)月"
            dateLabel.text = "\(cellState.date.month.string)月"
        }
        else {
            dateLabel.text = cellState.text
        }
        tipViewDisplay(state: cellState.day.rawValue % 3)
    }
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var selectViewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var selectViewWidthConst: NSLayoutConstraint!
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                UIView.animate(withDuration: 0.38, animations: {
                    self.selectedView.layer.borderColor = ThemeColor.green.cgColor
                    self.selectedView.backgroundColor = ThemeColor.orange
                    self.dateLabel.textColor = .white
                    self.weekLabel.textColor = .white
                    if let cellState = self.cellState {
                        self.handleCellTextColor(cellState: cellState)
                    }
                }, completion: nil)
            }
            else {
                UIView.animate(withDuration: 0.38, animations: {
                    self.selectedView.backgroundColor = UIColor.init(white: 0, alpha: 0)//UIColor.init(0xF7F7F7)
                    self.selectedView.layer.borderColor = UIColor.clear.cgColor
                    self.selectedView.layer.borderWidth = 0.0
                    self.dateLabel.textColor = .black
                    self.weekLabel.textColor = .black
                    if let cellState = self.cellState {
                        self.handleCellTextColor(cellState: cellState)
                    }
                }, completion: nil)
            }
        }
    }
    
    func tipViewDisplay(state: Int) {
        switch state {
        case 0: // 完成
            tipView.backgroundColor = ThemeColor.green
        case 1: // 未完成
            tipView.backgroundColor = ThemeColor.orange
        case 2: // 无作业
            tipView.backgroundColor = ThemeColor.tinyGray
        default:
            break
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        selectedView.backgroundColor = UIColor.init(white: 0, alpha: 0)
        selectViewHeightConst.constant = DateCellConst.selectViewHeightConst
        selectViewWidthConst.constant = DateCellConst.selectViewWidthConst
        
        tipView.layer.cornerRadius = tipView.bounds.width / 2
        tipView.layer.masksToBounds = true
        selectedView.layer.cornerRadius = DateCellConst.selectViewWidthConst / 2
        selectedView.layer.masksToBounds = true
    }
    
    /// 设置当天的颜色
    func handleCellTextColor(cellState: CellState) {
        let todaysDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        if todaysDateString == monthDateString {
            if self.isSelected == true {
                self.dateLabel.textColor = .white
                self.weekLabel.textColor = .white
            }
            else {
                self.dateLabel.textColor = ThemeColor.green
                self.weekLabel.textColor = ThemeColor.green
            }
        }
        else {
            if self.isSelected == true {
                self.dateLabel.textColor = .white
                self.weekLabel.textColor = .white
            }
            else {
                switch cellState.day.rawValue {
                case 1,7:
                    self.dateLabel.textColor = ThemeColor.lightGray
                    self.weekLabel.textColor = ThemeColor.lightGray
                default:
                    self.dateLabel.textColor = ThemeColor.gray
                    self.weekLabel.textColor = ThemeColor.gray
                }
            }
        }
    }

}
