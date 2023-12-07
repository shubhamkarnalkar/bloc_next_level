import 'package:bloc_next_level/features/cart/ui/cart.dart';
import 'package:bloc_next_level/features/home/models/home_product_data_model.dart';
import 'package:bloc_next_level/features/home/ui/product_tile_widget.dart';
import 'package:bloc_next_level/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../suppliments/drop_down.dart';
import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  String selectedVal = 'Something';
  getVal<ProductDataModel>(ProductDataModel val) {
    // selectedVal = val.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishList()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('My Grocery App'),
                // backgroundColor: Colors.tealAccent,
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishListButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border_outlined)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlutterFlowDropDown(
                      options: successState.products,
                      onChanged: getVal,
                      textStyle: const TextStyle(
                        fontSize: 100,
                      ),
                      elevation: 30,
                      borderWidth: 1,
                      borderRadius: 15,
                      borderColor: Theme.of(context).primaryColor,
                      margin: const EdgeInsets.all(5),
                      initialOption: successState.products[0].name.toString(),
                      height: 50,
                      width: double.maxFinite,
                      icon: const Icon(Icons.search),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Placeholder(
                        fallbackHeight: 200,
                      ),
                    ),
                    // SizedBox(
                    //   height: 200,
                    //   child: ListView.builder(
                    //     itemCount: successState.products.length,
                    //     itemBuilder: (context, index) => ProductTileWidget(
                    //         productDataModel: successState.products[index]),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );

          case HomeLoadedErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text('Default'),
              ),
            );
        }
      },
    );
  }
}
