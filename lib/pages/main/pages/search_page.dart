import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/localizations/app_localizations.dart';
import 'package:wallpaper_app_flutter/model/pro/img_model_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app_flutter/service/http/image/pro_image_api_provider.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/widget/global/toasts.dart';
import 'full_image.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var showSearchResult = false;
  var _gridController = ScrollController();
  var photos = List<Photo>.empty(growable: true);
  int _page = 0;
  FocusNode focusNode = FocusNode();

  var imageLoadingSpinKit = SpinKitPulse(
    size: 60,
    color: Colors.redAccent,
    duration: Duration(milliseconds: 2000),
  );

  @override
  void initState() {
    _gridController.addListener(_scrollListener);
    super.initState();
    resetSearch();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Container(
            color: Provider.of<Settings>(context).isDarkMode
                ? Colors.black
                : Colors.transparent,
            child: Form(
              key: formKey,
              child: TextField(
                autofocus: false,
                focusNode: focusNode,
                style: TextStyle(
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
                controller: _searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Provider.of<Settings>(context).isDarkMode
                        ? Colors.white.withOpacity(0.6)
                        : Colors.grey.shade400,
                  ),
                  hintText: ApplicationLocalizations.of(context)!
                      .translate('search_wallpaper'),
                ),
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    return error("Is not search a blank");
                  }
                  setState(() {
                    showSearchResult = true;
                  });
                  _saveSuggestions(value);
                  resetSearch();
                  _loadSearchImages(value);
                  FocusScope.of(context).unfocus();
                  setState(() {});
                },
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Provider.of<Settings>(context).isDarkMode
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () {
                _searchController.clear();
                resetSearch();
                showSearchResult = false;
                if (focusNode.hasFocus) {
                  FocusScope.of(context).unfocus();
                  setState(() {});
                }
                setState(() {});
              },
            )
          ],
        ),
        body: (showSearchResult) ? imagesGridList() : suggestionsWidget());
  }

  suggestionsWidget() {
    return FutureBuilder(
      future: _getSuggestions(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) return Container();
        return Container(
          color: Provider.of<Settings>(context).isDarkMode
              ? Colors.black
              : Colors.white,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.restore,
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.red
                      : Colors.black,
                ),
                title: Text(
                  snapshot.data![index],
                  style: TextStyle(
                    color: Provider.of<Settings>(context).isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  _searchController.text = snapshot.data![index];
                  setState(() {
                    showSearchResult = true;
                  });
                  _saveSuggestions(snapshot.data![index]);
                  resetSearch();
                  _loadSearchImages(snapshot.data![index]);
                },
              );
            },
          ),
        );
      },
    );
  }

  imagesGridList() {
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
                tag: photos[index].src!.large2X!,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => FullImage(
                          imgUrl: photos[index].src!.large2X!,
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
                        image: NetworkImage(photos[index].src!.portrait!),
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

  resetSearch() {
    photos.clear();
    _page = 0;
  }

  _loadSearchImages(String query) async {
    try {
      var model =
          await ProImageApiProvider().getSearchedProImages(query, ++_page);
      photos.addAll(model.photos!);
      setState(() {});
    } catch (e) {}
  }

  _scrollListener() {
    if (_gridController.offset >= _gridController.position.maxScrollExtent &&
        !_gridController.position.outOfRange) {
      _loadSearchImages(_searchController.text);
    }
  }

  Future<List<String>> _getSuggestions() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> suggestions = prefs.getStringList('suggestions_list') ??
        List<String>.empty(growable: true);
    return suggestions;
  }

  _saveSuggestions(String value) async {
    var prefs = await SharedPreferences.getInstance();
    List<String> suggestions = prefs.getStringList('suggestions_list') ??
        List<String>.empty(growable: true);
    if (!suggestions.contains(value)) {
      suggestions.insert(0, value);
    } else {
      var existingIndex = suggestions.indexOf(value);
      suggestions.removeAt(existingIndex);
      suggestions.insert(0, value);
    }
    if (suggestions.length > 5) {
      suggestions.removeLast();
    }
    prefs.setStringList('suggestions_list', suggestions);
  }
}
