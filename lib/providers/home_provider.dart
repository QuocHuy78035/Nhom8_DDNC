import 'package:ddnangcao_project/features/main/controllers/main_controller.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';
import '../models/food.dart';
import '../models/store.dart';

class HomeProvider extends ChangeNotifier{
  bool isLoading = false;
  List<CategoryModel> listCate = [];

  List<FoodModel> listFood = [];
  List<StoreFindByCateIdModel> listStore = [];
  final MainController mainController = MainController();

  getAllCategory() async {
    try{
      listCate = await mainController.findAllCate();
    }
    catch(e){
      print("Fail to get all category provider");
    }finally{
      isLoading = false ;
      notifyListeners();
    }
  }

  getAllFood(String cateId) async {
    isLoading = true;
    try{
      listFood = await mainController.findAllFoodByCateId(cateId);
    }catch(e){
      print("Fail to get all food home_provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  getAllStoreByCateId(String cateId) async {
    isLoading = true;
    try{
      List<StoreFindByCateIdModel> tempStoreList =
      await mainController.findAllStoreByCateId(cateId);
      Set<String> storeIds = {};
      listStore.clear();

      for (var store in tempStoreList) {
        if (!storeIds.contains(store.id)) {
          storeIds.add(store.id ?? "");
          listStore.add(store);
        }
      }
    }catch(e){
      print("Fail to get all store by cateId home_provider");
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

}