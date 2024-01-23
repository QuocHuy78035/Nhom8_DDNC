import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';

class DetailFoodScreen extends StatefulWidget {
  const DetailFoodScreen({super.key});

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.red,
                width: GetSize.getWidth(context),
                child: Image.asset(
                  'assets/images/foods/food_detail.png',
                  width: 10,
                ),
              ),
              Positioned(
                top: 30,
                right: 10,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: ColorLib.whiteColor,
                      size: 30,
                    ),
                  )
                ),
              )
            ],
          ),
          Text("Mon An")
        ],
      ),
    );
  }
}
