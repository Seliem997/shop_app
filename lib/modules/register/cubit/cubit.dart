import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }){

    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
        'password' : password,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJason(value.data);
      emit(RegisterSuccessState(loginModel));

    }).catchError((error){

      print(error.toString());
      emit(RegisterErrorState(error.toString()));

    });
  }

  IconData suffixPasswordVisible= Icons.visibility_outlined ;
  bool isPassword= true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffixPasswordVisible = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(RegisterChangePasswordVisibilityState());
  }

}