// ignore_for_file: unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telegram/Module/user_model_fire.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  //*=============================================
  //?================= Show Password =============
  //*=============================================

  IconData suffix = Icons.visibility_off;
  bool showPassword = true;
  void changePasswordVisibility() {
    showPassword = !showPassword;
    suffix = showPassword ? Icons.visibility_off : Icons.visibility;
    emit(ShowPasswordState());
  }

  //*=============================================
  //?=============== Register  user ==============
  //*=============================================
  Future<void> register({
    String? name,
    String? mail,
    String? password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: mail!,
        password: password!,
      )
          .then((value) {
        saveUserDate(name: name, mail: mail, id: value.user!.uid);
        emit(RegisterSuccessState());
        print("RegisterSuccessState");
      }).catchError((onError) {
        emit(RegisterErrorState());
        print("RegisterErrorState");
        Fluttertoast.showToast(
            msg: "The email address is badly formatted.",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print("error Sing Up ${e.toString()}");
    }
  }

  //*=============================================
  //?========= save user data in firebase ========
  //*=============================================
  Future<void> saveUserDate({
    String? name,
    String? mail,
    String? id,
  }) async {
    emit(SaveUserDataLoadingState());
    print("SaveUserDataLoadingState");
    UserModelFire userModelFire =
        UserModelFire(name: name, mail: mail, token: id);
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userModelFire.toMap())
        .then((value) {
      emit(SaveUserDataSuccessState());
      print("SaveUserDataSuccessState");
    }).catchError((onError) {
      emit(SaveUserDataErrorState());
      print("SaveUserDataErrorState $onError");
    });
  }
}
