import 'package:ddnangcao_project/features/main/views/restaurant_order_screen.dart';
import 'package:ddnangcao_project/features/restaurant/views/controllers/restaurant_controler.dart';
import 'package:ddnangcao_project/models/store.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final RestaurantController restaurantController = RestaurantController();
  late List<StoreModel> listStore = [];

  findAllRestaurant() async {
    listStore = await restaurantController.findAllStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: GetSize.symmetricPadding * 2),
          color: Colors.black12.withOpacity(0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Restaurant",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              FutureBuilder(
                future: findAllRestaurant(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: GetSize.getHeight(context) * 0.85,
                      width: GetSize.getWidth(context),
                      child: ListView.builder(
                        itemCount: listStore.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantOrderScreen(
                                          name: listStore[index].name ?? "",
                                          address:
                                              listStore[index].address ?? "",
                                          rating: listStore[index].rating ?? 0,
                                          timeOpen:
                                              listStore[index].timeOpen ?? "",
                                          timeClose:
                                              listStore[index].timeClose ?? "",
                                          storeId: listStore[index].id ?? "",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Restaurant(
                                    name: listStore[index].name ?? '',
                                    rating: listStore[index].rating ?? 0,
                                    address: listStore[index].address ?? "",
                                    image: listStore[index].image ?? '',
                                    timeOpen: listStore[index].timeOpen ?? '',
                                    timeClode: listStore[index].timeClose ?? '',
                                  )),
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
                      height: GetSize.getHeight(context) * 0.7,
                      width: GetSize.getWidth(context),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      )
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
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

class Restaurant extends StatelessWidget {
  final String name;
  final int rating;
  final String address;
  final String image;
  final String timeOpen;
  final String timeClode;

  const Restaurant(
      {super.key,
      required this.name,
      required this.rating,
      required this.address,
      required this.image,
      required this.timeOpen,
      required this.timeClode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GetSize.getWidth(context),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: SizedBox(
                  width: GetSize.getWidth(context),
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
                    SizedBox(
                      width: GetSize.getWidth(context)*0.9,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: GetSize.getWidth(context)*0.9,
                      child: Text(
                        address,
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
                              child:
                                  Image.asset("assets/images/foods/timer.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(timeOpen)
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
                            Text(timeClode)
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                              child: Image.asset(
                                  "assets/images/foods/star-Filled.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("$rating")
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
