import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import '../../../utils/color_lib.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                        decoration: InputDecoration(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Japanese Noodle",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text(
                                "Western Food, Main Course, Halal, Pasta, Sauce...",
                                maxLines: 1,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: ColorLib.primaryColor,
                                      ),
                                      Text(
                                        "500 m",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: ColorLib.primaryColor,
                                        size: 20,
                                      ),
                                      Text(
                                        "10 minute",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: ColorLib.primaryColor,
                                        size: 20,
                                      ),
                                      Text(
                                        "4.5",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              )
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
        ),
      ),
    );
  }
}
