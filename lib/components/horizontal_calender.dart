import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class HorizontalCalendar extends StatefulWidget {
  final Function(DateTime) onSelected;

  HorizontalCalendar({required this.onSelected});

  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  final calendarPageController = PageController(initialPage: 1);
  List<List<DateTime>> dateList = [];
  String scrollMonthYear = "";
  DateTime selectedDate = DateTime.now();

  void initCalendar() {
    final now = DateTime.now();
    scrollMonthYear = DateFormat('MMMM, yyyy').format(now);
    setState(() {});

    DateTime lastMonday = now;
    // Get last Monday
    for (int i = 0; i < 7; i++) {
      final previousDate = now.subtract(Duration(days: i));
      if (previousDate.weekday == DateTime.monday) {
        lastMonday = previousDate;
        break;
      }
    }

    // Get last week
    List<DateTime> lastWeekDateList = [];
    for (int i = 0; i < 7; i++) {
      final date = lastMonday.add(Duration(days: i - 7));
      lastWeekDateList.add(date);
    }
    dateList.add(lastWeekDateList);

    // Get current week
    List<DateTime> thisWeekDateList = [];
    for (int i = 0; i < 7; i++) {
      final date = lastMonday.add(Duration(days: i));
      thisWeekDateList.add(date);
    }
    dateList.add(thisWeekDateList);

    // Get next week
    List<DateTime> nextWeekDateList = [];
    for (int i = 0; i < 7; i++) {
      final date = lastMonday.add(Duration(days: i + 7));
      nextWeekDateList.add(date);
    }
    dateList.add(nextWeekDateList);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initCalendar();
      calendarPageController.addListener(() {
        if (calendarPageController.page == (dateList.length - 1)) {
          getNextWeek();
        }
        if (calendarPageController.page == 0) {
          getPreviousWeek();
        }
      });
    });
  }

  void getNextWeek() {
    final lastMonday = dateList[dateList.length - 1][0];

    // Get next week
    List<DateTime> nextWeekDateList = [];
    for (int i = 0; i < 7; i++) {
      final date = lastMonday.add(Duration(days: i + 7));
      nextWeekDateList.add(date);
    }
    dateList.add(nextWeekDateList);
    setState(() {});
    calendarPageController.jumpToPage(dateList.length - 2);
  }

  void getPreviousWeek() {
    final lastMonday = dateList[0][0];
    List<DateTime> lastWeekDateList = [];
    for (int i = 0; i < 7; i++) {
      final date = lastMonday.add(Duration(days: i - 7));
      lastWeekDateList.add(date);
    }
    dateList.insert(0, lastWeekDateList);
    setState(() {});
    calendarPageController.jumpToPage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scrollMonthYear,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 60,
          child: PageView.builder(
            controller: calendarPageController,
            itemCount: dateList.length,
            onPageChanged: (page) {
              scrollMonthYear =
                  DateFormat('MMMM, yyyy').format(dateList[page].last);
              setState(() {});
            },
            itemBuilder: (context, i) {
              final currentSelectedDate = DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day
              );
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: dateList[i].map(
                    (date) => GestureDetector(
                      onTap: () {
                        selectedDate = date;
                        widget.onSelected(selectedDate);
                        setState(() {});
                      },
                      child: CalenderItemWidget(
                        date: date,
                        isSelected: DateTime(
                          date.year, date.month, date.day
                        ).isAtSameMomentAs(currentSelectedDate),
                      ),
                    ),
                  ).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CalenderItemWidget extends StatelessWidget {
  const CalenderItemWidget({
    super.key,
    required this.date,
    this.isSelected = false,
  });

  final DateTime date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.blue : Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${date.day}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            DateFormat('E').format(date),
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}