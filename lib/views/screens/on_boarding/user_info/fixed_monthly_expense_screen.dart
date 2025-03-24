import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FixedMonthlyExpenseScreen extends StatelessWidget {
  const FixedMonthlyExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45.h),
            Text(
              'Add Your Fixed Monthly Expenses',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Text(
              'Track your fixed costs and manage your budget\nwith ease.',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey),
            ),
            SizedBox(height: 24.h),
            Text(
              'Add Fixed Expense',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            _buildCategoryGrid(context),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Center(
              child: InkWell(
                onTap: () => Get.back(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Back',
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    final categories = [
      ['Food', 'Social Life', 'Pets'],
      ['Education', 'Gift', 'Transport'],
      ['Rent', 'Apparel', 'Beauty'],
      ['Health', '', 'Other'],
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey.shade300),
        ),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children:
            categories.map((row) {
              return TableRow(
                children:
                    row.map((item) {
                      if (item.isEmpty) return const SizedBox.shrink();
                      return _buildCategoryCell(context, item);
                    }).toList(),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCategoryCell(BuildContext context, String title) {
    final icons = {
      'Food': '🍽️',
      'Social Life': '🫂',
      'Pets': '🐶',
      'Education': '🎓',
      'Gift': '🎁',
      'Transport': '🚕',
      'Rent': '🏠',
      'Apparel': '👗',
      'Beauty': '💄',
      'Health': '🩺',
      'Other': '+',
    };

    return InkWell(
      onTap: () => _showAmountBottomSheet(context, title),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icons[title] ?? '', style: TextStyle(fontSize: 24.sp)),
            SizedBox(width: 6.w),
            Text(title, style: TextStyle(fontSize: 13.sp)),
          ],
        ),
      ),
    );
  }

  void _showAmountBottomSheet(BuildContext context, String category) {
    final TextEditingController _controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(
        0xFF1C1C1E,
      ), // dark background like screenshot
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24.w,
            16.h,
            24.w,
            MediaQuery.of(context).viewInsets.bottom + 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Amount',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '1,000',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save logic here
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
