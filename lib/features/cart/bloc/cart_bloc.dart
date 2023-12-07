import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitial);
    on<CartWishListButtonNavigateEvent>(cartWishListButtonNavigateEvent);
  }

  FutureOr<void> cartWishListButtonNavigateEvent(CartWishListButtonNavigateEvent event, Emitter<CartState> emit) {
  }

  FutureOr<void> cartInitial(CartInitialEvent event, Emitter<CartState> emit) {
  }
}
