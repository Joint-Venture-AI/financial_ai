import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFeild extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;
  final TextInputType type;
  final bool? isEnabled;
  final String? Function(String?)? validator; // Add validator function
  const CustomTextFeild({
    super.key,
    required this.hintText,
    required this.isObsecure,
    required this.type,
    required this.controller,
    this.validator,
    this.isEnabled, // Make validator optional
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  late bool _obscureText;
  bool _showError = false; // Track whether to show the error message

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObsecure;
    widget.controller.addListener(_validateInput);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateInput);
    super.dispose();
  }

  void _validateInput() {
    if (widget.validator != null) {
      final error = widget.validator!(widget.controller.text);
      setState(() {
        _showError = error != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _showError ? Colors.red : AppStyles.lightGreyColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            enabled: widget.isEnabled ?? true,
            style: AppStyles.smallText.copyWith(color: Colors.black),
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.type,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppStyles.smallText.copyWith(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              filled: true,
              fillColor: Colors.white,
              // 👇 Clear, visible border styles
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppStyles.lightGreyColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              suffixIcon:
                  widget.isObsecure
                      ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: SvgPicture.asset(
                            _obscureText
                                ? AppIcons.visibleIcon
                                : AppIcons.inVisibleIcon,
                            width: 20.w,
                            height: 20.h,
                            color: Colors.black,
                          ),
                        ),
                      )
                      : null,
              suffixIconConstraints: BoxConstraints(
                maxWidth: 36.w,
                maxHeight: 36.h,
              ),
            ),
          ),
        ),
        if (_showError && widget.validator != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 8.w),
            child: Text(
              widget.validator!(widget.controller.text) ??
                  '', // Display error message from validator
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
