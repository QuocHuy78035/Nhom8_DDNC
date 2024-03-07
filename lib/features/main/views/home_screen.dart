import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ddnangcao_project/features/search/views/search_screen.dart';
import 'package:ddnangcao_project/providers/home_provider.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'store_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentLocation;
  late bool servicePermission = true;
  late LocationPermission permission;

  String currentAddress = '';

  Future<void> _getCurrentLocationAndAddress() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      _currentLocation = await _getCurrentLocation();
      sharedPreferences.setDouble("latitude", _currentLocation!.latitude);
      sharedPreferences.setDouble("longitude", _currentLocation!.longitude);
      await _getAddress();
    } catch (e) {
      print("Error getting current location and address: $e");
    }
  }

  Future<Position> _getCurrentLocation() async {
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddress() async {
    try {
      List<Placemark> placesmarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      if (placesmarks.isNotEmpty ) {
        Placemark placemark = placesmarks[0];
        if(mounted){
          setState(() {
            currentAddress =
            "${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}, ";
          });
        }
      } else {
        setState(() {
          currentAddress = "Không thể tìm thấy địa chỉ.";
        });
      }
    } catch (e) {
      print("Error getting address: $e");
      setState(() {
        currentAddress = "Lỗi khi lấy địa chỉ.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
    Provider.of<HomeProvider>(context, listen: false).getAllCategory();
  }

  Future<void> _initializeState() async {
    try {
      await _getCurrentLocationAndAddress();
      Provider.of<HomeProvider>(context, listen: false).getAllCategory();
    } catch (e) {
      print("Error initializing state: $e");
    }
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
      appBar: MyAppBar(
        currentLocation: currentAddress,
      ),
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
                    Consumer<HomeProvider>(builder: (context, value, child) {
                      if (value.listCate.isEmpty) {
                        return const Center(
                          child: Center(
                            child: Text("No Have Item"),
                          ),
                        );
                      } else {
                        if (value.isLoading) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: 70,
                              width: GetSize.getWidth(context),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.listCate.length,
                                  itemBuilder: (context, index) {
                                    return const CardSkeltonHomeScreen();
                                  }),
                            ),
                          );
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: 70,
                              width: GetSize.getWidth(context),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: value.listCate.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FoodCategoryScreen(
                                            cateName:
                                                "${value.listCate[index].cateName}",
                                            caterId:
                                                "${value.listCate[index].cateId}",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right:
                                            index == value.listCate.length - 1
                                                ? 30
                                                : 0,
                                      ),
                                      child: Category(
                                        categoryName:
                                            "${value.listCate[index].cateName}",
                                        imageUrl:
                                            "${value.listCate[index].image}",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      }
                    }),
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
                              onPressed: () {},
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
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorLib.secondaryColor,
              ),
              //width: GetSize.getWidth(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (context, url) => const SizedBox(
                          height: 10,
                          child: CircularProgressIndicator(),
                        ),
                    errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        )),
              ),
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
  final String currentLocation;

  const MyAppBar({super.key, required this.currentLocation});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Current location",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: GetSize.getWidth(context) * 0.7,
                        child: Text(
                          currentLocation,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Icon(Icons.notifications_none_outlined)
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
                  builder: (context) => const SearchScreen(),
                ),
              );
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

class CardSkeltonHomeScreen extends StatelessWidget {
  const CardSkeltonHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Column(
          children: [
            CircleSkeleton(
              size: 50,
            ),
            SizedBox(
              height: 4,
            ),
            Skeleton(
              height: 16,
              width: 50,
            )
          ],
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
