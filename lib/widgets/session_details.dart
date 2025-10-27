import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olinom/Models/session_model.dart';
import 'package:olinom/screens/detail_session_screen.dart';
import 'package:olinom/screens/session_details_screen.dart';
import 'package:olinom/screens/session_with_detail_screen.dart';
import 'package:olinom/screens/sessionabsent_screen.dart';
import 'package:olinom/services/time_converter.dart';

class SessionDetails extends StatelessWidget {
  SessionModel model;

  SessionDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    TimeConverter converter = TimeConverter();
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(242, 243, 244, 1),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: Colors.blue, width: 4),
        ),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 91, 254, 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${model.establishmentName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/sessions.svg',
                      height: 14,
                      width: 14,
                      
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${model.sessionnumber}/${model.totalsession}',
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 91, 254, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${model.ref}',
            style: const TextStyle(
              color: Color.fromRGBO(4, 19, 44, 1),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.44,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${model.title}',
            style: const TextStyle(
              color: Color.fromRGBO(4, 19, 44, 1),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.44,
            ),
          ),
          Text(
            '${model.subject}',
            style: const TextStyle(
              color: Color.fromRGBO(4, 19, 44, 1),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.44,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/icon1.svg',
                height: 10,
                width: 10,
                
              ),
              const SizedBox(width: 4),
              Text(
                '${model.levelname}',
                style: const TextStyle(
                  color: Color.fromRGBO(129, 137, 149, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4
                ),
              ),
              
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/icon3.svg',
                height: 10,
                width: 10,
                
              ),
              const SizedBox(width: 4),
              Text(
                '${model.student} élèves',
                style: const TextStyle(
                  color: Color.fromRGBO(129, 137, 149, 1),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4
                ),
              ),
              
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/icon10.svg',
                height: 14,
                width: 14,
                
              ),
              const SizedBox(width: 8),
              Container(
                width: 250,
                child: Text(
                  '${model.startDate} - ${model.endDate}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(
                    color: Color.fromRGBO(4, 19, 44, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              (model.current == false)
              ?
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SessionabsentScreen(model: model,)
                                  
                            ),
                          );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 90, 46, 1),
                    surfaceTintColor: Color.fromRGBO(255, 90, 46, 0.35),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size(160, 46),
                  ),
                  child: const Text(
                    'Se déclarer absent',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: -0.44
                    ),
                  ),
                ),
              ) : Container(),
              (model.current == false)
              ? const SizedBox(width: 12) : Container(),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailSessionScreen(appbartext: "Détails de la session", currentindex: 2, replacementid: model.id!, sessionid: model.sessionid!,)
                                  
                            ),
                          );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Color.fromRGBO(4, 19, 44, 1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size(160, 46),
                  ),
                  child: const Text(
                    'Plus de détails',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(4, 19, 44, 1),
                      fontSize: 12,
                      letterSpacing: -0.44
                    ),
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
