import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/utils/consts.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:graduation_project/features/chat_feature/data/models/messsage_model.dart';
import 'package:graduation_project/features/chat_feature/presentation/widgets/custom_chat_bubble_item.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/services/image_picker_service/image_picker_service.dart';
import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/app_fonts.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/widgets/custom_form_field.dart';
import '../../../../app/widgets/image_widget.dart';

class OneChatScreen extends StatefulWidget {
  const OneChatScreen(
      {super.key,
      required this.chatRoomId,
      required this.phone,
      required this.userId,
      required this.name, required this.email});
  final String chatRoomId;
  final String userId;
  final String name;
  final String phone;
  final String email;
  @override
  State<OneChatScreen> createState() => _OneChatScreenState();
}

class _OneChatScreenState extends State<OneChatScreen> {
  final TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  var messages = FirebaseFirestore.instance;
  File? userImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: DefaultAppBarWidget(
        titleWidget: Row(
          children: [
            // ImageWidget(
            //   imageUrl: "https://cdn-icons-png.flaticon.com/128/149/149071.png",
            //   width: 51.w,
            //   height: 51.h,
            // ),
            // 5.horizontalSpace,
            TextWidget(
              title: widget.name,
              titleSize: 20.sp,
              titleColor: AppColors.white,
            ),
          ],
        ),
        titleColor: AppColors.white,
        leadingColor: AppColors.white,
        backColor: AppColors.mainColor,
        actionsWidgets: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 10.sp),
            child: IconButton(
              onPressed: () async {
                await urlLaunch(url: "tel:${widget.phone}");
              },
              icon: Icon(
                Icons.call,
                color: AppColors.white,
                size: 24.sp,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          40.verticalSpace,
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.sp),
                    topLeft: Radius.circular(20.sp),
                  ),
                ),
                child: StreamBuilder(
                  stream: messages
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Message> listMessages = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        listMessages
                            .add(Message.fromJson(snapshot.data!.docs[i]));
                      }
                      return ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: listMessages.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              listMessages[index].token == widget.userId
                                  ? CustomChatBubble(
                                      message: listMessages[index],
                                    )
                                  : CustomFriendChatBubble(
                                      message: listMessages[index],
                                    )
                            ],
                          );
                        },
                      );
                    }
                    return 0.verticalSpace;
                  },
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gery455.withOpacity(.25),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await storeMessage();
                      scrollController.jumpTo(0);
                      controller.clear();
                    },
                    icon: ImageWidget(
                      imageUrl: AppImages.send,
                      width: 51.w,
                      height: 51.h,
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: CustomFormField(
                    hint: "اكتب رسالتك هنا",
                    hintColor: AppColors.gery455,
                    controller: controller,
                  ),
                ),
                10.horizontalSpace,
                Container(
                  width: 40.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor,
                  ),
                  child: IconButton(
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  )),
                              //height: 200.h,
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextWidget(
                                    title: "اختار صوره",
                                    titleAlign: TextAlign.center,
                                    titleSize: 20.sp,
                                    titleFontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.regular,
                                    titleColor: AppColors.mainColor,
                                  ),
                                  20.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await ImagePickerService.getImage(
                                              imageSource:
                                              ImageSource.camera)
                                              .then((value) async {
                                            if (value != null)  {
                                              userImage = File(value.path);
                                              await uploadPhoto();
                                              setState(() {});
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_rounded,
                                          color: AppColors.mainColor,
                                          size: 25.sp,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await ImagePickerService.getImage(
                                              imageSource:
                                              ImageSource.gallery)
                                              .then((value) async{
                                            if (value != null) {
                                              userImage = File(value.path);
                                              await uploadPhoto();
                                              setState(() {});
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.photo_library_rounded,
                                          color: AppColors.mainColor,
                                          size: 25.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.photo_library_outlined,
                        size: 25.sp,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  var rand = Random().nextInt(800000000);
  Future<void> storeMessage() async {
    var rand = Random().nextInt(800000000);
    CollectionReference messageRef = FirebaseFirestore.instance
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .collection('chats');
    messageRef.doc(rand.toString() +widget.userId).set({
      "message": controller.text,
      "userEmail": widget.email,
      "token": widget.userId,
      "time": DateTime.now(),
      "name": widget.name,
    });
  }

  Future<void> uploadPhoto() async {
    FirebaseAuth user = FirebaseAuth.instance;
    var name = userImage?.path ?? "";
    name = rand.toString() + name;
    var refStorage = FirebaseStorage.instance.ref("photos/$name");
    await refStorage.putFile(userImage!);
    var url = await refStorage.getDownloadURL();
    CollectionReference messageRef = FirebaseFirestore.instance
        .collection('chatroom')
        .doc(widget.chatRoomId)
        .collection('chats');
    messageRef.doc(rand.toString() + widget.userId).set({
      "message": url,
      "userEmail": widget.email,
      "token": widget.userId,
      "time": DateTime.now(),
      "name": widget.name,
    }).then((value) {});
  }
}
