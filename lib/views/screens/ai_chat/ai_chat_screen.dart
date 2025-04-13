import 'dart:io';
import 'package:financial_ai_mobile/controller/chat_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/models/chat_model.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({super.key});
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'AI Financial Assistant',
        isCenter: false,
        showActions: false,
      ),
      body: Column(
        children: [
          // **Welcome Text Section**
          Expanded(
            child: Obx(() {
              return chatController.chatData.isEmpty
                  ? _buildWelcomeText()
                  : _buildChatList();
            }),
          ),
          Obx(() {
            return chatController.isLoading.value
                ? Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 20.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.black54,
                      highlightColor: Colors.blueGrey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                )
                : SizedBox();
          }),
        ],
      ),
      bottomNavigationBar: _buildMessageInput(),
    );
  }

  // Widget for displaying the welcome text
  Widget _buildWelcomeText() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to Your Personal',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 5.h),
          Text(
            'AI Financial Assistant!',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for displaying the chat list
  Widget _buildChatList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),

      child: ListView.builder(
        itemCount: chatController.chatData.length,
        itemBuilder: (context, index) {
          final message = chatController.chatData[index];
          return _buildMessageCard(message);
        },
      ),
    );
  }

  // Widget for building individual message cards
  Widget _buildMessageCard(ChatModel message) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Align(
        alignment:
            message.isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color:
                message.isSender ? AppStyles.blueColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message.message,
              style: TextStyle(
                color: message.isSender ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget for message input field and image selection
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // **Selected Image Preview**
          Obx(() {
            return chatController.selectedImage.value != null
                ? _buildSelectedImagePreview()
                : SizedBox.shrink();
          }),

          // **Message Input Field**
          _buildInputRow(),
        ],
      ),
    );
  }

  // Widget for displaying selected image preview
  Widget _buildSelectedImagePreview() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          // **Image Preview**
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  chatController.selectedImage.value!,
                  width: 50.w,
                  height: 50.w,
                  fit: BoxFit.cover,
                ),
              ),

              // **Delete Icon**
              Positioned(
                top: -4,
                right: -4,
                child: GestureDetector(
                  onTap: () {
                    chatController.removeImage();
                  },
                  child: Container(
                    width: 18.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 12.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the message input row (including send button and image picker)
  Widget _buildInputRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: TextField(
              controller: chatController.chatController,
              decoration: InputDecoration(
                hintText: 'Message with AI Financial...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        SizedBox(width: 10.w),

        // **Add Image Icon (Click to Open Gallery)**
        GestureDetector(
          onTap: () async {
            await chatController.pickImage();
          },
          child: SvgPicture.asset(AppIcons.addImage, width: 24.w, height: 24.h),
        ),

        SizedBox(width: 5.w),

        // **Send Icon (Send the Message)**
        GestureDetector(
          onTap: () async {
            await chatController.sendMessage();
          },
          child: SvgPicture.asset(AppIcons.sendIcon, width: 24.w, height: 24.h),
        ),
      ],
    );
  }
}
