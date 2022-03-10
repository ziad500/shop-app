import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';

class SettingScreen extends StatelessWidget {
  var FromKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      /* if (state is ShopSuccessGetUserDataState) {
        nameController.text = state.profileModel!.data!.name!;
        emailController.text = state.profileModel!.data!.email!;
        phoneController.text = state.profileModel!.data!.phone!;
      } */
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: ShopCubit.get(context).profileModel != null,
        builder: (context) {
          var model = ShopCubit.get(context).profileModel!;
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(context,
                          controller: nameController,
                          type: TextInputType.name, validate: (String? value) {
                        if (value!.isEmpty) {
                          return "name must not be empty";
                        }
                      }, label: 'Name', prefix: Icons.person),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                        if (value!.isEmpty) {
                          return "email must not be empty";
                        }
                      }, label: 'Email Address', prefix: Icons.email_outlined),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(context,
                          controller: phoneController,
                          type: TextInputType.phone, validate: (String? value) {
                        if (value!.isEmpty) {
                          return "Phone must not be empty";
                        }
                      }, label: 'Phone', prefix: Icons.phone),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).UpdateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'Update'),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: () {
                            signout(context);
                          },
                          text: 'LOGOUT'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        fallback: (context) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    });
  }
}
