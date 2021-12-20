import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:wallpaper_app_flutter/widget/text/custom_text.dart';

class UpdateNewFeature extends StatelessWidget {
  final Function function;

  UpdateNewFeature({
    Key key,
    this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSzie = MediaQuery.of(context).size;
    return Container(
      width: screenSzie.width * 0.8,
      height: screenSzie.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: screenSzie.width * 0.8,
            height: screenSzie.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.teal.shade200.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenSzie.height * 0.04),
                    child: CustomText(
                      text: "New Update Features",
                      textAlign: TextAlign.center,
                      textSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade500,
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CustomText(
                          text: "*",
                          textSize: 30,
                          fontWeight: FontWeight.w700,
                          color: RandomColor().randomColor(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Image resolution has been increased",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: RandomColor().randomMaterialColor(),
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 20,
                    indent: 17,
                    endIndent: 17,
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CustomText(
                          text: "*",
                          textSize: 30,
                          fontWeight: FontWeight.w700,
                          color: RandomColor().randomColor(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "The search page has been updated",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: RandomColor().randomMaterialColor(),
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 20,
                    indent: 17,
                    endIndent: 17,
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CustomText(
                          text: "*",
                          textSize: 30,
                          fontWeight: FontWeight.w700,
                          color: RandomColor().randomColor(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text:
                                "Innovations were made in the design of the main page",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: RandomColor().randomMaterialColor(),
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 20,
                    indent: 17,
                    endIndent: 17,
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CustomText(
                          text: "*",
                          textSize: 30,
                          fontWeight: FontWeight.w700,
                          color: RandomColor().randomColor(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "The link between the pages has been fixed",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: RandomColor().randomMaterialColor(),
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 20,
                    indent: 17,
                    endIndent: 17,
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CustomText(
                          text: "*",
                          textSize: 30,
                          fontWeight: FontWeight.w700,
                          color: RandomColor().randomColor(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Auto update added",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: RandomColor().randomMaterialColor(),
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 20,
                    indent: 17,
                    endIndent: 17,
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CustomText(
                          text: "*",
                          textSize: 30,
                          fontWeight: FontWeight.w700,
                          color: RandomColor().randomColor(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Image Slider with Animation",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: RandomColor().randomMaterialColor(),
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 20,
                    indent: 17,
                    endIndent: 17,
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CustomText(
                          text: "*",
                          textSize: 30,
                          fontWeight: FontWeight.w700,
                          color: RandomColor().randomColor(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Dark Mode bugs fixed",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: RandomColor().randomMaterialColor(),
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 20,
                    indent: 17,
                    endIndent: 17,
                    thickness: 1.2,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenSzie.height * 0.01,
          ),
          GestureDetector(
            onTap: function,
            child: Icon(
              Icons.check_circle,
              size: 55,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
