import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => state is! FavoritesLoadingState,
            widgetBuilder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                'My Wishlist',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${ShopCubit.get(context).favoritesModel!.data.total} items)',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          )),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => favoriteProducts(
                              ShopCubit.get(context)
                                  .favoritesModel!
                                  .data
                                  .data[index]
                                  .product,
                              context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: ShopCubit.get(context)
                              .favoritesModel!
                              .data
                              .data
                              .length),
                    ],
                  ),
                ),
            fallbackBuilder: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
