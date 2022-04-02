import 'package:colorlizer/colorlizer.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app_flutter/widget/text/custom_text.dart';

class UpdateNewFeature extends StatelessWidget {
  final VoidCallback? function;

  UpdateNewFeature({
    Key? key,
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
            height: screenSzie.height * 0.53,
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
                          color: ColorLizer().getRandomColors(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Errors on search page corrected.",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: ColorLizer().getRandomColors(),
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
                          color: ColorLizer().getRandomColors(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text:
                                "A number of adjustments were made to the design.",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: ColorLizer().getRandomColors(),
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
                          color: ColorLizer().getRandomColors(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text:
                                "Wallpapers have been replaced with more resolute images.",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: ColorLizer().getRandomColors(),
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
                          color: ColorLizer().getRandomColors(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Push notification errors fixed.",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: ColorLizer().getRandomColors(),
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
                          color: ColorLizer().getRandomColors(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomText(
                            text: "Dark mode errors fixed",
                            textSize: 18,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Divider(
                          color: ColorLizer().getRandomColors(),
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
