
 class TodayWeekCalendarIndexEvent{
   var _pageIndex;
   var _weekIndex;


   TodayWeekCalendarIndexEvent(this._pageIndex, this._weekIndex);

   get weekIndex => _weekIndex;

   get pageIndex => _pageIndex;

   @override
   String toString() {
     return 'TodayWeekCalendarIndexEvent{_pageIndex: $_pageIndex, _weekIndex: $_weekIndex}';
   }


 }