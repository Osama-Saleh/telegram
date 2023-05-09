import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
 static LoginCubit get(context) => BlocProvider.of(context);

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
  //?===============   Login    ================
  //*=============================================
  Future<void> login({
    String? mail,
    String? password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail!, password: password!);
      print("signUp : ${credential.user!.uid}");
      emit(LoginSuccessState(credential.user!.uid));
      print("LoginSuccessState");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
            msg: "email faild ",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: "Wrong password",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red);
      }
      Fluttertoast.showToast(
          msg: "The email address is badly formatted",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red);
      emit(LoginErrorState());
      print("LoginErrorState");
    }
  }
}
