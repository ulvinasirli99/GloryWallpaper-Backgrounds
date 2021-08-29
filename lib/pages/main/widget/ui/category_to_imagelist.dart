import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_app_flutter/model/local/image_model.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/full_image.dart';
import 'package:wallpaper_app_flutter/service/http/api_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';

class CategoryToImageList extends StatefulWidget {
  String imageUrl;

  CategoryToImageList({Key key, this.imageUrl}) : super(key: key);

  @override
  _CategoryToImageListState createState() => _CategoryToImageListState();
}

class _CategoryToImageListState extends State<CategoryToImageList> {
  var _gridController = ScrollController();
  var hits = List<Hits>.empty(growable: true);
  int _page = pageNumber;
  String img;

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
    return (hits.length > 0)
        ? GridView.builder(
            controller: _gridController,
            itemCount: hits.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              if (index == hits.length) {
                return Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 30,
                  height: 30,
                ));
              }
              return Hero(
                tag: hits[index].largeImageURL,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullImage(
                          imgUrl: hits[index].largeImageURL,
                            imgIndex: index,
                          imgsList: hits,
                          imageName: hits[index].user,
                            
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/load.gif'),
                          image: NetworkImage(hits[index].webformatURL),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  _loadSearchImages(String query) async {
    var model = await ApiProvider().getSearchedImages(query, ++_page);
    hits.addAll(model.hits);
    setState(() {});
  }

  _scrollListener() {
    if (_gridController.offset >= _gridController.position.maxScrollExtent &&
        !_gridController.position.outOfRange) {
      _loadSearchImages(img);
    }
  }
  resetSearch() {
    hits.clear();
    _page = 0;
  }
}
