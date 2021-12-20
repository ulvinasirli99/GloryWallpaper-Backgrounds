import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app_flutter/model/pro/img_model_pro.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/full_image.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/ui/network_error.dart';
import 'package:wallpaper_app_flutter/service/http/api_provider.dart';
import 'package:wallpaper_app_flutter/service/http/pro_image_api_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';

class CategoryToImageList extends StatefulWidget {
  String imageUrl;

  CategoryToImageList({Key key, this.imageUrl}) : super(key: key);

  @override
  _CategoryToImageListState createState() => _CategoryToImageListState();
}

class _CategoryToImageListState extends State<CategoryToImageList> {
  var _gridController = ScrollController();
  int _page = pageNumber;
  String img;
  var photos = List<Photo>.empty(growable: true);

  var imageLoadingSpinKit = SpinKitPulse(
    size: 60,
    color: Colors.redAccent,
    duration: Duration(milliseconds: 2000),
  );

  @override
  void initState() {
    super.initState();
    resetSearch();
    img = widget.imageUrl;
    _gridController.addListener(_scrollListener);
    _loadSearchImages(img);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: gridImageListView(),
          ),
          Positioned(
            left: 10.0,
            top: 35.0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white70,
                ),
                width: 50,
                height: 50,
                child: Center(
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  gridImageListView() {
    return (photos.length > 0)
        ? GridView.builder(
            controller: _gridController,
            itemCount: photos.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              if (index == photos.length) {
                return Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 30,
                    height: 30,
                  ),
                );
              }
              return Hero(
                tag: photos[index].src.large2X,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => FullImage(
                          imgUrl: photos[index].src.large2X,
                          imgIndex: index,
                          imgsList: photos,
                          //Bura onsa isdemir
                          imageName: photos[index].photographer,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/load.gif'),
                        image: NetworkImage(photos[index].src.portrait),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Lottie.asset(
              'assets/circle_loading_lottie.json',
              width: 70,
              height: 70,
            ),
          );
  }

  //Todo Sekillerin ele gec gelmesi try ve catch ile baglidir cunki search da ele deyil
  _loadSearchImages(String query) async {
    try {
      var model =
          await ProImageApiProvider().getSearchedProImages(query, ++_page);
      photos.addAll(model.photos);
      setState(() {});
    } catch (e) {}
  }

  _scrollListener() {
    if (_gridController.offset >= _gridController.position.maxScrollExtent &&
        !_gridController.position.outOfRange) {
      _loadSearchImages(rApiTexts);
    }
  }

  @override
  void dispose() {
    super.dispose();
    resetSearch();
  }

  resetSearch() {
    photos.clear();
    _page = 0;
  }
}
