// ignore_for_file: avoid_print, unused_local_variable, avoid_function_literals_in_foreach_calls, await_only_futures, unnecessary_brace_in_string_interps, avoid_init_to_null


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
    emit(ChangeNameState());
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

  // //*=============================================
  // //?================= Show Password =============
  // //*=============================================

  // IconData suffix = Icons.visibility_off;
  // bool showPassword = true;
  // void changePasswordVisibility() {
  //   showPassword = !showPassword;
  //   suffix = showPassword ? Icons.visibility_off : Icons.visibility;
  //   emit(ShowPasswordState());
  // }

  // //*=============================================
  // //?=============== Register  user ==============
  // //*=============================================
  // Future<void> register({
  //   String? name,
  //   String? mail,
  //   String? password,
  // }) async {
  //   try {
  //     final credential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //       email: mail!,
  //       password: password!,
  //     )
  //         .then((value) {
  //       saveUserDate(name: name, mail: mail, id: value.user!.uid);
  //       emit(RegisterSuccessState());
  //       print("RegisterSuccessState");
  //     }).catchError((onError) {
  //       emit(RegisterErrorState());
  //       print("RegisterErrorState");
  //       Fluttertoast.showToast(
  //           msg: "The email address is badly formatted.",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: Colors.red);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //       Fluttertoast.showToast(
  //           msg: "The password provided is too weak.",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: Colors.red);
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //       Fluttertoast.showToast(
  //           msg: "The account already exists for that email.",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: Colors.red);
  //     }
  //   } catch (e) {
  //     print("error Sing Up ${e.toString()}");
  //   }
  // }

  // //*=============================================
  // //?===============   Login    ================
  // //*=============================================
  // Future<void> login({
  //   String? mail,
  //   String? password,
  // }) async {
  //   try {
  //     final credential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: mail!, password: password!);
  //     print("signUp : ${credential.user!.uid}");
  //     emit(LoginSuccessState(credential.user!.uid));
  //     print("LoginSuccessState");
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       Fluttertoast.showToast(
  //           msg: "email faild ",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: Colors.red);
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //       Fluttertoast.showToast(
  //           msg: "Wrong password",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: Colors.red);
  //     }
  //     Fluttertoast.showToast(
  //         msg: "The email address is badly formatted",
  //         toastLength: Toast.LENGTH_SHORT,
  //         backgroundColor: Colors.red);
  //     emit(LoginErrorState());
  //     print("LoginErrorState");
  //   }
  // }

  //*=============================================
  //?========= save user data in firebase ========
  //*=============================================
  // Future<void> saveUserDate({
  //   String? name,
  //   String? mail,
  //   String? id,
  // }) async {
  //   emit(SaveUserDataLoadingState());
  //   print("SaveUserDataLoadingState");
  //   UserModelFire userModelFire =
  //       UserModelFire(name: name, mail: mail, token: id);
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(id)
  //       .set(userModelFire.toMap())
  //       .then((value) {
  //     emit(SaveUserDataSuccessState());
  //     print("SaveUserDataSuccessState");
  //   }).catchError((onError) {
  //     emit(SaveUserDataErrorState());
  //     print("SaveUserDataErrorState $onError");
  //   });
  // }
  // //*=============================================
  // //?========= Get All user in application =======
  // //*=============================================

  // List<UserModelFire>? countUsers;
  // Future getAllUser() async {
  //   countUsers = [];
  //   emit(GetAllUserLoadingState());
  //   print("GetAllUserLoadingState");
  //   var value = await FirebaseFirestore.instance.collection('users').get();
  //   value.docs.forEach((element) {
  //     print(" element ${element.data()}");
  //     if (element.data()["token"] != MyConst.uidUser) {
  //       countUsers!.add(UserModelFire.fromJson(element.data()));
  //       emit(GetAllUserSuccessState());
  //       print("GetAllUserSuccessState");
  //     }
  //   });
  //   print("countUsers : ${countUsers!.length}");
  // }

//   //*=============================================
//   //?=======  save messages in firebase =========
//   //*=============================================
//   Future<void> sendMessage({
//     String? receiverId,
//     String? text,
//     String? dateTime,
//     String? image,
//   }) async {
//     MessageModel messageModel = MessageModel(
//       receiverId: receiverId,
//       text: text,
//       dateTime: dateTime,
//       senderId: MyConst.uidUser,
//       image: image,
//     );
//     //* my chat
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(MyConst.uidUser)
//         .collection("Chats")
//         .doc(receiverId)
//         .collection("Messages")
//         .add(messageModel.toMap())
//         .then((value) {
//       emit(SendMessageSuccessState());
//       print("SendMessageSuccessState");
//     }).catchError((onError) {
//       emit(SendMessageErrorState());
//       print("SendMessageErrorState");
//     });
//     //* receiver chat
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(receiverId)
//         .collection("Chats")
//         .doc(MyConst.uidUser)
//         .collection("Messages")
//         .add(messageModel.toMap())
//         .then((value) {
//       emit(SendMessageSuccessState());
//       print("SendMessageSuccessState");
//     }).catchError((onError) {
//       emit(SendMessageErrorState());
//       print("SendMessageErrorState");
//     });
//   }

//   //*==============================================================
//   //*      get messages from firebase to message model
//   //*==============================================================
//   List<MessageModel>? messages;
//   Future<void> getMessage({
//     String? receiverId,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(MyConst.uidUser)
//         .collection("Chats")
//         .doc(receiverId)
//         .collection("Messages")
//         .orderBy("dateTime")
//         .snapshots()
//         .listen((event) {
//       messages = [];
//       event.docs.forEach((element) {
//         messages!.add(MessageModel.fromJson(element.data()));
//       });
//       emit(GetMessageSuccessState());
//       print("GetMessageSuccessState");
//     });
//   }

// //*=======================================================================
// //*                      get image from device
// //*=======================================================================
//   File? selectImage = null;
//   ImagePicker sendpicker = ImagePicker();

//   Future getsendImage(
//       // {
//       // @required String? name,
//       // @required String? bio,
//       // @required String? phone,
//       // }
//       ) async {
//     emit(SelectImageLoadingState());
//     print("SelectImageLoadingState");
//     final imagefile = await sendpicker.pickImage(source: ImageSource.gallery);

//     if (imagefile != null) {
//       selectImage = File(imagefile.path);
//       print("image Path is : ${selectImage}");
//       // uploadImage();
//       emit(SelectImageSuccessState());
//       print("SelectImageSuccessState");
//     } else {
//       // print("Not Image Selected");
//       emit(SelectImageErrorState());
//       print("SelectImageErrorState");
//     }
//   }

//   Future<void> uploadImage() async {
//     emit(UploadImageLoadingState());
//     print("UploadImageLoadingState");
//     FirebaseStorage.instance
//         .ref("images/${Uri.file(selectImage!.path).pathSegments.last}")
//         .putFile(selectImage!)
//         .then((value) {
//       value.ref.getDownloadURL().then((value) {
//         sendMessage(
//           image: value
//         );
//         emit(UploadImageSuccessState());
//         print("UploadImageSuccessState");
//       }).catchError((onError) {
//         emit(UploadImageErrorState());
//         print("UploadImageErrorState : $onError");
//       });
//     }).catchError((onError) {
//       emit(UploadImageErrorState());
//       print("UploadImageErrorState : $onError");
//     });
//   }
}
