import 'package:financial_ai_mobile/controller/chat_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/models/chat_model.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
          Expanded(
            child: Obx(() {
              // Scroll to bottom when new message is added
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // You might need a ScrollController for this to work reliably
                // and scroll to the end of the list.
              });
              return chatController.chatData.isEmpty
                  ? _buildWelcomeText()
                  : _buildChatList();
            }),
          ),
          Obx(() {
            return chatController.isLoading.value
                ? Padding(
                  padding: EdgeInsets.all(10.r), // Use .r for padding
                  child: SizedBox(
                    width: double.infinity,
                    height: 20.h,
                    child: Shimmer.fromColors(
                      baseColor:
                          Colors.grey.shade400, // Adjusted shimmer colors
                      highlightColor: Colors.grey.shade200,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Shimmer needs a background
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                )
                : SizedBox.shrink(); // Use SizedBox.shrink for no space
          }),
        ],
      ),
      bottomNavigationBar: _buildMessageInput(),
    );
  }

  Widget _buildWelcomeText() {
    // ... (no changes needed)
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

  Widget _buildChatList() {
    // For auto-scrolling, you'd add a ScrollController here
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ), // Adjusted padding
      child: ListView.builder(
        reverse:
            false, // Keep false if you want new messages at the bottom and scroll down
        itemCount: chatController.chatData.length,
        itemBuilder: (context, index) {
          final message = chatController.chatData[index];
          return _buildMessageCard(message, context);
        },
      ),
    );
  }

  Widget _buildMessageCard(ChatModel message, BuildContext context) {
    bool isSender = message.isSender;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.all(10.w), // Consistent padding
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ), // Max width for bubbles
        decoration: BoxDecoration(
          color: isSender ? AppStyles.blueColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // Important for Column to wrap content
          children: [
            // Display image if it exists (only for sender's message for now)
            if (isSender && message.imageFile != null)
              Padding(
                padding: EdgeInsets.only(
                  bottom: message.message.isNotEmpty ? 8.h : 0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(
                    message.imageFile!,
                    width:
                        MediaQuery.of(context).size.width *
                        0.6, // Responsive image width
                    fit: BoxFit.contain, // Use contain or cover as needed
                  ),
                ),
              ),
            // Display text message
            // Conditionally render Text widget only if message is not empty
            if (message.message.isNotEmpty)
              isSender
                  ? Text(
                    message.message,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  )
                  : md.MarkdownBody(
                    selectable: true,
                    data: message.message,
                    styleSheet: md.MarkdownStyleSheet(
                      // Basic styling for markdown
                      p: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkdownMessage(ChatModel message) {
    // This can be removed if integrated into _buildMessageCard
    return md.MarkdownBody(selectable: true, data: message.message);
  }

  Widget _buildMessageInput() {
    // ... (no changes to the overall structure needed, just ensure controller.chatController is used)
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -2), // changes position of shadow
          ),
        ],
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.circular(20.r),
        //   topLeft: Radius.circular(20.r),
        // ), // Optional: if you want rounded top corners
      ),
      child: SafeArea(
        // Ensures input is not obscured by system UI (like home bar)
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return chatController.selectedImage.value != null
                  ? _buildSelectedImagePreview()
                  : SizedBox.shrink();
            }),
            _buildInputRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedImagePreview() {
    // ... (no changes needed)
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        // Wrap in Row to allow alignment or other elements if needed
        mainAxisAlignment: MainAxisAlignment.start, // Align image to the start
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  chatController.selectedImage.value!,
                  width: 60.w, // Slightly larger preview
                  height: 60.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -5, // Adjust for better positioning
                right: -5,
                child: GestureDetector(
                  onTap: () {
                    chatController.removeImage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.w), // Padding inside circle
                    decoration: BoxDecoration(
                      color: Colors.redAccent, // Slightly different red
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5.w,
                      ), // White border for contrast
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

  Widget _buildInputRow() {
    // Use chatController.chatTextController
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.end, // Align items to bottom if TextField grows
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.h,
            ), // Adjust vertical padding
            decoration: BoxDecoration(
              color: Colors.grey.shade100, // Softer grey
              borderRadius: BorderRadius.circular(25.r), // More rounded
            ),
            child: TextField(
              controller:
                  chatController
                      .chatTextController, // Use the renamed controller
              maxLines: 5, // Allow multiple lines
              minLines: 1,
              textInputAction: TextInputAction.newline, // For multiline input
              decoration: InputDecoration(
                hintText: 'Message AI Financial Assistant...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                isCollapsed: true, // Reduces some default padding
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ), // Adjust content padding
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () async {
            await chatController.pickImage();
          },
          child: Padding(
            // Add padding for larger tap area
            padding: EdgeInsets.all(8.r),
            child: SvgPicture.asset(
              AppIcons.addImage,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                Colors.grey.shade700,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        // SizedBox(width: 5.w), // Spacing can be adjusted
        GestureDetector(
          onTap: () async {
            // Prevent multiple rapid sends while one is in progress
            if (!chatController.isLoading.value) {
              await chatController.sendMessage();
            }
          },
          child: Padding(
            // Add padding for larger tap area
            padding: EdgeInsets.all(8.r),
            child: Obx(
              () =>
                  chatController.isLoading.value
                      ? SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ) // Show loader on send icon
                      : SvgPicture.asset(
                        AppIcons.sendIcon,
                        width: 24.w,
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                          AppStyles.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
