import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/cubit.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/register_screen/cubit.dart';
import 'package:shop_app/modules/register_screen/states.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../layout/layout.dart';
import '../../network/remote/cashe_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/constants.dart';
import '../login_screen/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var NameController = TextEditingController();

  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              CasheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                ShopCubit.get(context).getFavoriteData();
                ShopCubit.get(context).getHomeData();
                ShopCubit.get(context).getUserData();
                ShopCubit.get(context).getCategoriesData();

                navigateAndFinish(context, ShopLayout());
              });
              /* showToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.SUCCESS); */
            } else {
              showToast(
                  text: state.loginModel.message.toString(),
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Register Now To Browse Our Hot Offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        defaultFormField(context,
                            controller: NameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your name";
                          }
                        }, label: "Name", prefix: Icons.person),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(context,
                            controller: EmailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Email";
                          }
                        },
                            label: "Email Address",
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(context,
                            controller: PhoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your phone";
                          }
                        }, label: "Name", prefix: Icons.phone),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          context,
                          isPassword: ShopRegisterCubit.get(context).isVisible,
                          controller: PasswordController,
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            /* 
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                  email: EmailController.text,
                                  password: PasswordController.text,
                                  name: NameController.text,
                                  phone: PhoneController.text);
                            } */
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Password";
                            }
                          },
                          label: "Password",
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisiblility();
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: State is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: NameController.text,
                                      phone: PhoneController.text,
                                      email: EmailController.text,
                                      password: PasswordController.text);
                                }
                              },
                              text: "Register",
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have An Account?"),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, loginScreen());
                                },
                                child: Text(
                                  'Login'.toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
