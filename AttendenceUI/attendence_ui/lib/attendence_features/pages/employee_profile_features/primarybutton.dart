import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double width;
  final double height;
  final Text tittleText;
  final VoidCallback onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    this.width = double.infinity,
    required this.height,
    required this.onPressed,
    required this.tittleText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : tittleText,
      ),
    );
  }
}
