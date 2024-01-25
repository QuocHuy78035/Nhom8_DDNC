import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/features/favourite/controllers/favourite_controller.dart';
import 'package:ddnangcao_project/features/main/controllers/main_controller.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import 'food_category_screen.dart';

class DetailFoodScreen extends StatefulWidget {
  final String foodName;
  final String foodId;
  final int price;
  final String? image;

  const DetailFoodScreen(
      {super.key,
      required this.foodName,
      required this.price,
      required this.image, required this.foodId});

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  final FavouriteController favouriteController = FavouriteController();

  addFavouriteFood() async{
    String message = await favouriteController.addToFavourite(widget.foodId);
    if(message == GlobalVariable.addFavouriteFoodSuc){
      ShowSnackBar().showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
    }else{
      ShowSnackBar().showSnackBar("Add Food to favourite failed", ColorLib.primaryColor, ColorLib.blackColor, context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: ColorLib.secondaryColor,
                width: GetSize.getWidth(context),
                //height: GetSize.getHeight(context)*0.25,
                child: CachedNetworkImage(
                  width: GetSize.getWidth(context),
                  imageUrl:
                      "https://img.freepik.com/free-photo/pieces-chicken-fillet-with-mushrooms-stewed-tomato-sauce-with-boiled-broccoli-rice-proper-nutrition-healthy-lifestyle-dietetic-menu-top-view_2829-20015.jpg?w=1800&t=st=1706106791~exp=1706107391~hmac=adce1924f54eac72044ecc380626e874d2839da40b0da242f446ce0e7266bd86",
                  placeholder: (context, url) => Center(
                    child: Skeleton(
                        height: GetSize.getHeight(context) * 0.25,
                        width: GetSize.getWidth(context)),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                top: 30,
                right: 10,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: ColorLib.whiteColor,
                        size: 30,
                      ),
                    )),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: GetSize.getWidth(context) * 0.6,
                        child: Text(
                          widget.foodName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          addFavouriteFood();
                        },
                        icon: Icon(
                          Icons.favorite_outline,
                          size: 30,
                          color: ColorLib.primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${widget.price} VNĐ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ColorLib.primaryColor,
                      fontSize: 22,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
