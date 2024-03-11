import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/features/food/controllers/food_controller.dart';
import 'package:ddnangcao_project/features/order/views/confirm_order_screen.dart';
import 'package:ddnangcao_project/models/comment.dart';
import 'package:ddnangcao_project/providers/food_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import 'package:intl/intl.dart';

class DetailFoodScreen extends StatefulWidget {
  final String storeName;
  final String storeId;
  final String foodName;
  final String foodId;
  final int price;
  final String? image;
  final int? sold;
  final int? left;

  const DetailFoodScreen(
      {super.key,
      required this.foodName,
      required this.storeName,
      required this.price,
      required this.image,
      this.left,
        required this.storeId,
      this.sold,
      required this.foodId});

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  late int value = 1;
  bool isPressed = false;
  bool isShowBottomSheet = false;
  final FoodController foodController = FoodController();
  List<bool> checkLiked = [];

  addLiked() async {
    List<CommentModel> comment = [];
    comment = await foodController.getAllComment(widget.foodId);
    List<String> commentId = [];
    for (int i = 0; i < comment.length; i++) {
      commentId.add(comment[i].id ?? "");
    }
    for (int i = 0; i < commentId.length; i++) {
      Provider.of<FoodProvider>(context, listen: false)
          .checkLiked(commentId[i]);
      checkLiked.add(
          await foodController.checkUserLikeCommentByCommentId(commentId[i]));
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<FoodProvider>(context, listen: false)
        .getAllCommentByFoodId(widget.foodId);
    Provider.of<FoodProvider>(context, listen: false)
        .checkFavourite(widget.foodId);
    addLiked();
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
                  height: GetSize.getHeight(context) / 3,
                  color: ColorLib.secondaryColor,
                  width: GetSize.getWidth(context),
                  child: CachedNetworkImage(
                      width: GetSize.getWidth(context),
                      imageUrl: "https://th.bing.com/th/id/R.d"
                          "50eab534c61dc2c1222d5194fb4e197?rik=sqB090P7XC8Pvw&pid=ImgRaw&r=0",
                      placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          )),
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
                      Consumer<FoodProvider>(
                        builder: (context, value, child) {
                          return IconButton(
                            onPressed: () {
                              if (value.isFavourite == false) {
                                value.addFavouriteFood(widget.foodId, context);
                              } else if (value.isFavourite == true) {
                                value.deleteFavouriteFood(
                                    widget.foodId, context);
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
                        },
                      )
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(widget.price),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: ColorLib.primaryColor,
                          fontSize: 22,
                        ),
                      ),
                      isPressed == false || value == 0
                          ? Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: ColorLib.primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: () {
                                  Provider.of<FoodProvider>(context, listen: false).addToCart(widget.foodId, 1, context);
                                  setState(() {
                                    isPressed = !isPressed;
                                    value = 1;
                                    isShowBottomSheet = true;
                                  });
                                },
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 40,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorLib.primaryColor),
                                        ),
                                        height: 30,
                                        width: 30,
                                        child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              value -= 1;
                                              if (value < 1) {
                                                isPressed = false;
                                                isShowBottomSheet = false;
                                              }
                                              if (value < 1) value = 1;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 14,
                                            color: ColorLib.primaryColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "$value",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: ColorLib.primaryColor),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                            size: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   width: GetSize.getWidth(context) * 0.5,
                                //   child: ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //         backgroundColor: ColorLib.primaryColor),
                                //     onPressed: () {
                                //       //addToCart();
                                //       Provider.of<FoodProvider>(context, listen: false).addToCart(widget.foodId, value, context);
                                //     },
                                //     child: const Text(
                                //       "Add To Cart",
                                //       style: TextStyle(color: Colors.white, fontSize: 18),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Distance(
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Text(
                "Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Consumer<FoodProvider>(
                builder: (context, value, child) {
                  if (value.listComment.isEmpty) {
                    return const Center(
                      child: Text("No have comment"),
                    );
                  } else if (value.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: GetSize.getHeight(context) * 0.9,
                          width: GetSize.getWidth(context),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.listComment.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        radius: 15,
                                        child: Icon(Icons.person),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(value.listComment[index].user
                                                  ?.name ??
                                              ""),
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            itemSize: 20,
                                            initialRating: double.parse(value
                                                    .listComment[index]
                                                    .rating ??
                                                "1"),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (value) {},
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          SizedBox(
                                            width: GetSize.getWidth(context) *
                                                0.78,
                                            child: Text(value.listComment[index]
                                                    .comment ??
                                                ""),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 100,
                                            width: 100,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                value.listComment[index]
                                                        .createdAt ??
                                                    "",
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Row(
                                                children: [
                                                  if (checkLiked.isNotEmpty &&
                                                      index < checkLiked.length)
                                                    checkLiked[index] == false
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              foodController
                                                                  .likedComment(value
                                                                          .listComment[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                              setState(() {
                                                                checkLiked[
                                                                        index] =
                                                                    true;
                                                                value
                                                                    .listComment[
                                                                        index]
                                                                    .usersLiked
                                                                    ?.length += 1;
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .thumb_up_alt_outlined,
                                                              size: 20,
                                                              color: ColorLib
                                                                  .primaryColor,
                                                            ),
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              foodController
                                                                  .unLikedComment(value
                                                                          .listComment[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                              setState(() {
                                                                checkLiked[
                                                                        index] =
                                                                    false;
                                                                value
                                                                    .listComment[
                                                                        index]
                                                                    .usersLiked
                                                                    ?.length -= 1;
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.thumb_up,
                                                              size: 20,
                                                              color: ColorLib
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                      "${value.listComment[index].usersLiked?.length}")
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Distance(
                                    height: .5,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomSheet: isShowBottomSheet == true
          ? BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            size: 35,
                          ),
                          Positioned(
                            top: -4,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorLib.primaryColor),
                              child: Text(
                                "$value",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Total: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(value * widget.price)}",
                        style: const TextStyle(
                            fontSize: 18, color: ColorLib.primaryColor),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorLib.primaryColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmOrderScreen(
                                  price: widget.price * value,
                                  storeName: widget.storeName,
                                  imageUrl: "",
                                  quantity: value,
                                  foodName: widget.foodName,
                                  foodId: widget.foodId
                                ),
                              ),
                            );
                          },
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
            )
          : Container(
              height: 1,
            ),
    );
  }
}

class Distance extends StatelessWidget {
  final double height;

  const Distance({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: GetSize.getWidth(context),
      color: Colors.black12,
    );
  }
}
