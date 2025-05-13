import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekSelector extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;

  const WeekSelector({
    super.key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onNextPressed,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_back_ios), onPressed: onBackPressed),
        Expanded(
          child: SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final isSelected = DateFormat('yyyy-MM-dd').format(date) ==
                    DateFormat('yyyy-MM-dd').format(selectedDate);

                return GestureDetector(
                  onTap: () => onDateSelected(date),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 11, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('E').format(date),
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black)),
                        const SizedBox(height: 5),
                        Text(DateFormat('d').format(date),
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: onNextPressed),
      ],
    );
  }
}
