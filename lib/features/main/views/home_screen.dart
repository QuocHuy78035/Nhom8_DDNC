import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  }

  Future<void> _initializeState() async {
    try {
      await _getCurrentLocationAndAddress();
    } catch (e) {
      print("Error initializing state: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        currentLocation: currentAddress,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding),
            child: Column(
              children: [
                Image.asset("assets/images/banners/Banner_vendor.png")
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
        ],
      ),
    );
  }
}
