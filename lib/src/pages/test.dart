// import 'package:flutter/material.dart';
// import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
//
// class ScalableText extends StatefulWidget {
//   final TextEditingController textController;
//   final ValueNotifier<Matrix4> notifier;
//   const ScalableText(
//       {super.key, required this.textController, required this.notifier});
//
//   @override
//   State<ScalableText> createState() => _ScalableTextState();
// }
//
// class _ScalableTextState extends State<ScalableText> {
//   @override
//   Widget build(BuildContext context) {
//     return MatrixGestureDetector(
//       onMatrixUpdate: (m, tm, sm, rm) {
//         widget.notifier.value = m;
//       },
//       child: AnimatedBuilder(
//         animation: widget.notifier,
//         builder: (ctx, child) {
//           return Transform(
//             transform: widget.notifier.value,
//             child: Center(
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     color: Colors.transparent,
//                     child: Transform.scale(
//                       scale:
//                       1, // make this dynamic to change the scaling as in the basic demo
//                       origin: Offset(0.0, 0.0),
//                       child: Container(
//                         color: Colors.red,
//                         height: 110,
//                         width: 110,
//                         child: Center(
//                           child: Text(
//                             widget.textController.text,
//                             style: const TextStyle(
//                                 fontSize: 26, color: Colors.blue),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }