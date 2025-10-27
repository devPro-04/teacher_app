import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/session_model.dart';

class WelcomeSession extends StatelessWidget {
  SessionModel wsession;

  WelcomeSession(this.wsession, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(242, 243, 244, 1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
              border: const Border(
                  left: BorderSide(
                      width: 4, color: Color.fromRGBO(0, 91, 254, 1))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blue accent bar at top
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 91, 254, 1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          '${wsession.establishmentName}',
                          style: const TextStyle(
                            color: Color.fromRGBO(204, 222, 255, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Course code
                      Text(
                        '${wsession.ref}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(4, 19, 44, 1),
                          letterSpacing: -0.44,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Course title
                      Text(
                        '${wsession.title}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(4, 19, 44, 1),
                          letterSpacing: -0.44,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Level with icon
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/icon1.svg',
                            height: 14,
                            width: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${wsession.levelname}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(129, 137, 149, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Student count and duration
                      Row(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/icon3.svg',
                                height: 14,
                                width: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${wsession.student} élèves',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(129, 137, 149, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          /*const SizedBox(width: 20),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/icon8.svg',
                                height: 14,
                                width: 14,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '03h15',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(129, 137, 149, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),*/
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Schedule
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/icon2.svg',
                            height: 14,
                            width: 14,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcATop),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 250,
                            child: Text(
                              '${wsession.startDate} - ${wsession.endDate}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textWidthBasis: TextWidthBasis.parent,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(129, 137, 149, 1),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
