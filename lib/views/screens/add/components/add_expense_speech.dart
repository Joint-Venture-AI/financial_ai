import 'package:financial_ai_mobile/controller/add_data_controller/speech_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class AddExpenseSpeech extends StatelessWidget {
  AddExpenseSpeech({super.key});

  final SpeechController speechController = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppStyles.primaryColor.withValues(alpha: .6),
              AppStyles.primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              _buildAppBar(context),
              Expanded(
                child: Center(
                  child: Obx(
                    () => FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Animated Title
                          FadeInDown(
                            duration: Duration(milliseconds: 600),
                            child: Text(
                              'Voice Expense Tracker',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Recognized Words Display
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              speechController.isListening.value
                                  ? speechController.lastWords.value.isNotEmpty
                                      ? speechController.lastWords.value
                                      : 'Listening...'
                                  : speechController.isSpeechEnabled.value
                                  ? 'Tap the mic to start listening'
                                  : 'Speech not available',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30),
                          // Full Message Card
                          ZoomIn(
                            duration: Duration(milliseconds: 800),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(0.2),
                                //     blurRadius: 10,
                                //     offset: Offset(0, 4),
                                //   ),
                                // ],
                              ),
                              child: TextField(
                                controller: speechController.speechConroller,
                                readOnly: false,
                                maxLines: 5,
                                minLines: 1,

                                decoration: InputDecoration(
                                  hintText:
                                      speechController.fullMessage.value.isEmpty
                                          ? 'Your expense details will appear here'
                                          : speechController.fullMessage.value,
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          // Animated Microphone Button
                          _buildMicButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text(
  //                               speechController.fullMessage.value.isEmpty
  //                                   ? 'Your expense details will appear here'
  //                                   : speechController.fullMessage.value,
  //                               style: GoogleFonts.poppins(
  //                                 fontSize: 16,
  //                                 color: Colors.white,
  //                                 height: 1.5,
  //                               ),
  //                               textAlign: TextAlign.center,
  //                             // ),

  Widget _buildAppBar(BuildContext context) {
    return FadeInDown(
      duration: Duration(milliseconds: 600),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            Text(
              'Add Expense',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 48), // Balance the layout
          ],
        ),
      ),
    );
  }

  Widget _buildMicButton() {
    return Obx(
      () => ElasticIn(
        duration: Duration(milliseconds: 500),
        child: GestureDetector(
          onTap:
              speechController.isListening.value
                  ? speechController.stopListening
                  : speechController.startListening,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  speechController.isListening.value
                      ? AppStyles.primaryColor
                      : Colors.white.withOpacity(0.2),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.3),
              //     blurRadius: 10,
              //     offset: Offset(0, 4),
              //   ),
              // ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Icon(
                  speechController.isListening.value
                      ? Icons.mic
                      : Icons.mic_none_outlined,
                  key: ValueKey<bool>(speechController.isListening.value),
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
