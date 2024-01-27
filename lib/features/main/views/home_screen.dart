import 'package:carousel_slider/carousel_slider.dart';
import 'package:ddnangcao_project/features/main/controllers/main_controller.dart';
import 'package:ddnangcao_project/features/search/views/search_screen.dart';
import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';

import 'store_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainController mainController = MainController();
  List<CategoryModel> listCate = [];

  getAllCategory() async {
    listCate = await mainController.findAllCate();
  }

  @override
  Widget build(BuildContext context) {
    final myBanner = [
      Image.asset("assets/images/banners/Banner.png"),
      Image.asset("assets/images/banners/Banner.png"),
      Image.asset("assets/images/banners/Banner.png"),
      Image.asset("assets/images/banners/Banner.png"),
      Image.asset("assets/images/banners/Banner.png"),
    ];
    return Scaffold(
      appBar: const MyAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding * 2),
            child: Column(
              children: [
                CarouselSlider(
                  items: myBanner,
                  options: CarouselOptions(
                      autoPlay: true,
                      height: 184,
                      aspectRatio: 2.0,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayInterval: const Duration(milliseconds: 3000),
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {}),
                ),
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: getAllCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: 60,
                              width: GetSize.getWidth(context),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listCate.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FoodCategoryScreen(
                                            cateName:
                                                "${listCate[index].cateName}",
                                            caterId:
                                                "${listCate[index].cateId}",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Category(
                                      categoryName:
                                          "${listCate[index].cateName}",
                                      imageUrl:
                                          "assets/images/categories/dessert.png",
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Top Rating Restaurant🔥",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 65,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorLib.secondaryColor),
                            child: TextButton(
                              onPressed: (){
                              },
                              child: const Text(
                                "See all",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: ColorLib.primaryColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 260,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const RestaurantOrderScreen(),
                              //   ),
                              // );
                            },
                            child: const Row(
                              children: [
                                Food(),
                                SizedBox(
                                  width: 30,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Food extends StatelessWidget {
  const Food({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: SizedBox(
                  width: 280,
                  child: Image.asset("assets/images/foods/food01.png"),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 230,
                      child: Text(
                        "Crazy tacko",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 230,
                      child: Text(
                        "Delicouse tackos, appetizing snacks, fr...",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                              child: Image.asset(
                                  "assets/images/foods/truck-fast.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("€3,00")
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                              child:
                                  Image.asset("assets/images/foods/timer.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("40-50min")
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                              child: Image.asset(
                                  "assets/images/foods/star-Filled.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("4.5")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String categoryName;
  final String imageUrl;

  const Category(
      {super.key, required this.categoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(imageUrl),
            ),
            Text(categoryName)
          ],
        ),
        const SizedBox(
          width: 20,
        )
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen()));
            },
            child: Container(
              height: 40,
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
                    "Search menu, food or drink",
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
