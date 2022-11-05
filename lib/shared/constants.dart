import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/network/remote/cashe_helper.dart';
import 'components/components.dart';

void signout(context) {
  CasheHelper.removeData(key: 'token').then((value) {
    if (value) {
      ShopCubit.get(context).currentIndex = 0;
      navigateAndFinish(context, LoginScreen());
    }
  });
}

dynamic token = '';
