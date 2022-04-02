import 'dart:math';

//TODO ----------------------------------------------------------------------------------------------------------------------------------------

//Todo Api Keys List
List<String> _keys = [
  "20333608-1e9800e4acfe16f618cb42163",
  "14752801-6d7ddbc1c42c32540dde718cd",
];

List<String> _pexelsKeys = [
  "563492ad6f91700001000001f53ec8693c96404f82004d3b5ec0f2a3",
  "563492ad6f917000010000016d863348f46e41898d42d3f0caea37c8",
  "563492ad6f91700001000001170a1aaf91314c06aa81a16c22e20d18",
];

//TODO ----------------------------------------------------------------------------------------------------------------------------------------

//? This is line service key ranodom
Random randomServiceKey = new Random();
String apiKey = _keys[randomServiceKey.nextInt(_keys.length)];

//TODO ----------------------------------------------------------------------------------------------------------------------------------------

//!This is ectentios
String apiUrl = 'https://pixabay.com/api/?key=$apiKey&';
const bool check = false;
const bool darkMode = false;
const String BarTitle = "4K Wallpaper";
const int per_page = 30;
final String tableUser = 'user';
final String columnId = '_id';
final String columnName = 'name';
final appShareUrl =
    "https://play.google.com/store/apps/details?id=master.tool.glorywallpaper";

//TODO ----------------------------------------------------------------------------------------------------------------------------------------

Random random = new Random();
int pageNumber = random.nextInt(40) + 1;

//TODO ----------------------------------------------------------------------------------------------------------------------------------------

const String DEVICE_ID = "3E32D34D6B30A210";
//! This is line MY_APP_BANNER_PUB
const String BANNER_ID = "ca-app-pub-5650147189899328/2727986914";
//!This is line MY_INTERSITITAL_PUB
const String INTERSITITAL_ID = "ca-app-pub-5650147189899328/4818199292";
//!This is line MY_REWARDA_AD_PUB
const String REWARD_AD = "ca-app-pub-5650147189899328/1077370611";

//Todo Admob Test ID........................

// final String BannerTestId = AdmobBanner.testAdUnitId;
// final String InterstitalTestId = AdmobInterstitial.testAdUnitId;
// final String RewardTestId = AdmobReward.testAdUnitId;

//TODO ----------------------------------------------------------------------------------------------------------------------------------------

//This is line random String Call Api Prpvodetr
List<String> randomApitext = [
  "wallpaper",
  "beatuy",
  "flower",
  "animals",
  "space",
  "forest",
  "colors",
  "dark",
  "life",
  "black",
];
Random randomStringKeys = new Random();
String rApiTexts =
    randomApitext[randomStringKeys.nextInt(randomApitext.length)];

//TODO -------------------------------------------------------------------------------------------------------------------

//Todo Local CarouselImage value ;....
List<String>? imgList;

List<String> videoList = [
  "https://vod-progressive.akamaized.net/exp=1639510491~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F509%2F20%2F502545915%2F2293524865.mp4~hmac=3e77363951255d7af4f279dd9cb120730caa7337e3cffca147cfd4b0f9e52b59/vimeo-prod-skyfire-std-us/01/509/20/502545915/2293524865.mp4?filename=pexels-anna-tarazevich-6550972.mp4",
  "https://vod-progressive.akamaized.net/exp=1639510541~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4048%2F16%2F420242840%2F1814695686.mp4~hmac=2f9fa864e24e92899ec49ea3f3d8b6523e40c8ebb250c1c5990170450284f00a/vimeo-prod-skyfire-std-us/01/4048/16/420242840/1814695686.mp4?filename=production+ID%3A4434370.mp4",
  "https://vod-progressive.akamaized.net/exp=1639510715~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F356%2F23%2F576784607%2F2724424619.mp4~hmac=f59c58aa2b6fe5fa45f61554e3e52dc973f61ecf5a440f8064eb481ed330b26a/vimeo-prod-skyfire-std-us/01/356/23/576784607/2724424619.mp4?filename=pexels-taryn-elliott-8820113.mp4",
];

String vidoUrl = videoList[random.nextInt(3)];
String realPexelKey = _pexelsKeys[random.nextInt(3)];
