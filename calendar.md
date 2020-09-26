### 2. JTAppleCalendar Class Renamed

```
JTApplecalendarView           --&gt; JTACMonthView 
JTAppleCalendarViewDelegate   --&gt; JTACMonthViewDelegate 
JTAppleCalendarViewDataSource --&gt; JTACMonthViewDataSource 
JTAppleDayCell                --&gt; JTACMonthCell 
JTAppleCollectionReusableView --&gt; JTACMonthReusableView
```



### 2. JTAppleCalendar Delegate Renamed

```
func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool 
func calendar(_ calendar: JTACMonthView, shouldDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool
func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
func calendar(_ calendar: JTACMonthView, didHighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
func calendar(_ calendar: JTACMonthView, didUnhighlightDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath)
func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo)
func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo)
func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView
func calendarDidScroll(_ calendar: JTACMonthView)
func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize?
func sizeOfDecorationView(indexPath: IndexPath) -> CGRect
func scrollDidEndDecelerating(for calendar: JTACMonthView)
```