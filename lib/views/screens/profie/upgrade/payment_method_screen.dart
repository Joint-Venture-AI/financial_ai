import 'package:financial_ai_mobile/controller/payment_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/gradiunt_global_button.dart';
import 'package:financial_ai_mobile/views/screens/profie/upgrade/add_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({super.key});

  final PaymentController paymentController = Get.put(PaymentController());

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

            /// **Price & Discount Section**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '\$20.00',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '/ Month',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$120.00 per year, billed yearly',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade700,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Save 20%',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// **Pay With Section**
            Text(
              'Pay with',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),

            /// **Card Selection List (Reactive)**
            Obx(() {
              return Column(
                children: List.generate(paymentController.cards.length, (
                  index,
                ) {
                  return GestureDetector(
                    onTap: () {
                      paymentController.selectCard(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color:
                              paymentController.selectedCardIndex.value == index
                                  ? Colors.teal.shade700
                                  : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          /// **Card Icon**
                          SvgPicture.asset(
                            paymentController.cards[index]['type'] == "visa"
                                ? AppIcons
                                    .visa // Replace with actual path
                                : AppIcons
                                    .masterCardIcon, // Replace with actual path
                            width: 36.w,
                            height: 12.h,
                          ),
                          SizedBox(width: 10.w),

                          /// **Card Number**
                          Text(
                            '•••• ${paymentController.cards[index]['last4']}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),

                          /// **Selection Indicator**
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.teal.shade700,
                                width: 2,
                              ),
                            ),
                            child:
                                paymentController.selectedCardIndex.value ==
                                        index
                                    ? Center(
                                      child: Container(
                                        width: 10.w,
                                        height: 10.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.teal.shade700,
                                        ),
                                      ),
                                    )
                                    : null,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),

            /// **Add Card Button**
            GestureDetector(
              onTap: () {
                // Handle add card action
                Get.to(AddCardScreen());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.grey.shade700, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Add Card',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            /// **Pay Now Button**
            GradiuntGlobalButton(text: 'Pay Now', onTap: () {}),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
