import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/providers/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import 'store_category_screen.dart';

class DetailFoodScreen extends StatefulWidget {
  final String foodName;
  final String foodId;
  final int price;
  final String? image;
  final int? sold;
  final int? left;

  const DetailFoodScreen(
      {super.key,
      required this.foodName,
      required this.price,
      required this.image,
      this.left,
      this.sold,
      required this.foodId});

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  late int value = 1;
  @override
  void initState() {
    super.initState();
    Provider.of<FoodProvider>(context, listen: false).checkFavourite(widget.foodId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        width: GetSize.getWidth(context),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: ColorLib.whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: GetSize.getWidth(context) * 0.6,
                        child: Text(
                          widget.foodName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Consumer<FoodProvider>(builder: (context, value, child){
                        return IconButton(
                          onPressed: () {
                            if (value.isFavourite == false) {
                              value.addFavouriteFood(widget.foodId, context);
                            } else if (value.isFavourite == true) {
                              value.deleteFavouriteFood(widget.foodId, context);
                            }
                          },
                          icon: value.isFavourite == false
                              ? const Icon(
                            Icons.favorite_outline,
                            size: 30,
                            color: ColorLib.primaryColor,
                          )
                              : const Icon(
                            Icons.favorite,
                            size: 30,
                            color: ColorLib.primaryColor,
                          ),
                        );
                      })
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${widget.sold} sold',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 14,
                        width: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${widget.left} left',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorLib.secondaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorLib.primaryColor,
                          ),
                          height: 26,
                          width: 26,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                value -= 1;
                                if (value < 1) value = 1;
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 10,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "$value",
                          style: const TextStyle(
                              fontSize: 20, color: ColorLib.primaryColor),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorLib.primaryColor,
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                value += 1;
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: GetSize.getWidth(context) * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorLib.primaryColor),
                      onPressed: () {
                        //addToCart();
                        Provider.of<FoodProvider>(context, listen: false).addToCart(widget.foodId, value, context);
                      },
                      child: const Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Distance(),
            const Text("Reviews")
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total: ${value * widget.price} VND",
                  style: const TextStyle(
                    fontSize: 18,
                    color: ColorLib.primaryColor
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorLib.primaryColor),
                    onPressed: () {},
                    child: const Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Distance extends StatelessWidget {
  const Distance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 2,
          width: GetSize.getWidth(context),
          color: Colors.black12,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
