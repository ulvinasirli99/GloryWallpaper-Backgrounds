import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/localizations/app_localizations.dart';
import 'package:wallpaper_app_flutter/model/local/image_model.dart';
import 'package:wallpaper_app_flutter/service/http/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';
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
  var hits = List<Hits>.empty(growable: true);
  int _page = 0;

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
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            color: Provider.of<Settings>(context).isDarkMode
                ? Colors.black
                : Colors.white,
            child: Form(
              key: formKey,
              child: TextField(
                autofocus: false,
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
                  hintText: ApplicationLocalizations.of(context)
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
                },
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
                resetSearch();
                showSearchResult = false;
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
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  Icons.restore,
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.red
                      : Colors.black,
                ),
                title: Text(
                  snapshot.data[index],
                  style: TextStyle(
                    color: Provider.of<Settings>(context).isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  _searchController.text = snapshot.data[index];
                  setState(() {
                    showSearchResult = true;
                  });
                  _saveSuggestions(snapshot.data[index]);
                  resetSearch();
                  _loadSearchImages(snapshot.data[index]);
                },
              );
            },
          ),
        );
      },
    );
  }

  imagesGridList() {
    return (hits.length > 0)
        ? GridView.builder(
            controller: _gridController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemCount: hits.length + 1,
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

  resetSearch() {
    hits.clear();
    _page = 0;
  }

  _loadSearchImages(String query) async {
    var model = await ApiProvider().getSearchedImages(query, ++_page);
    hits.addAll(model.hits);
    setState(() {});
  }

  _scrollListener() {
    if (_gridController.offset >= _gridController.position.maxScrollExtent &&
        !_gridController.position.outOfRange) {
      _loadSearchImages(_searchController.text);
    }
  }

  Future<List<String>> _getSuggestions() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> suggestions =
        prefs.getStringList('suggestions_list') ?? List<String>();
    return suggestions;
  }

  _saveSuggestions(String value) async {
    var prefs = await SharedPreferences.getInstance();
    List<String> suggestions =
        prefs.getStringList('suggestions_list') ?? List<String>();
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
