// import 'package:flutter/material.dart';
// import 'package:transformer_page_view/transformer_page_view.dart';

// class AccTransFormer extends PageTransformer {
//   @override
//   Widget transform(Widget child, TransformInfo info) {
//     double position = info.position;
//     if (position < 0.0) {
//       return new Transform.scale(
//         scale: 1 + position,
//         alignment: Alignment.topRight,
//         child: child,
//       );
//     } else {
//       return new Transform.scale(
//         scale: 1 - position,
//         alignment: Alignment.bottomLeft,
//         child: child,
//       );
//     }
//   }
// }
