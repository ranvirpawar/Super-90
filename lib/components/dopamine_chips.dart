import 'package:flutter/material.dart';
import 'package:super90/controller/achivement_controller.dart';

class DopamineChips extends StatelessWidget {
  const DopamineChips({
    super.key,
    required this.achievementController,
    required this.title,
    required this.isSelected,
  });
  final String title;
  final DopamineController achievementController;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        onSelected: (bool selected) {
          if (title == 'Workout') {
            achievementController.toggleWorkout();
          } else if (title == 'Healthy Diet') {
            achievementController.toggleHealthyDiet();
          } else if (title == 'Reading') {
            achievementController.toggleReading();
          }
        },
      ),
    );
  }
}
