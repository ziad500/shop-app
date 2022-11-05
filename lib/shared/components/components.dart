// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/styles/colors.dart';

import '../../layout/cubit/shop_cubit.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

Widget defaultFormField(
  context, {
  required TextEditingController controller,
  required TextInputType type,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
      style: Theme.of(context).textTheme.bodyText1,
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: defaultColor,
      ),
    );

void showToast({
  required String? text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: '$text',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.grey,
      ),
    );

Widget buildFavItem(
  model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model!.id);
                    },
                    icon: CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).favourites[model!.id] ??
                                    false
                                ? defaultColor
                                : Colors.grey[300],
                        /* 
                            ShopCubit.get(context).favourites[model!.id] == true
                                ? defaultColor
                                : Colors.grey, */
                        radius: 15.0,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ))),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
                Row(
                  children: [
                    if (model.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        color: Colors.red[900],
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 8.0),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: const TextStyle(
                            height: 1.3, color: defaultColor, fontSize: 12.0),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: const TextStyle(
                              height: 1.3,
                              color: Colors.grey,
                              fontSize: 10.0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      if (model.discount != 0)
                        Text(
                          '${model.discount!.round()}%',
                          style: const TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 14.0,
                          ),
                        ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget favoriteProducts(model, context, {bool isOldPrice = true}) {
  return InkWell(
    onTap: () {
      /* ShopCubit.get(context).getProductData(model!.id);
        navigateTo(context, ProductScreen()); */
    },
    child: Container(
      height: 180,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Image(
                  image: NetworkImage('${model!.image}'),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.name}',
                        style: const TextStyle(
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        'EGP ' '${model.price}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          'EGP' '${model.oldPrice}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey,
              ),
              TextButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(model.id);
/*                       ShopCubit.get(context).addToCart(model.id);
 */
                  },
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )),
              const Spacer(),
              const Icon(
                Icons.delete_outline_outlined,
                color: Colors.grey,
              ),
              TextButton(
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(model.id);
                    ShopCubit.get(context).getFavoriteData();
                  },
                  child: const Text('Remove',
                      style: TextStyle(
                        color: Colors.grey,
                      ))),
            ],
          )
        ],
      ),
    ),
  );
}
