import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:octo_image/octo_image.dart';
import 'package:random_color/random_color.dart';
import 'package:wallpaper_app_flutter/model/local/categorie_model.dart';
import 'package:wallpaper_app_flutter/model/local/catgory_color_model.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/ui/category_to_imagelist.dart';
import 'package:wallpaper_app_flutter/service/http/category_data.dart';
import 'package:wallpaper_app_flutter/service/http/local/catgory_color_data.dart';
import 'package:wallpaper_app_flutter/widget/text/custom_text.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CatgoryColorModel> colorModelList = new List.empty(growable: true);
  List<CategorieModel> categories = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    colorModelList = getCatgoryColors();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 25),
            child: CustomText(
              text: 'CATEGORY',
              textSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 50,
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: colorModelList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryToImageList(
                            imageUrl: colorModelList[index].categorieName,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: colorModelList[index].colorName,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (ctx, position) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryToImageList(
                          imageUrl: categories[position].categorieName,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 120,
                        height: 90,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            OctoImage(
                              fit: BoxFit.cover,
                              fadeInCurve: Curves.easeInCubic,
                              fadeOutCurve: Curves.easeOutSine,
                              image: NetworkImage(categories[position].imgUrl),
                              progressIndicatorBuilder: (context, progress) {
                                return Center(
                                  child: Lottie.asset(
                                    'assets/circle_loading_lottie.json',
                                    width: 70,
                                    height: 70,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stacktrace) =>
                                  Center(
                                child: Icon(
                                  Icons.error,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                text: categories[position].categorieName,
                                textSize: 28,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}