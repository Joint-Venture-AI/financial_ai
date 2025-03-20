import 'package:financial_ai_mobile/controller/payment_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatelessWidget {
  AddCardScreen({super.key});

  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Payment Method',
        isCenter: false,
        showActions: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            /// **Toggle Payment Method**
            Obx(
              () => Row(
                children: [
                  _toggleButton(
                    icon: Icons.credit_card,
                    text: 'Card',
                    isSelected: controller.isCardSelected.value,
                    onTap: () => controller.togglePaymentMethod(true),
                  ),
                  SizedBox(width: 10.w),
                  _toggleButton(
                    icon: Icons.payment,
                    text: 'PayPal',
                    isSelected: !controller.isCardSelected.value,
                    onTap: () => controller.togglePaymentMethod(false),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// **Payment Details Form**
            Text(
              'Payment Details',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),

            /// **Card Payment Form**
            Obx(
              () =>
                  controller.isCardSelected.value
                      ? Column(
                        children: [
                          _customTextField('Name on Card'),
                          SizedBox(height: 10.h),
                          _customTextField('Card Number'),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(child: _customTextField('MM / YY')),
                              SizedBox(width: 10.w),
                              Expanded(child: _customTextField('CVC')),
                            ],
                          ),
                        ],
                      )
                      : Container(),
            ),

            SizedBox(height: 15.h),

            /// **Terms & Conditions**
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      children: [
                        const TextSpan(
                          text:
                              'By continuing, you agree to the Google Payment ',
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: '. The '),
                        TextSpan(
                          text: 'Privacy Notice',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' explains how your data is handled.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Spacer(),

            /// **Pay Now Button**
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: () {
                // Handle add card action
                Get.back();
              },
              child: Center(
                child: Text(
                  'Add Card',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  /// **Toggle Button Widget**
  Widget _toggleButton({
    required IconData icon,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal.shade700 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
              SizedBox(width: 6.w),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Custom Input Field Widget**
  Widget _customTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
