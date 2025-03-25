

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/categories_feature/presentation/screens/categories_screen.dart';
import 'package:graduation_project/features/chat_feature/presentation/screens/all_chats_screen.dart';
import 'package:graduation_project/features/home_feature/presentation/screens/home_screen.dart';
import 'package:graduation_project/features/profile_feature/presentation/screens/profile_screen.dart';

import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/get_it_injection.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationStats> {
  BottomNavigationCubit() : super(BottomNavigationInitial());
  static BottomNavigationCubit get(context) => BlocProvider.of(context);
  int currentIndex =0;
  List<Widget> screens =const  [
   HomeScreen(),
   CategoriesScreen(),
   AllChatsScreen(),
   ProfileScreen(),
  ];
  void changeCurrent(int index)
  {
    emit(BottomNavigationInitial());
    currentIndex = index;
    emit(ChangeBottomNavigationIndex());
  }
}
