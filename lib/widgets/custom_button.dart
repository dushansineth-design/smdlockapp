// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color glowColor;

//   const CustomButton({
//     super.key,
//     required this.text,
//     required this.icon,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.glowColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 300),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: glowColor.withAlpha(230), // strong glow
//             blurRadius: 30,
//             spreadRadius: 10,
//           ),
//           BoxShadow(
//             color: Colors.black.withAlpha(50), // subtle depth
//             blurRadius: 5,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           shape: CircleBorder(),
//           padding: EdgeInsets.all(40),
//           elevation: 10,
//         ),
//         onPressed: onPressed,
//         child: Column(
//           children: [
//             Icon(icon, color: Colors.white, size: 30),
//             SizedBox(height: 10),
//             Text(text, style: TextStyle(color: Colors.white)),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:ui';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color glowColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: glowColor.withOpacity(0.7),
                blurRadius: 25,
                spreadRadius: 4,
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(80),
            onTap: onPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
