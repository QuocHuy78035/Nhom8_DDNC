import 'package:ddnangcao_project/features/favourite/controllers/favourite_controller.dart';
import 'package:ddnangcao_project/features/main/views/detail_food_screen.dart';
import 'package:ddnangcao_project/providers/favourite_provider.dart';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/food_favourite.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../main/views/store_category_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  void initState(){
    super.initState();
    Provider.of<FavouriteProvider>(context, listen: false).getAllFavouriteFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Favourite Food',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<FavouriteProvider>(builder: (context, value, child){
              if(value.listFavouriteFood.isEmpty){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                if(value.isLoading){
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.separated(
                      itemCount: value.listFavouriteFood.length,
                      itemBuilder: (context, index) => const NewsCardSkelton(),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                    ),
                  );
                }else{
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2, vertical: 10),
                    color: Colors.black12.withOpacity(0.05),
                    height: GetSize.getHeight(context) * 0.85,
                    width: GetSize.getWidth(context),
                    child: ListView.builder(
                      itemCount: value.listFavouriteFood.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailFoodScreen(
                                          foodName:
                                          value.listFavouriteFood[index].name ??
                                              "",
                                          price:
                                          value.listFavouriteFood[index].price ??
                                              0,
                                          image: value.listFavouriteFood[index].image,
                                          foodId:
                                          value.listFavouriteFood[index].id ?? "",
                                        ),
                                      ),
                                    );
                                  },
                                  child: FoodFavourite(
                                    name: "${value.listFavouriteFood[index].name}",
                                    price: value.listFavouriteFood[index].price,
                                    rating: value.listFavouriteFood[index].rating,
                                    image:
                                    "assets/images/foods/food_search.png",
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Provider.of<FavouriteProvider>(context, listen: false).deleteFavourite(value.listFavouriteFood[index].id ?? "", index, context);
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
                              color: Colors.black12,
                              width: GetSize.getWidth(context),
                              height: 1,
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
              }
            })
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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GetSize.symmetricPadding * 2,
      ),
      child: Column(
        children: [
          SizedBox(
            height: GetSize.getHeight(context) * 0.06,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current location",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "TP.HCM",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.notifications_none_outlined)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: ColorLib.primaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: GetSize.symmetricPadding),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Search favourite menu, food or drink",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
