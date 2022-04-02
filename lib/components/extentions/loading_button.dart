import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback function;
  final Widget child;

  const LoadingButton({
    Key? key,
    required this.isLoading,
    required this.function,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (isLoading)
        ? SizedBox(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.shade200,
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
            width: 30,
            height: 30,
          )
        : Container(
            width: size.width / 3,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: function,
              child: child,
            ),
          );
  }
}
