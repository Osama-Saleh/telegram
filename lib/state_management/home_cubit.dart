// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/Module/user_model.dart';
import 'package:telegram/controller/user_controller.dart';
import 'package:telegram/state_management/cubit_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? userModel = UserModel();
  //*=============================================
  //? set data of user that i will add to my list
  //*=============================================
  Future<void> addName(String fNameController, String lNameController) async {
    userModel!.fName = fNameController;
    userModel!.lName = lNameController;
    emit(ChangeName());
    print("ChangeName");
  }

  void insertItems({var key, String? fName, String? lName}) {
    var index = UserController.userController.length;
    UserController.userController.add(UserModel(fName: fName, lName: lName));
    key.currentState!.insertItem(index);
  }

  void deleteItems({var key, int? index}) {
    UserController.userController.removeAt(index!);
    key.currentState.removeItem(index, (context, animation) {});
  }

  //*=============================================
  //?================= Show Password =============
  //*=============================================
  bool isVisibel = true;
  IconData? iconData=Icons.visibility_off;
  void showPassword() {
    isVisibel = !isVisibel;
    if (isVisibel) {
      iconData = Icons.visibility_off;
    } else {
      iconData = Icons.visibility;
    }
    emit(ShowPassword());
    print("ShowPassword");
  }

  //*=============================================
  //?================= Login  user ===============
  //*=============================================
  Future<void> signUp() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: "emailAddress@gmail.com",
      password: "password",
    );
  }
}
