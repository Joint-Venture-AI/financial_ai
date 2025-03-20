import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/tab_all_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionItem extends StatelessWidget {
  final String category;
  final String description;
  final String paymentMethod;
  final double amount;
  final bool isIncome;

  const TransactionItem({
    super.key,
    required this.category,
    required this.description,
    required this.paymentMethod,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.only(bottom: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Left Section (Date + Day)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '03',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Jun 25',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            'Sunday',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Middle Section (Income + Expense Labels)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Income',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.teal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Expense',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    /// Right Section (Income + Expense Amounts)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$220.00',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '\$1200.00',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                data_item(isIncome: false),
                const Divider(),
                data_item(isIncome: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row data_item({required bool isIncome}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Food',
            style: AppStyles.mediumText.copyWith(
              color: AppStyles.greyColor,
              fontSize: 14.sp,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buy for someb..',
                style: AppStyles.mediumText.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Cash',
                style: AppStyles.mediumText.copyWith(
                  fontSize: 14.sp,
                  color: AppStyles.greyColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            textAlign: TextAlign.end,
            '-\$120.00',
            style: AppStyles.mediumText.copyWith(
              color: isIncome ? AppStyles.primaryColor : Colors.red,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
