import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarModel extends StatelessWidget {
  
  const CalendarModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      //dataSource: ,
      showNavigationArrow: true,
      firstDayOfWeek: 1,
      initialSelectedDate: DateTime.now(),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      cellBorderColor: Colors.grey,
      selectionDecoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Theme.of(context).iconTheme.color!,
          width: 1.5,
        ),
      ),
      todayHighlightColor: Theme.of(context).iconTheme.color,
      viewHeaderStyle: ViewHeaderStyle(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        dayTextStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      headerStyle: CalendarHeaderStyle(
        textStyle: Theme.of(context).textTheme.displayLarge,
        textAlign: TextAlign.center,
      ),
      view: CalendarView.month,
      monthViewSettings: MonthViewSettings(
        showAgenda: true,
        showTrailingAndLeadingDates: false,
        monthCellStyle: MonthCellStyle(
          textStyle: TextStyle(
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
        ),
        agendaStyle: AgendaStyle(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          dateTextStyle: Theme.of(context).textTheme.displayLarge,
          dayTextStyle: TextStyle(
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
        ),
      ),
    );
  }
}
