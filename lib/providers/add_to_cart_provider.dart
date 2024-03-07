import 'package:flutter/material.dart';
import '../features/add_to_cart/controllers/add_to_cart_controller.dart';
import '../models/food_cart.dart';
import '../utils/color_lib.dart';
import '../utils/global_variable.dart';
import '../utils/snack_bar.dart';

class AddToCartProvider extends ChangeNotifier {
  bool isLoading = false;

  List<FoodCartModel> listCart = [];
  final AddToCartController addToCartController = AddToCartController();

  getAllCart() async {
    isLoading = true;
    try {
      listCart = await addToCartController.getAllCart();
    } catch (e) {
      print("Fail to get all cart cart_provider $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  decrementCart(int index, BuildContext context) async {
    isLoading = true;
    try {
      String message = await addToCartController
          .updateCartDecrement("${listCart[index].food?.id}");
      if (message == GlobalVariable.updateCartSuc) {
        ShowSnackBar().showSnackBar(message, Colors.green, Colors.white, context);
        listCart[index].number = listCart[index].number! - 1;
        if(listCart[index].number == 0){
          listCart.removeAt(index);
        }
      } else {
        ShowSnackBar().showSnackBar("Fail to decrement value of cart",
            ColorLib.primaryColor, Colors.white, context);
      }

    } catch (e) {
      print("Fail to decrement cart cart_provider $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  increment(int index, BuildContext context) async {
    isLoading = true;
    try {
      String message = await addToCartController
          .updateCartIncrement("${listCart[index].food?.id}");
      if (message == GlobalVariable.updateCartSuc) {
        ShowSnackBar().showSnackBar(message, Colors.green, Colors.white, context);
        listCart[index].number = listCart[index].number! + 1;
      } else {
        ShowSnackBar().showSnackBar("Fail to increment value of cart",
            ColorLib.primaryColor, Colors.white, context);
      }
    } catch (e) {
      print("Fail to increment cart cart_provider $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
