import 'dart:math';
import 'package:ddnangcao_project/features/add_to_cart/controllers/add_to_cart_controller.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utils/size_lib.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final String foodName;
  final String storeName;
  final int quantity;
  final String imageUrl;
  final int price;
  final String foodId;

  const ConfirmOrderScreen(
      {super.key,
      required this.foodId,
      required this.foodName,
      required this.storeName,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final AddToCartController addToCartController = AddToCartController();
  var now = DateTime.now();
  var formatterDate = DateFormat('dd/MM');
  var formatterTime = DateFormat('kk:mm');
  Color colorTextNone = ColorLib.primaryColor;
  Color colorText5K = Colors.black;
  Color colorText10k = Colors.black;
  Color colorTextOther = Colors.black;
  bool isPressedNone = true;
  bool isPressed5K = false;
  bool isPressed10K = false;
  bool isPressedOther = false;
  bool isCheck = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Order"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              color: Colors.black.withOpacity(0.04),
              child: Column(
                children: [
                  //const Distance(height: 2),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: ColorLib.primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Delivery Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: GetSize.getWidth(context) * 0.65,
                                child: const Text(
                                    "01 Vo Van Ngan, Thu Duc, Thanh pho Ho Chi Minh, Thu Duc, Thanh pho Ho Chi Minh"),
                              )
                            ],
                          )
                        ],
                      ),
                      const Icon(Icons.navigate_next)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Distance(height: 1),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: ColorLib.primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Deliver Now - ${formatterTime.format(now)} - Today ${formatterDate.format(now)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.navigate_next)
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: GetSize.getWidth(context),
                    height: 6,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return const Row(
                          children: [
                            DecorateDistance(),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GetSize.symmetricPadding * 2),
                  child: Column(
                    children: [
                      Text(
                        widget.storeName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${widget.quantity} x ${widget.foodName}",
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                NumberFormat.currency(
                                        locale: 'vi_VN', symbol: '₫')
                                    .format(widget.price),
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal (${widget.quantity}) items"),
                          Text(
                            NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                .format(widget.price),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Distance(height: .5),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Shipping Fee (7.3km)"),
                          Text(
                            NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                .format(widget.price),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Distance(height: .5),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Applicable Fee"),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.help_outline,
                                  size: 18,
                                ),
                              )
                            ],
                          ),
                          Text(
                            NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                .format(2000),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Distance(height: .5),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                .format(102000),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorLib.primaryColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Tax included, where applicable",
                            style: TextStyle(color: Colors.black38),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Distance(height: 10),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GetSize.symmetricPadding * 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: ColorLib.primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Add Vorcher",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Select voucher",
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.navigate_next),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Distance(height: .5),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            color: ColorLib.primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tips for Driver",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      isPressedNone == true
                                          ? Positioned(
                                              top: -16,
                                              left: -34,
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                child: CustomPaint(
                                                  painter: TrianglePainter(
                                                    strokeColor:
                                                        ColorLib.primaryColor,
                                                    strokeWidth: 10,
                                                    paintingStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                  child: const SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      isPressedNone == true
                                          ? const Positioned(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            )
                                          : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPressedNone = !isPressedNone;
                                            isPressed5K = false;
                                            isPressedOther = false;
                                            isPressed10K = false;
                                            colorTextNone =
                                                ColorLib.primaryColor;
                                            colorText5K = Colors.black;
                                            colorText10k = Colors.black;
                                            colorTextOther = Colors.black;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: isPressedNone == true
                                                ? null
                                                : Colors.grey.withOpacity(0.3),
                                            border: isPressedNone == true
                                                ? Border.all(
                                                    color:
                                                        ColorLib.primaryColor,
                                                  )
                                                : null,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "None",
                                              style: TextStyle(
                                                  color: colorTextNone),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Stack(
                                    children: [
                                      isPressed5K == true
                                          ? Positioned(
                                              top: -16,
                                              left: -34,
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                child: CustomPaint(
                                                  painter: TrianglePainter(
                                                    strokeColor:
                                                        ColorLib.primaryColor,
                                                    strokeWidth: 10,
                                                    paintingStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                  child: const SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      isPressed5K == true
                                          ? const Positioned(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            )
                                          : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPressed5K = !isPressed5K;
                                            isPressedNone = false;
                                            isPressedOther = false;
                                            isPressed10K = false;
                                            colorText5K = ColorLib.primaryColor;
                                            colorTextNone = Colors.black;
                                            colorText10k = Colors.black;
                                            colorTextOther = Colors.black;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: isPressed5K == true
                                                ? null
                                                : Colors.grey.withOpacity(0.3),
                                            border: isPressed5K == true
                                                ? Border.all(
                                                    color:
                                                        ColorLib.primaryColor,
                                                  )
                                                : null,
                                          ),
                                          child: Center(
                                            child: Text("5K",
                                                style: TextStyle(
                                                    color: colorText5K)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Stack(
                                    children: [
                                      isPressed10K == true
                                          ? Positioned(
                                              top: -16,
                                              left: -34,
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                child: CustomPaint(
                                                  painter: TrianglePainter(
                                                    strokeColor:
                                                        ColorLib.primaryColor,
                                                    strokeWidth: 10,
                                                    paintingStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                  child: const SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      isPressed10K == true
                                          ? const Positioned(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            )
                                          : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPressed10K = !isPressed10K;
                                            isPressedNone = false;
                                            isPressedOther = false;
                                            isPressed5K = false;
                                            colorText10k =
                                                ColorLib.primaryColor;
                                            colorTextNone = Colors.black;
                                            colorText5K = Colors.black;
                                            colorTextOther = Colors.black;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: isPressed10K == true
                                                  ? null
                                                  : Colors.grey
                                                      .withOpacity(0.3),
                                              border: isPressed10K == true
                                                  ? Border.all(
                                                      color:
                                                          ColorLib.primaryColor)
                                                  : null),
                                          child: Center(
                                            child: Text(
                                              "10K",
                                              style: TextStyle(
                                                  color: colorText10k),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Stack(
                                    children: [
                                      isPressedOther == true
                                          ? Positioned(
                                              top: -16,
                                              left: -34,
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                child: CustomPaint(
                                                  painter: TrianglePainter(
                                                    strokeColor:
                                                        ColorLib.primaryColor,
                                                    strokeWidth: 10,
                                                    paintingStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                  child: const SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      isPressedOther == true
                                          ? const Positioned(
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            )
                                          : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPressedOther = !isPressedOther;
                                            isPressedNone = false;
                                            isPressed10K = false;
                                            isPressed5K = false;
                                            colorTextOther =
                                                ColorLib.primaryColor;
                                            colorTextNone = Colors.black;
                                            colorText5K = Colors.black;
                                            colorText10k = Colors.black;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: isPressedOther == true
                                                ? null
                                                : Colors.grey.withOpacity(0.3),
                                            border: isPressedOther == true
                                                ? Border.all(
                                                    color:
                                                        ColorLib.primaryColor)
                                                : null,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Other",
                                              style: TextStyle(
                                                  color: colorTextOther),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Distance(height: .5),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.food_bank_outlined,
                                color: ColorLib.primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Take Cutlery',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Cutlery will be provied. \nLet\'s reduce waste on your next order',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.4)),
                                  )
                                ],
                              )
                            ],
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: isCheck,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                setState(() {
                                  isCheck = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Distance(height: 10),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GetSize.symmetricPadding * 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.my_library_books,
                        color: ColorLib.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "By clicking \"Place Order\", you agree to",
                            style: TextStyle(fontSize: 14),
                          ),
                          RichText(
                            text: const TextSpan(
                              text: 'Nhom8ShopFood ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'Term of service',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                TextSpan(
                                  text: 'Regulation.',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              addToCartController.updateCartDecrement(widget.foodId);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding),
              height: 45,
              width: GetSize.getWidth(context),
              decoration: const BoxDecoration(color: Colors.red),
              child: Center(
                child: Text(
                  "Place Order - ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(102000)}",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white.withOpacity(0.8)),
                ),
              ),
            ),
          );
        },
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

class DecorateDistance extends StatelessWidget {
  const DecorateDistance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          color: ColorLib.primaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          width: 30,
          color: Colors.blue,
        )
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    Matrix4 rotationMatrix = Matrix4.identity();
    rotationMatrix.translate(centerX, centerY);
    rotationMatrix.rotateZ(-90 * pi / 360);
    rotationMatrix.translate(-centerX, -centerY);

    Path path = Path()
      ..moveTo(size.width / 4, size.height / 2)
      ..lineTo(size.width / 2, size.height / 4)
      ..lineTo(size.width * 3 / 4, size.height / 2)
      ..lineTo(size.width / 4, size.height / 2);

    path = path.transform(rotationMatrix.storage);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
