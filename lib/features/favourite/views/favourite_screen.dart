import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/features/food/views/detail_food_screen.dart';
import 'package:ddnangcao_project/providers/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../main/views/store_category_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isGetFavouriteFood = true;

  @override
  void initState() {
    super.initState();
    Provider.of<FavouriteProvider>(context, listen: false)
        .getAllFavouriteFood();
    Provider.of<FavouriteProvider>(context, listen: false).getAllFavouriteRes();
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
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isGetFavouriteFood = true;
                        });
                      },
                      child: const Text(
                        'Favourite Food',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isGetFavouriteFood = false;
                        });
                      },
                      child: const Text(
                        'Favourite Store',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            isGetFavouriteFood == true
                ? Consumer<FavouriteProvider>(builder: (context, value, child) {
                    if (value.listFavouriteFood.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (value.isLoading) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: GetSize.symmetricPadding * 2,
                              vertical: 10),
                          color: Colors.black12.withOpacity(0.05),
                          height: GetSize.getHeight(context) * 0.85,
                          width: GetSize.getWidth(context),
                          child: ListView.separated(
                            itemCount: value.listFavouriteFood.length,
                            itemBuilder: (context, index) =>
                                const NewsCardSkelton(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
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
                                              builder: (context) =>
                                                  DetailFoodScreen(
                                                sold: value
                                                        .listFavouriteFood[
                                                            index]
                                                        .sold ??
                                                    0,
                                                left: value
                                                        .listFavouriteFood[
                                                            index]
                                                        .left ??
                                                    0,
                                                foodName: value
                                                        .listFavouriteFood[
                                                            index]
                                                        .name ??
                                                    "",
                                                price: value
                                                        .listFavouriteFood[
                                                            index]
                                                        .price ??
                                                    0,
                                                image: value
                                                    .listFavouriteFood[index]
                                                    .image,
                                                foodId: value
                                                        .listFavouriteFood[
                                                            index]
                                                        .id ??
                                                    "",
                                                storeName: '',
                                              ),
                                            ),
                                          );
                                        },
                                        child: FoodFavourite(
                                          left: value.listFavouriteFood[index]
                                                  .left ??
                                              0,
                                          sold: value.listFavouriteFood[index]
                                                  .sold ??
                                              0,
                                          name:
                                              "${value.listFavouriteFood[index].name}",
                                          price: NumberFormat.currency(
                                                  locale: 'vi_VN', symbol: '₫')
                                              .format(value
                                                  .listFavouriteFood[index]
                                                  .price),
                                          rating: value
                                              .listFavouriteFood[index].rating,
                                          image:
                                              "assets/images/foods/food_search.png",
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Provider.of<FavouriteProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteFavourite(
                                                    value
                                                            .listFavouriteFood[
                                                                index]
                                                            .id ??
                                                        "",
                                                    index,
                                                    context,
                                                    true);
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
                : Consumer<FavouriteProvider>(
                    builder: (context, value, child) {
                      if (value.listFavouriteRes.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (value.isLoading) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: GetSize.symmetricPadding * 2,
                                vertical: 10),
                            color: Colors.black12.withOpacity(0.05),
                            height: GetSize.getHeight(context) * 0.85,
                            width: GetSize.getWidth(context),
                            child: ListView.separated(
                              itemCount: value.listFavouriteRes.length,
                              itemBuilder: (context, index) =>
                                  const NewsCardSkelton(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
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
                            child: ListView.builder(
                              itemCount: value.listFavouriteRes.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: ResFavourite(
                                            timeOpen: value.listFavouriteRes[index].timeOpen,
                                            timeClose: value.listFavouriteRes[index].timeClose,
                                            name:
                                                "${value.listFavouriteRes[index].name}",
                                            rating: value
                                                .listFavouriteRes[index].rating,
                                            image: value
                                                .listFavouriteRes[index].image,
                                            distance: value
                                                    .listFavouriteRes[index]
                                                    .address ??
                                                "",
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Provider.of<FavouriteProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteFavourite(
                                                    value
                                                            .listFavouriteRes[
                                                                index]
                                                            .id ??
                                                        "",
                                                    index,
                                                    context,
                                                    false);
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: ColorLib.primaryColor,
                                            size: 36,
                                          ),
                                        )
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
                    },
                  )
          ],
        ),
      ),
    );
  }
}

class ResFavourite extends StatelessWidget {
  final String? name;
  final String? rating;
  final int? address;
  final String? image;
  final String distance;
  final String? timeOpen;
  final String? timeClose;

  const ResFavourite(
      {super.key,
      this.name,
      this.rating,
      this.timeClose,
      this.timeOpen,
      required this.distance,
      this.image,
      this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          width: 88,
          height: 88,
          imageUrl: image ?? "",
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: GetSize.getWidth(context) * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "$timeOpen - $timeClose",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 4,),
                  Container(
                    height: 14,
                    width: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4,),
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

class FoodFavourite extends StatelessWidget {
  final String name;
  final String? rating;
  final String? price;
  final String? image;
  final int left;
  final int sold;

  const FoodFavourite(
      {super.key,
      required this.name,
      required this.left,
      required this.sold,
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
                "Price: $price",
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
                  Row(
                    children: [
                      Text(
                        "Left: $left",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 16,
                        width: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Sold: $sold",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 16,
                        width: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Rating: $rating",
                        style: const TextStyle(color: Colors.black54),
                      )
                    ],
                  ),
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
