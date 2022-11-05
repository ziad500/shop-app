import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_cubit.dart';
import 'package:shop_app/modules/search/search_states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          builder: (context, state) {
            SearchCubit cubit = SearchCubit.get(context);
            return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          defaultFormField(context,
                              controller: searchController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'enter text to search';
                                }
                                return null;
                              },
                              label: 'Search',
                              prefix: Icons.search,
                              onSubmit: (String? text) {
                                cubit.search(text!);
                                return null;
                              }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          if (state is SearchLoadingState)
                            const LinearProgressIndicator(),
                          if (state is SearchSuccessState)
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    favoriteProducts(
                                        SearchCubit.get(context)
                                            .searchModel!
                                            .data
                                            .data[index],
                                        context,
                                        isOldPrice: false),
                                separatorBuilder: (context, index) =>
                                    myDivider(),
                                itemCount: SearchCubit.get(context)
                                    .searchModel!
                                    .data
                                    .data
                                    .length),
                        ],
                      ),
                    ),
                  ),
                ));
          },
          listener: (context, state) {},
        ));
  }
}
