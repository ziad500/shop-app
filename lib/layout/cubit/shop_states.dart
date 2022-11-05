import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/profile_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNav extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopLoadingChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ProfileModel? profileModel;

  ShopSuccessGetUserDataState(this.profileModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class FavoritesLoadingState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessGetUpdateUserState extends ShopStates {
  final ProfileModel? profileModel;

  ShopSuccessGetUpdateUserState(this.profileModel);
}

class ShopErrorGetUpdateUserState extends ShopStates {}
