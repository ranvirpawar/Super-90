import 'package:flutter/material.dart';
import 'package:super90/components/workout_calendar.dart';

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WorkoutCalenderWidget(),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Profile'),
    ));
  }
}
