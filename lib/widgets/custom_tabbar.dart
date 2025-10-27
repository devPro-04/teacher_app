import 'package:flutter/material.dart';

class CustomTabbar extends StatelessWidget {
  final Color firstButtonColor;
  final Color secondButtonColor;
  final VoidCallback firstButtonOnPressed;
  final VoidCallback secondButtonOnPressed;

  const CustomTabbar({
    super.key, // Changed super.key to Key? key
    this.firstButtonColor = const Color(0xFF005BFE),
    this.secondButtonColor = const Color(0xFFB0BCD1),
    required this.firstButtonOnPressed,
    required this.secondButtonOnPressed,
  }); // Added super(key: key)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE6E9F0), // Example color
          borderRadius: BorderRadius.circular(
              25.0), // Adjust the value to change the roundness
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(firstButtonColor),
                    elevation: WidgetStateProperty.all<double>(0),
                  ),
                  onPressed: firstButtonOnPressed,
                  child: const Text(
                    'Nouvelles missions',
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(secondButtonColor),
                    elevation: WidgetStateProperty.all<double>(0),
                  ),
                  onPressed: secondButtonOnPressed,
                  child: const Text(
                    'Sessions en cours',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
