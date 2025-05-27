import 'package:financial_ai_mobile/core/models/income_expense_model.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart'; // Ensure this path is correct
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // For number and date formatting

class BudgetItem extends StatelessWidget {
  final bool isExpense;
  final IncomeExpenseModel incomeExpenseModel;

  const BudgetItem({
    super.key,
    required this.isExpense,
    required this.incomeExpenseModel,
  });

  // ... ( _getIconForSource method remains the same) ...
  IconData _getIconForSource(String source, bool isExpenseItem) {
    String normalizedSource = source.toLowerCase().replaceAll(
      '_',
      ' ',
    ); // Normalize for matching

    if (isExpenseItem) {
      // Expense Categories
      if (normalizedSource.contains('food') ||
          normalizedSource.contains('dining'))
        return Icons.restaurant_menu_outlined;
      if (normalizedSource.contains('transport'))
        return Icons.directions_car_filled_outlined;
      if (normalizedSource.contains('utilities') ||
          normalizedSource.contains('bill'))
        return Icons.lightbulb_outline;
      if (normalizedSource.contains('health') ||
          normalizedSource.contains('medical'))
        return Icons.medical_services_outlined;
      if (normalizedSource.contains('entertainment'))
        return Icons.local_play_outlined;
      if (normalizedSource.contains('shopping'))
        return Icons.shopping_bag_outlined;
      if (normalizedSource.contains('education')) return Icons.school_outlined;
      if (normalizedSource.contains('travel'))
        return Icons.flight_takeoff_outlined;
      if (normalizedSource.contains('rent') ||
          normalizedSource.contains('mortgage'))
        return Icons.house_outlined;
      if (normalizedSource.contains('personal care')) return Icons.spa_outlined;
      if (normalizedSource.contains('insurance')) return Icons.shield_outlined;
      if (normalizedSource.contains('transfer'))
        return Icons.swap_horiz_outlined; // Could be for both
      return Icons.label_outline; // Default for 'other' or unmatched expenses
    } else {
      // Income Categories
      if (normalizedSource.contains('salary') ||
          normalizedSource.contains('paycheck'))
        return Icons.payments_outlined;
      if (normalizedSource.contains('freelance'))
        return Icons.work_history_outlined;
      if (normalizedSource.contains('investment'))
        return Icons.trending_up_outlined;
      if (normalizedSource.contains('gift'))
        return Icons.card_giftcard_outlined;
      if (normalizedSource.contains('refund'))
        return Icons.settings_backup_restore_outlined;
      if (normalizedSource.contains('transfer'))
        return Icons.swap_horiz_outlined; // Could be for both
      return Icons
          .attach_money_outlined; // Default for 'other' or unmatched income
    }
  }

  // Helper for currency formatting
  String _formatCurrency(int amount) {
    final format = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    ); // No decimals
    return format.format(amount);
  }

  // Helper for date formatting
  String _formatTransactionDate(DateTime date) {
    // Example formats:
    // return DateFormat('dd MMM yyyy').format(date); // e.g., 26 May 2025
    // return DateFormat('EEE, MMM d').format(date); // e.g., Mon, May 26
    return DateFormat.yMMMd().format(
      date,
    ); // e.g., May 26, 2025 (locale-dependent)
    // return DateFormat('dd MMM, hh:mm a').format(date); // e.g., 26 May, 06:28 AM
  }

  @override
  Widget build(BuildContext context) {
    Color amountColor = isExpense ? Colors.red.shade700 : Colors.green.shade700;
    Color iconBackgroundColor =
        isExpense ? Colors.red.shade50 : Colors.green.shade50;
    Color iconColor = isExpense ? Colors.red.shade600 : Colors.green.shade600;

    String mainTitle =
        incomeExpenseModel.note.isNotEmpty
            ? incomeExpenseModel.note
            : incomeExpenseModel.source;
    String subTitle =
        incomeExpenseModel.note.isNotEmpty
            ? incomeExpenseModel.source
            : incomeExpenseModel.method;
    String detailSubtitle =
        incomeExpenseModel.note.isNotEmpty ? incomeExpenseModel.method : "";

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 2.w,
      ), // Slightly adjusted margin
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 12.w,
      ), // Slightly adjusted padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r), // Slightly smaller radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12), // Softer shadow
            spreadRadius: 0.5,
            blurRadius: 6,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align items better vertically
        children: [
          Container(
            padding: EdgeInsets.all(8.sp), // Consistent padding for icon
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(
                8.r,
              ), // Match card radius or slightly less
            ),
            child: Icon(
              _getIconForSource(incomeExpenseModel.source, isExpense),
              size: 22.sp, // Slightly smaller icon
              color: iconColor,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: AppStyles.mediumText.copyWith(
                    fontSize: 15.sp, // Slightly smaller main title
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.85),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subTitle.isNotEmpty) SizedBox(height: 2.h),
                if (subTitle.isNotEmpty)
                  Text(
                    subTitle,
                    style: AppStyles.smallText.copyWith(
                      fontSize: 12.sp, // Slightly smaller subtitle
                      color: AppStyles.greyColor.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (detailSubtitle.isNotEmpty) SizedBox(height: 1.h),
                if (detailSubtitle.isNotEmpty)
                  Text(
                    detailSubtitle,
                    style: AppStyles.smallText.copyWith(
                      fontSize: 10.sp, // Slightly smaller detail
                      color: AppStyles.greyColor.withOpacity(0.65),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: 3.h), // Space before the date
                Text(
                  _formatTransactionDate(
                    incomeExpenseModel.createdAt,
                  ), // Display formatted date
                  style: AppStyles.smallText.copyWith(
                    fontSize: 10.sp,
                    color: AppStyles.greyColor,
                    fontStyle: FontStyle.italic, // Optional: make date italic
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            '${isExpense ? "-" : ""}${_formatCurrency(incomeExpenseModel.amount)}',
            style: AppStyles.mediumText.copyWith(
              fontSize: 14.sp, // Slightly smaller amount
              fontWeight: FontWeight.w700,
              color: amountColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
