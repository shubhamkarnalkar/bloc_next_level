import 'package:bloc_next_level/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_next_level/features/home/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/bloc/home_bloc.dart';
import '../../wishlist/ui/wishlist.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    // TODO: implement initState
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listenWhen: (previous, current) =>
          previous is HomeActionState && current is CartActionState,
      buildWhen: (previous, current) =>
          previous is HomeActionState && current is !CartActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is CartNavigateToHomePageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
        } else if (state is CartNavigateToWishListPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishList()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartInitial:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart Page'),
                actions: [
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartWishListButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border_outlined)),
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartHomeButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.home)),
                ],
              ),
              body: const CircularProgressIndicator(),
            );
          default:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart Page'),
              ),
              body: const Center(
                child: Text('data'),
              ),
            );
        }
      },
    );
  }
}


// return Scaffold(
//           appBar: AppBar(
//             title: const Text('Cart'),
//           ),
//         );