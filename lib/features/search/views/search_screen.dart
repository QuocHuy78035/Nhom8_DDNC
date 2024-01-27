import 'package:ddnangcao_project/features/main/views/detail_food_screen.dart';
import 'package:ddnangcao_project/models/food.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import '../../../utils/color_lib.dart';
import '../../main/views/store_category_screen.dart';
import '../controllers/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearch = false;
  Color colorBackground = ColorLib.primaryColor;
  Color colorText = ColorLib.blackColor;
  final TextEditingController textEditingController = TextEditingController();
  List<Color> backgroundColor = [
    ColorLib.primaryColor,
    ColorLib.whiteColor,
    ColorLib.whiteColor
  ];
  List<Color> textColor = [
    ColorLib.whiteColor,
    ColorLib.blackColor,
    ColorLib.blackColor
  ];

  List<FoodModel> listFood = [];
  final SearchFoodController searchController = SearchFoodController();

  search(String searchValue) async {
    setState(() {
      isSearch = true;
    });
    listFood = await searchController.searchFood(searchValue);
  }

  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: textEditingController,
                        onChanged: (value) {
                          searchValue = value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                search(searchValue);
                              });
                            },
                            child: const Icon(Icons.search),
                          ),
                          hintText: "Search Food, Drink, ...",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: ColorLib.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: ColorLib.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Text("Sort by",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (backgroundColor[0] == ColorLib.primaryColor) {
                                return;
                              } else {
                                backgroundColor[0] = ColorLib.primaryColor;
                                backgroundColor[1] = ColorLib.whiteColor;
                                backgroundColor[2] = ColorLib.whiteColor;
                                textColor[0] = ColorLib.whiteColor;
                                textColor[1] = ColorLib.blackColor;
                                textColor[2] = ColorLib.blackColor;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: backgroundColor[0],
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Newest",
                              style: TextStyle(color: textColor[0]),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (backgroundColor[1] == ColorLib.primaryColor) {
                                return;
                              } else {
                                backgroundColor[0] = ColorLib.whiteColor;
                                backgroundColor[1] = ColorLib.primaryColor;
                                backgroundColor[2] = ColorLib.whiteColor;
                                textColor[0] = ColorLib.blackColor;
                                textColor[1] = ColorLib.whiteColor;
                                textColor[2] = ColorLib.blackColor;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: backgroundColor[1],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Rating",
                              style: TextStyle(color: textColor[1]),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (backgroundColor[2] == ColorLib.primaryColor) {
                                return;
                              } else {
                                backgroundColor[0] = ColorLib.whiteColor;
                                backgroundColor[1] = ColorLib.whiteColor;
                                backgroundColor[2] = ColorLib.primaryColor;
                                textColor[0] = ColorLib.blackColor;
                                textColor[1] = ColorLib.blackColor;
                                textColor[2] = ColorLib.whiteColor;
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: backgroundColor[2],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Nearest",
                              style: TextStyle(color: textColor[2]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isSearch == true
                      ? FutureBuilder(
                          future: search(searchValue),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                color: Colors.black12.withOpacity(0.05),
                                height: GetSize.getHeight(context)*.77,
                                width: GetSize.getWidth(context),
                                child: ListView.builder(
                                  itemCount: listFood.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailFoodScreen(
                                                      foodName:
                                                      listFood[index].name ??
                                                          "",
                                                      price:
                                                      listFood[index].price ??
                                                          0,
                                                      image: listFood[index].image,
                                                      foodId:
                                                      listFood[index].id ?? "",
                                                    ),
                                              ),
                                            );
                                          },
                                          child: FoodSearch(
                                            left: listFood[index].left,
                                            sold: listFood[index].sold,
                                            name: listFood[index].name ?? "",
                                            price: listFood[index].price,
                                            rating: listFood[index].rating,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: GetSize.symmetricPadding * 2,
                                    vertical: 10),
                                color: Colors.black12.withOpacity(0.05),
                                height: GetSize.getHeight(context) * 0.85,
                                width: GetSize.getWidth(context),
                                child: ListView.separated(
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  itemCount: listFood.length,
                                  itemBuilder: (context, index) =>
                                      const NewsCardSkelton(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16),
                                ),
                              );
                            }
                          },
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FoodSearch extends StatelessWidget {
  final String? name;
  final String? image;
  final int? price;
  final int? rating;
  final int? left;
  final int? sold;
  final String? id;

  const FoodSearch({
    super.key,
    this.name,
    this.id,
    this.image,
    this.price,
    this.rating,
    this.left,
    this.sold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/foods/food_search.png",
          width: 88,
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: GetSize.getWidth(context) * 0.62,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$name",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
              Text(
                "Cost: $price",
                maxLines: 1,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 20,
                        color: ColorLib.primaryColor,
                      ),
                      Text(
                        "Left: $left",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: ColorLib.primaryColor,
                        size: 20,
                      ),
                      Text(
                        "Sold: $sold",
                        style: const TextStyle(color: Colors.grey),
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
        )
      ],
    );
  }
}
