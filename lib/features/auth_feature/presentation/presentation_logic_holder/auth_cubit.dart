import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/widgets/snak_bar_alret.dart';
import 'package:graduation_project/features/auth_feature/data/models/user_model.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/eng_use_cases/eng_login_use_case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/eng_use_cases/eng_register_use_case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/eng_use_cases/get_all_eng_use_case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/farmer_use_cases/farmer_login_use-case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/farmer_use_cases/farmer_register_use_case.dart';
import 'package:graduation_project/features/auth_feature/domain/use_casses/farmer_use_cases/get_all_farmers-use_case.dart';
import 'package:graduation_project/features/bottom_navigation_feature/presentation/screens/bottom_navigation_screen.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/utils/navigation_helper.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/flutter_toast.dart';
import '../../../../app/widgets/text_widget.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);

//user login controllers
  final loginPasswordController = TextEditingController(text:"Ahmed987@" );
  final loginEmailController = TextEditingController(text: "Ahmed123@gmail.com");
//engineer sign up controllers
  final signUpFullNameController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpNationalIDController = TextEditingController();
  final signUpPriceController = TextEditingController();
  // engineer login controllers
  final engLoginPassController = TextEditingController(text: "mo123@gmail.com");
  final engLoginEmailController = TextEditingController(text: "Exyo@023");

  // farmer register controllers
  final farmerRegisterPassController = TextEditingController();
  final farmerRegisterEmailController = TextEditingController();
  final farmerRegisterNameController = TextEditingController();
  final farmerRegisterPhoneController = TextEditingController();
  String ? city;
  String ? government;
  String ? department;
  UserModel ? userModel;
  bool passObscure = true;
  String ? errorMsg;
  List<UserModel> ? usersList;
  List<UserModel> ? engineersList;

  void changeVisible(){
    emit(LoadingState());
    passObscure = !passObscure;
    emit(AuthInitial());
  }


  void farmerLogin()async{
    errorMsg=null;
    emit(LoadingState());
final res = await getIt<FarmerLoginUseCase>()(
  FarmerLoginParams(
      email: loginEmailController.text,
      password: loginPasswordController.text,
  )
);
res.fold(
    (e){
      errorMsg="Mail or password is incorrect";
    },
        (r) {
          userModel = r;
          navigateTo(const BNBScreen(),removeAll: true);
          print(userModel?.token??"null");
        });
    emit(AuthInitial());
  }


  void farmerRegister()async{
    errorMsg=null;
    emit(LoadingState());
    final res = await getIt<FarmerRegisterUseCase>()(
        FarmerRegisterParams(
          email: farmerRegisterEmailController.text,
          password: farmerRegisterPassController.text,
          name: farmerRegisterNameController.text,
          phone: farmerRegisterPhoneController.text,
          city:city??"",
          governorate:government??"",
        )
    );
    res.fold(
            (e){
          errorMsg="Mail or password is incorrect";
        },
            (r) {
          userModel = r;
          navigateTo(const BNBScreen(),removeAll: true);
          print(userModel?.token??"null");
        });
    emit(AuthInitial());
  }


  void engineerLogin()async{
    errorMsg=null;
    emit(LoadingState());
    final res = await getIt<EngLoginUseCase>()(
        EngLoginParams(
          email: engLoginEmailController.text,
          password: engLoginPassController.text,
        )
    );
    res.fold(
            (e){
          errorMsg="Mail or password is incorrect";
        },
            (r) {
          userModel = r;
          navigateTo(const BNBScreen(),removeAll: true);
          print(userModel?.token??"null");
        });
    emit(AuthInitial());
  }

  void engineerRegister()async{
    emit(LoadingState());
    final res = await getIt<EngRegisterUseCase>()(
        EngRegisterParams(
          email: signUpEmailController.text,
          password: signUpPasswordController.text,
          city:city??"" ,
          department:department??"" ,
          governorate: government??"",
          name: signUpFullNameController.text,
          national_id: signUpNationalIDController.text,
          payment_amount:signUpPriceController.text ,
          phone: signUpPhoneController.text,
          rating:"5"
        )
    );
    res.fold(
        (l) {
          //you are not eng
          showSnackBar(
              icon: Icons.error_outline,
            message: "you are not an engineer",);
        },
            (r) {
          userModel = r;
          navigateTo(const BNBScreen(),removeAll: true);
          print(userModel?.token??"null");
        });
    emit(AuthInitial());
  }

  void getAllUsers()async{
    emit(LoadingState());
    final res = await getIt<GetAllFarmersUseCase>()(NoParams());
    res.fold(
          errorStateHandler,
            (r) {
          usersList = r;
          print(usersList?[0].name??"null");
        });
    emit(AuthInitial());
  }

  void getAllEngineers()async{
    emit(LoadingState());
    final res = await getIt<GetAllEngUseCase>()(NoParams());
    res.fold(
          errorStateHandler,
            (r) {
          engineersList = r;
          print(engineersList?[0].name??"null");
        });
    emit(AuthInitial());
  }
}
