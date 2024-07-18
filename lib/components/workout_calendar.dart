import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super90/controller/achivement_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutCalenderWidget extends StatelessWidget {
  final DopamineController dopamineController = Get.put(
      DopamineController(DateTime.now().toIso8601String().split('T')[0]));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Map<DateTime, bool>>(
        future: dopamineController.getWorkoutData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final workoutData = snapshot.data!;
            return TableCalendar(
              calendarFormat: CalendarFormat.month,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (workoutData.containsKey(date) && workoutData[date]!) {
                    return Positioned(
                      right: 1,
                      bottom: 1,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              availableGestures: AvailableGestures.all,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
            );
          }
        },
      ),
    );
  }
}
