// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:wallpaper_app_flutter/pages/main/widget/ui/edit_to_setwall.dart';
// import 'package:wallpaper_app_flutter/utils/filters/image_filters.dart';
// import 'dart:ui' as ui;

// class EditImage extends StatefulWidget {
//   final String? image;

//   const EditImage({Key? key, this.image}) : super(key: key);

//   @override
//   _EditImageState createState() => _EditImageState();
// }

// class _EditImageState extends State<EditImage> {
//   bool visibleActions = false;
//   List<double> checkColorList = <double>[];
//   final GlobalKey _globalKey = GlobalKey();

//   List matrixList = [
//     PURPLE,
//     WOTER,
//     DEEP,
//     BROW,
//     WATER,
//     BLUE,
//     RED,
//     MAGENTA,
//     ALPHA,
//     ELM,
//     YELLOW,
//     GRAYlIME,
//     BLACKlIGHT,
//     REDLIGHT,
//     BLACKSUNYY,
//   ];

//   void convertWidgetToImage() async {
//     RenderObject? repaintBoundary =
//         _globalKey.currentContext!.findRenderObject();
//     ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
//     ByteData? byteData =
//         await boxImage.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List uint8list = byteData!.buffer.asUint8List();
//     Navigator.of(_globalKey.currentContext).push(
//       MaterialPageRoute(
//         builder: (context) => EditToImageSetWallpaper(
//           imageData: uint8list,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: IconButton(
//             icon: Icon(
//               Icons.clear,
//               size: 35,
//               color: Colors.red[700],
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//               icon: Icon(
//                 Icons.check,
//                 size: 35,
//                 color: Colors.green,
//               ),
//               onPressed: () {
//                 setState(() {
//                   convertWidgetToImage();
//                 });
//               },
//             ),
//           )
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           RepaintBoundary(
//             key: _globalKey,
//             child: ColorFiltered(
//               colorFilter: ColorFilter.matrix(checkColorList),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(
//                       widget.image,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               margin: EdgeInsets.only(bottom: 50),
//               width: double.infinity,
//               height: 70,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: matrixList.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.only(left: 7, right: 7),
//                     width: 70,
//                     height: 80,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           print('DS ${matrixList[index]}');
//                           checkColorList = matrixList[index];
//                           print('MV ${checkColorList}');
//                         });
//                       },
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: ColorFiltered(
//                           colorFilter: ColorFilter.matrix(matrixList[index]),
//                           child: FadeInImage.assetNetwork(
//                             fit: BoxFit.cover,
//                             placeholder: 'assets/abstract.jpg',
//                             image: widget.image,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
