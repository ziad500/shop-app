import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/layout/layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/on_boarding/onboarding_screen.dart';

import 'package:shop_app/network/remote/cashe_helper.dart';
import 'package:shop_app/styles/themes/themes.dart';
import 'package:shop_app/shared/constants.dart';
import 'network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.init();
  //Bloc.observer = MyBlocObserver();
  Widget widget = OnBoardingScreen();
  //bool? isDark = CasheHelper.getData(key: 'isDark');

  bool? onBoarding = CasheHelper.getData(key: 'onBoarding');
  token = CasheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoriteData()
              ..getUserData(),
          )
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lighttheme,
              darkTheme: darktheme,
              themeMode: ThemeMode.light,
              home: startWidget,
            );
          },
        ));
  }
}
