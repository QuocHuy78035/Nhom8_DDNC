import 'package:ddnangcao_project/features/favourite/controllers/favourite_controller.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/food_favourite.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../main/views/food_category_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<FoodFavouriteModel> listFavouriteFood = [];
  final FavouriteController favouriteController = FavouriteController();

  getAllFavouriteFood() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    listFavouriteFood = await favouriteController.getAllFavouriteFoodByUserId(
        sharedPreferences.getString('userId') ?? "");
  }

  deleteFavourite(String foodId, int index) async {
    String message = await favouriteController.deleteFavourite(foodId);
    if (message != "") {
      setState(() {
        listFavouriteFood.removeAt(index);
      });
      ShowSnackBar()
          .showSnackBar(message, Colors.green, ColorLib.whiteColor, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourite")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getAllFavouriteFood(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.builder(
                      itemCount: listFavouriteFood.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: FoodFavourite(
                                    name: "${listFavouriteFood[index].name}",
                                    price: listFavouriteFood[index].price,
                                    rating: listFavouriteFood[index].rating,
                                    image:
                                        "assets/images/foods/food_search.png",
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteFavourite(
                                          listFavouriteFood[index].id ?? "",
                                          index);
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: ColorLib.primaryColor,
                                      size: 36,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: ColorLib.blackColor,
                              width: GetSize.getWidth(context),
                              height: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.separated(
                      itemCount: listFavouriteFood.length,
                      itemBuilder: (context, index) => const NewsCardSkelton(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FoodFavourite extends StatelessWidget {
  final String name;
  final int? rating;
  final int? price;
  final String? image;

  const FoodFavourite(
      {super.key,
      required this.name,
      this.rating,
      required this.price,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image ?? "assets/images/foods/food_search.png",
          width: 88,
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: GetSize.getWidth(context) * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              Text(
                "Price: $price VNĐ",
                maxLines: 1,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorLib.blackColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: ColorLib.primaryColor,
                      ),
                      Text(
                        "500 m",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: ColorLib.primaryColor,
                        size: 20,
                      ),
                      Text(
                        "$rating",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
