import 'dart:math';


//TODO ----------------------------------------------------------------------------------------------------------------------------------------

//Todo Api Keys List
List<String> _keys = [
  "20333608-1e9800e4acfe16f618cb42163",
  "14752801-6d7ddbc1c42c32540dde718cd",
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

final String DEVICE_ID = "3E32D34D6B30A210";
//! This is line MY_APP_BANNER_PUB
final String BANNER_ID = "ca-app-pub-5650147189899328/2727986914";
//!This is line MY_INTERSITITAL_PUB
final String INTERSITITAL_ID = "ca-app-pub-5650147189899328/4818199292";
//!This is line MY_REWARDA_AD_PUB
final String REWARD_AD = "ca-app-pub-5650147189899328/1077370611";

//Todo Admob Test ID........................

// final String BannerTestId = AdmobBanner.testAdUnitId;
// final String InterstitalTestId = AdmobInterstitial.testAdUnitId;
// final String RewardTestId = AdmobReward.testAdUnitId;

//TODO ----------------------------------------------------------------------------------------------------------------------------------------

//This is line random String Call Api Prpvodetr
List<String> randomApitext = [
  "wallpapers",
  "beatuy",
  "flower",
  "love",
  "animals",
  "space",
  "forest",
  "colors",
  "life"
];
Random randomStringKeys = new Random();
String rApiTexts =
    randomApitext[randomStringKeys.nextInt(randomApitext.length)];

//TODO -------------------------------------------------------------------------------------------------------------------
//Todo Local CarouselImage value ;....
List<String> imgList;
