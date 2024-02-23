import 'package:ddnangcao_project/features/main/views/food_store_category_screen.dart';
import 'package:ddnangcao_project/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';

class FoodCategoryScreen extends StatefulWidget {
  final String caterId;
  final String cateName;

  const FoodCategoryScreen(
      {super.key, required this.caterId, required this.cateName});

  @override
  State<FoodCategoryScreen> createState() => _FoodCategoryScreenState();
}

class _FoodCategoryScreenState extends State<FoodCategoryScreen> {

  Color colorBackground = ColorLib.primaryColor;
  Color colorText = ColorLib.blackColor;
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

  @override
  void initState(){
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getAllFood(widget.caterId);
    Provider.of<HomeProvider>(context, listen: false).getAllStoreByCateId(widget.caterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Of ${widget.cateName}"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GetSize.symmetricPadding * 2),
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
                  Consumer<HomeProvider>(builder: (context, value, child){
                    if(value.listStore.isEmpty){
                      return const Center(
                        child:Center(
                          child: Text("No Have Item"),
                        ),
                      );
                    }else{
                      if(value.isLoading){
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: GetSize.symmetricPadding * 2,
                              vertical: 10),
                          color: Colors.black12.withOpacity(0.05),
                          height: GetSize.getHeight(context) * 0.85,
                          width: GetSize.getWidth(context),
                          child: ListView.separated(
                            itemCount: value.listStore.length,
                            itemBuilder: (context, index) =>
                            const NewsCardSkelton(),
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                          ),
                        );
                      }else{
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: GetSize.symmetricPadding * 2,
                              vertical: 10),
                          color: Colors.black12.withOpacity(0.05),
                          height: GetSize.getHeight(context) * 0.85,
                          width: GetSize.getWidth(context),
                          child: ListView.builder(
                            itemCount: value.listStore.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FoodStoreCategoryScreen(
                                                cateName: widget.cateName,
                                                cateId: widget.caterId,
                                                storeId: value.listStore[index].id,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Store(
                                      name: '${value.listStore[index].name}',
                                      address: '${value.listStore[index].address}',
                                      rating: value.listStore[index].rating,
                                      timeClose: value.listStore[index].timeClose,
                                      timeOpen: value.listStore[index].timeOpen,
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
                      }
                    }
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Store extends StatelessWidget {
  final String name;
  final int? rating;
  final String? address;
  final String? timeClose;
  final String? timeOpen;
  final String? image;

  const Store(
      {super.key,
      required this.name,
      this.rating,
      required this.address,
      this.timeClose,
      this.timeOpen,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          image ?? "assets/images/foods/food_search.png",
          width: GetSize.getWidth(context) * 0.3,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "$address",
                maxLines: 3,
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
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        size: 20,
                        color: ColorLib.primaryColor,
                      ),
                      Text(
                        "$timeOpen",
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
                        "$timeClose",
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
              ),
            ],
          ),
        )
      ],
    );
  }
}

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Skeleton(height: 120, width: 120),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(width: 80),
              SizedBox(height: 16 / 2),
              Skeleton(),
              Skeleton(),
              SizedBox(height: 16 / 2),
              Row(
                children: [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16 / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
