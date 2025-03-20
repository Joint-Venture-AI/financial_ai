import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFeild extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;
  final TextInputType type;
  const CustomTextFeild({
    super.key,
    required this.hintText,
    required this.isObsecure,
    required this.type,
    required this.controller,
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObsecure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppStyles.lightGreyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: AppStyles.smallText.copyWith(color: Colors.black),
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.type,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: AppStyles.smallText.copyWith(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          border: InputBorder.none,
          suffixIcon:
              widget.isObsecure
                  ? Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: SvgPicture.asset(
                          width: 16.w,
                          height: 16.h,
                          _obscureText
                              ? AppIcons.visibleIcon
                              : AppIcons.inVisibleIcon,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}
