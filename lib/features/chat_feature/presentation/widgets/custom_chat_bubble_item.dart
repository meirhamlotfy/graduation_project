// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/app/widgets/loading.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:graduation_project/features/chat_feature/presentation/screens/photo_view_screen.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../app/utils/app_colors.dart';
import '../../data/models/messsage_model.dart';

class CustomChatBubble extends StatelessWidget {
  const CustomChatBubble({Key? key, required this.message, }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return
      Align(
          alignment: Alignment.centerRight,
          child:
          message.message.contains("https://firebasestorage.googleapis.com/v0/b/grade-app-5ec66.appspot.com/o/photos")?
          InkWell(
            onTap: () {
              navigateTo(PhotoViewScreen(image: message.message));
            },
            child: ChatBubble(
              clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              margin:const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
              backGroundColor: AppColors.mainColor,
              child: Container(
                  width: 150.w,
                  height: 150.h,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Image(
                  image: NetworkImage(message.message),
                  fit: BoxFit.cover,
                )
              ),
            ),
          )
              :
          ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin:const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
            backGroundColor: AppColors.mainColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: TextWidget(
                title:message.message,
                titleColor: Colors.white,
                titleAlign: TextAlign.end,
                titleSize: 20.sp,
              ),
            ),
          )
      );
  }
}

class CustomFriendChatBubble extends StatelessWidget {
  const CustomFriendChatBubble({Key? key, required this.message, }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return
      Align(
          alignment: Alignment.centerLeft,
          child:
          message.message.contains("https://firebasestorage.googleapis.com/v0/b/grade-app-5ec66.appspot.com/o/photos")?
          ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
            alignment: Alignment.topLeft,
            margin:const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
            backGroundColor: const Color(0xff455A64),
            child: InkWell(
              onTap: () {
                navigateTo(PhotoViewScreen(image: message.message));
              },
              child: Container(
                width: 150.w,
                height: 150.h,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: PhotoView(
                  imageProvider: NetworkImage(message.message),
                )
              ),
            ),
          )
              :
          ChatBubble(
            clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
            alignment: Alignment.topLeft,
            margin:const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 10),
            backGroundColor: const Color(0xff455A64),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: TextWidget(
                title:message.message,
                titleColor: Colors.white,
                titleAlign: TextAlign.end,
                titleSize: 20.sp,
              ),
            ),
          )
      );
  }
}