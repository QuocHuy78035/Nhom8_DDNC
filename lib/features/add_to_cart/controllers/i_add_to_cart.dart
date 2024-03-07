import 'package:ddnangcao_project/models/food_cart.dart';

abstract class IAddToCart{
  Future<String> addToCart(String foodId, int quantity);
  Future<void> removeFromCart(String foodId);
  Future<List<FoodCartModel>> getAllCart();
  Future<String> updateCartDecrement(String foodId);
  Future<String> updateCartIncrement(String foodId);
}