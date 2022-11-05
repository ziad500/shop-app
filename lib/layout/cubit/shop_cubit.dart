import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/fav.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/endpoint.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingScreen()
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  Map<int?, bool?> favourites = {};

  HomeModel? homemodel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homemodel = HomeModel.fromjson(value.data);
      homemodel!.data!.products.forEach((element) {
        favourites.addAll({element.id: element.inFavorites});
      });
      //print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesmodel;

  void getCategoriesData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: Get_Categories, token: token).then((value) {
      categoriesmodel = CategoriesModel.fromjson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changefavoritesmodel;

  void changeFavorites(int? productId) {
    favourites[productId] = !(favourites[productId] ?? false);
    emit(ShopLoadingChangeFavoritesState());

    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changefavoritesmodel = ChangeFavoritesModel.fromjson(value.data);
      //print(value.data);
      if (changefavoritesmodel!.status == false) {
        favourites[productId] = !(favourites[productId] ?? false);
      } else {
        getFavoriteData();
      }
      emit(ShopSuccessChangeFavoritesState(changefavoritesmodel!));
    }).catchError((error) {
      favourites[productId] = !(favourites[productId] ?? false);

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoriteData() {
    emit(FavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //print('Favorites ' + favoritesModel!.status.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  ProfileModel? profileModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      //print(profileModel!.data!.name);
      emit(ShopSuccessGetUserDataState(profileModel));
    }).catchError((error) {
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATEPROFILE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      //print(profileModel!.data!.name);
      emit(ShopSuccessGetUpdateUserState(profileModel));
    }).catchError((error) {
      emit(ShopErrorGetUpdateUserState());
    });
  }
}
