import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/utils/helper.dart';
import 'package:graduation_project/app/widgets/custom_form_field.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/loading.dart';
import 'package:graduation_project/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:graduation_project/features/chat_feature/presentation/presentation_logic_holder/chat_cubit.dart';
import 'package:graduation_project/features/chat_feature/presentation/screens/one_chat_screen.dart';
import 'package:graduation_project/features/chat_feature/presentation/widgets/custom_chat_item.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../../auth_feature/presentation/screens/choose_profile_type_screen.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  String chatRoomId({required String user1, required String user2}) {
    if (user1[0].toLowerCase().codeUnits[0] <
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
  @override
  void initState() {
    getIt<CacheService>().getUserData()?.nationalId==null?
    AuthCubit.get().getAllEngineers()
        :AuthCubit.get().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBarWidget(
        title: "المحادثات",
        titleColor: AppColors.mainColor,
        leadingWidth: 0,
        canBack: false,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          var cubit = AuthCubit.get();
          return
          state is LoadingState? const Center(child:  Loading(),):
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
              child: Column(
                children: [
                  const CustomFormField(
                    hint: "البحث",
                    prefixIcon: Icons.search,
                    prefixIconColor: AppColors.gery455,
                    hintColor: AppColors.gery455,
                  ),
                  20.verticalSpace,
                  getIt<CacheService>().getUserData()?.nationalId==null?
                  Expanded(
                    child: ListView.builder(
                      itemCount: cubit.engineersList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            String roomId = chatRoomId(
                              user1:  getIt<CacheService>().getUserData()?.email??"",
                              user2: cubit.engineersList?[index].email ?? ""
                            );
                            navigateTo(OneChatScreen(
                                chatRoomId: roomId,
                                phone: cubit.engineersList?[index].phone ?? "",
                                userId: cubit.engineersList?[index].token ?? "",
                                name: cubit.engineersList?[index].name ?? "",
                              email:cubit.engineersList?[index].email ?? "" ,
                            ));
                          }  ,
                          child: CustomEngChatItem(
                            userName: cubit.engineersList?[index].name ?? "",
                            phone: cubit.engineersList?[index].phone ?? "",
                            payAmount: cubit.engineersList?[index].paymentAmount.toString() ?? "",
                          ),
                        );
                      },
                    ),
                  )
                  :
                  Expanded(
                    child: ListView.builder(
                      itemCount: cubit.usersList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            String roomId = chatRoomId(
                                user1:  getIt<CacheService>().getUserData()?.email??"",
                                user2: cubit.usersList?[index].email ?? ""
                            );
                            navigateTo(OneChatScreen(
                              chatRoomId: roomId,
                              phone: cubit.usersList?[index].phone ?? "",
                              userId: cubit.usersList?[index].token ?? "",
                              name: cubit.usersList?[index].name ?? "",
                              email:cubit.usersList?[index].email ?? "" ,
                            ));
                          }  ,
                          child: CustomUserChatItem(
                            userName: cubit.usersList?[index].name ?? "",
                            phone: cubit.usersList?[index].phone ?? "",
                            city: cubit.usersList?[index].city.toString() ?? "",
                          ),
                        );
                      },
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
