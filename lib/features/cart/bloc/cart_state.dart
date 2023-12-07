part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartNavigateToWishListPageActionState extends CartActionState {}

class CartNavigateToHomePageActionState extends CartActionState {}
