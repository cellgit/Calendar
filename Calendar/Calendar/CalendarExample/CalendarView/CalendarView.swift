//
//  CalendarView.swift
//  iPad
//
//  Created by liuhongli on 2020/9/21.
//  Copyright © 2020 freedom HOU. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SwifterSwift

@objc
protocol CalendarViewDelegate {
    func selectItemAction(cell: DateCell?, date: Date)
}

class CalendarView: UIView {
    
    weak private var delegate: CalendarViewDelegate?
    
    /// 选中的可见的星期几索引
    private var selectedIndexOfWeek: Int = 0
    
    lazy var calendarView = JTACMonthView()
    
    let outsideMonthColor = UIColor.init(0x999999)
    let monthColor = UIColor.init(0x333333)
    let selectedMonthColor = UIColor.init(0x666666)
    let currentDateSelectedViewColor = UIColor.white
    
    private var formatter = DateFormatter()
    
    private let todaysDate = Date()
    
    private var selectedDates = [Date]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        calendarView.register(nibWithCellClass: DateCell.self)
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        calendarView.allowsMultipleSelection = false
        calendarView.selectDates(selectedDates)
        calendarView.selectDates(selectedDates, triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: false)
        
//        let startDate = startOfCurrentMonth()
//        let endDate = endOfCurrentMonth()
        
        let startDate = startOfMonth(year: (Date().year - 1), month: Date().month)
        let endDate = endOfMonth(year: (Date().year + 1), month: Date().month)

        calendarView.deselectDates(from: startDate, to: endDate, triggerSelectionDelegate: true)
        calendarView.scrollDirection = .horizontal
//        calendarView.minimumLineSpacing = 0.5
//        calendarView.minimumInteritemSpacing = 0.5

        calendarView.isPagingEnabled = true
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.showsVerticalScrollIndicator = false
        self.addSubview(calendarView)
        calendarView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(64+30)
            $0.right.equalTo(self.snp.right).offset(-64-30)
            $0.top.bottom.equalTo(self)
        }
        
        calendarView.backgroundColor = UIColor.init(white: 0, alpha: 0)
        
        calendarButton()
    }
}

extension CalendarView {
    func calendarButton() {
        let previousBtn = CalendarButton.init(imageName: "class_search_l", tag: 0, calendarView: calendarView)
        self.addSubview(previousBtn)
        previousBtn.backgroundColor = UIColor.init(white: 0, alpha: 0)
        previousBtn.imageContentMode = .left
        let nextBtn = CalendarButton.init(imageName: "class_search_r", tag: 1, calendarView: calendarView)
        self.addSubview(nextBtn)
        nextBtn.backgroundColor = UIColor.init(white: 0, alpha: 0)
        nextBtn.imageContentMode = .right
        
        previousBtn.snp.makeConstraints {
            $0.right.equalTo(calendarView.snp.left)
            $0.centerY.equalTo(calendarView)
            $0.height.equalTo(calendarView)
            $0.width.equalTo(64)
        }
        nextBtn.snp.makeConstraints {
            $0.left.equalTo(calendarView.snp.right)
            $0.centerY.equalTo(calendarView)
            $0.height.equalTo(calendarView)
            $0.width.equalTo(64)
        }
    }
}

extension CalendarView: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        calendar.scrollToDate( Date(), animateScroll: false)
//        let startDate = startOfCurrentMonth()
//        let endDate = endOfCurrentMonth()
        
        let startDate = startOfMonth(year: (Date().year - 1), month: Date().month)
        let endDate = endOfMonth(year: (Date().year + 1), month: Date().month)
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 1, calendar: .autoupdatingCurrent, generateInDates: .forFirstMonthOnly, generateOutDates: .off, firstDayOfWeek: .monday, hasStrictBoundaries: false)
    }
}

extension CalendarView: JTACMonthViewDelegate{
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
    }

    // 设置单元格
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell: DateCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        cell.cellState = cellState
        

        handleCellVisibility(cell: cell, cellState: cellState)
        handleCellTextColor(cell: cell, cellState: cellState)
        return cell
    }
    // 选中单元格
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        cell?.bounce()    // 动画
        self.selectedIndexOfWeek = selectedIndexOfWeek(weekday: cellState.day.rawValue - 1)
    }
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        //
    }
    func calendarDidScroll(_ calendar: JTACMonthView) {}
    func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {}
    /// 滚动的单元格
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        if visibleDates.monthDates.count > self.selectedIndexOfWeek {
            let date = visibleDates.monthDates[self.selectedIndexOfWeek].date
            
            if let date1 = selectedDates.first, date1 == date {
                return
            }
            else {
                selectedDates.removeAll()
                selectedDates.append(date)
                calendarView.selectDates(selectedDates)
            }
        }
    }
    
    /// 选中的索引
    func selectedIndexOfWeek(weekday: Int) -> Int {
        switch weekday {
        case 1:
            return 0
        case 2:
            return 1
        case 3:
            return 2
        case 4:
            return 3
        case 5:
            return 4
        case 6:
            return 5
        case 0:
            return 6
        default:
            return 0
        }
    }
    
    func handleCellVisibility(cell:DateCell?, cellState:CellState) {
        cell?.isHidden = cellState.dateBelongsTo == .thisMonth ? false : false
        cell?.isUserInteractionEnabled = cellState.dateBelongsTo == .thisMonth ? true : false
        cell?.dateLabel.textColor = cellState.dateBelongsTo == .thisMonth ? monthColor : outsideMonthColor
        cell?.weekLabel.textColor = cellState.dateBelongsTo == .thisMonth ? monthColor : outsideMonthColor
    }
    
    func handleCellTextColor(cell: DateCell?, cellState: CellState) {
        formatter.dateFormat = "yyyy MM dd"
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        if todaysDateString == monthDateString {
            cell?.dateLabel.textColor = UIColor.init(0x13BB74)
            cell?.weekLabel.textColor = UIColor.init(0x13BB74)
        }
        else {
            // 日期可能在本月之内和之外
            let monthColorOptional = cellState.dateBelongsTo == .thisMonth ? monthColor : outsideMonthColor
            cell?.dateLabel.textColor = cellState.isSelected ? selectedMonthColor : monthColorOptional
            cell?.weekLabel.textColor = cellState.isSelected ? selectedMonthColor : monthColorOptional
            
            if cellState.dateBelongsTo == .thisMonth {
                switch cellState.day.rawValue {
                case 1,7:
                    cell?.dateLabel.textColor = UIColor.init(0x999999)
                    cell?.weekLabel.textColor = UIColor.init(0x999999)
                default:
                    cell?.dateLabel.textColor = UIColor.init(0x333333)
                    cell?.weekLabel.textColor = UIColor.init(0x333333)
                }
            }
        }
    }
}


extension CalendarView {
    //指定年月的开始日期
    func startOfMonth(year: Int, month: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        guard let startDate = calendar.date(from: startComps) else { return Date() }
        return startDate
    }
    //指定年月的结束日期
    func endOfMonth(year: Int, month: Int, returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        guard let endOfYear =  calendar.date(byAdding: components, to: startOfMonth(year: year, month: month), wrappingComponents: true) else { return Date() }
        return endOfYear
    }
    
    //本月开始日期
    func startOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
     
    //本月结束日期
    func endOfCurrentMonth(returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        let endOfMonth =  calendar.date(byAdding: components, to: startOfCurrentMonth())!
        return endOfMonth
    }
}

