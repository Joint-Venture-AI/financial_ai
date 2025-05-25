import 'package:financial_ai_mobile/core/utils/app_styles.dart'; // For AppStyles.colors
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// If your controller's expenseCategoryList contains items of a specific model type,
// (e.g., class ExpenseItem { String category; int percent; ... })
// you should import that model and use List<ExpenseItem> instead of List<dynamic>.
// For this example, we'll assume items are dynamic with 'category' and 'percent' fields.

class PieChartSample2 extends StatefulWidget {
  final List<dynamic> expenseCategories; // Accept dynamic list of expense data

  const PieChartSample2({super.key, required this.expenseCategories});

  @override
  State<StatefulWidget> createState() => PieChartSample2State();
}

class PieChartSample2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  // Define a list of colors for the pie chart sections
  // Ensure you have enough colors or a strategy for more categories
  final List<Color> _categoryColors = [
    AppStyles.orangeColor,
    AppStyles.redColor, // Or Colors.deepPurple if preferred for 'Apparel'
    AppStyles.blueColor,
    AppStyles.purpleColor, // Or AppStyles.pinkColor if preferred for 'Gift'
    AppStyles
        .simpleBlueColor, // Or Colors.lightBlueAccent if preferred for 'Education'
    Colors.green,
    Colors.teal,
    Colors.brown,
    Colors.amber,
    Colors.indigo,
    // Add more colors if needed
  ];

  Color _getColorForIndex(int index) {
    return _categoryColors[index % _categoryColors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expenseCategories.isEmpty) {
      return Center(
        child: Text(
          "No expense data to display in chart.",
          style: AppStyles.smallText.copyWith(color: AppStyles.greyColor),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          // Use Expanded so PieChart takes available height within the SizedBox
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2, // Add a little space between sections
              centerSpaceRadius: 40.r, // Responsive radius
              sections: showingSections(),
            ),
          ),
        ),
        SizedBox(height: 16.h), // Space before legend
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    // Wrap legends if they overflow horizontally
    return Wrap(
      spacing: 8.w, // Horizontal spacing between legend items
      runSpacing: 4.h, // Vertical spacing between lines of legend items
      alignment: WrapAlignment.center, // Center the legend items
      children:
          widget.expenseCategories.asMap().entries.map((entry) {
            int index = entry.key;
            // Assuming each item in expenseCategories has 'category' property
            String categoryName = entry.value.category;
            return _buildLegendItem(_getColorForIndex(index), categoryName);
          }).toList(),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            // Use Circle or RoundedRectangle for a nicer look if desired
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(3.r),
            color: color,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: AppStyles.smallText.copyWith(
            fontSize: 12.sp,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.expenseCategories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize =
          isTouched ? 14.sp : 10.sp; // Adjusted font size for responsiveness
      final radius = isTouched ? 60.r : 50.r; // Responsive radius

      // Assuming each item in expenseCategories has 'percent' (int) and 'category' (String)
      final expenseItem = widget.expenseCategories[i];
      final double percentValue = (expenseItem.percent as int).toDouble();
      final String categoryName = expenseItem.category as String;

      return PieChartSectionData(
        color: _getColorForIndex(i),
        value: percentValue,
        title:
            '${percentValue.toStringAsFixed(percentValue.truncateToDouble() == percentValue ? 0 : 1)}%', // Show decimal if not whole number
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff), // White text on sections
          shadows: [
            Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 2),
          ], // Add shadow for better readability
        ),
        // Optional: Show category name on touch, or if space allows
        // title: isTouched ? categoryName : '${percentValue.toStringAsFixed(1)}%',
      );
    });
  }
}
