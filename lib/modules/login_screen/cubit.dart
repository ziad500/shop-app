import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login_screen/states.dart';
import 'package:shop_app/network/endpoint.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  ShopLoginModel? loginmodel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: Login, data: {'email': email, 'password': password})
        .then((value) {
      loginmodel = ShopLoginModel.fromjson(value.data);
      emit(ShopLoginSuccessState(loginmodel!));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool isVisible = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisiblility() {
    isVisible = !isVisible;

    suffix =
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopchangePasswordVisiblilityState());
  }
}
