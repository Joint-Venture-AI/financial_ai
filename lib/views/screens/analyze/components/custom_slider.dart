import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSlider extends StatelessWidget {
  final double value; // Expecting 0 to 100

  const CustomSlider({required this.value, super.key});

  Color _getColor(double value) {
    if (value <= 33) {
      return Colors.green;
    } else if (value <= 66) {
      return Colors.yellow.shade700;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sliderColor = _getColor(value);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: sliderColor,
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: sliderColor,
              overlayColor: sliderColor.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
              trackHeight: 4,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              inactiveColor: Colors.grey.shade300,
              value: value.clamp(0, 100),
              min: 0,
              max: 100,
              onChanged: null, // disabled slider (non-interactive)
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Safe', style: TextStyle(color: Colors.green)),
                Text('Risk', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
