import 'package:flutter/material.dart';

class SeeMoreLessWidget extends StatelessWidget {
  final String? textData;
  final int? type; /* type 1 - See More | 2 - See Less */
  final Function? onSeeMoreLessTap;

  const SeeMoreLessWidget({
    super.key,
    required this.textData,
    required this.type,
    required this.onSeeMoreLessTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: InkWell(
          onTap: () {
            if (onSeeMoreLessTap != null) {
              onSeeMoreLessTap!();
            }
          },
          child: 
            FractionallySizedBox(
              widthFactor: 2.0,
              child: 
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 15),
                  child:  Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(230, 231, 234, 1),
                    border: Border.symmetric(horizontal: BorderSide(width: 1, color: Color.fromRGBO(180, 184, 192, 1))),
                    
                  ),
                  height: 50,
                  
                  child: Center(
                    child: Text(
                      textData!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(79, 90, 107, 1),
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.15,
                      ),
                    ),
                  ),
                ),
                ),
          ),
        ),
      ),
    );
  }
}