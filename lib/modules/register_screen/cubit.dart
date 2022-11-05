import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register_screen/states.dart';
import 'package:shop_app/network/endpoint.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password
    }).then((value) {
      loginModel = ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool isVisible = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisiblility() {
    isVisible = !isVisible;

    suffix =
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterchangePasswordVisiblilityState());
  }
}
