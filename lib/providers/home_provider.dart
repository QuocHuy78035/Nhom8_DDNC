import 'package:ddnangcao_project/features/main/controllers/main_controller.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';

class HomeProvider extends ChangeNotifier{
  bool isLoading = false;
  List<CategoryModel> listCate = [];
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
}