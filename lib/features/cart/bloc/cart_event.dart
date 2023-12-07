part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartHomeButtonNavigateEvent extends CartEvent {}

class CartWishListButtonNavigateEvent extends CartEvent {}

class CartInitialEvent extends CartEvent {}
