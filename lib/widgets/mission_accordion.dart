import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olinom/Models/mission_model.dart';
import 'package:olinom/widgets/expandable.dart';
import 'session_list.dart';

class MissionAccordion extends StatefulWidget {
  MissionModel mission;

  MissionAccordion({super.key, required this.mission});

  @override
  State<MissionAccordion> createState() => _MissionAccordionState();
}

class _MissionAccordionState extends State<MissionAccordion> {
  int? expandedIndex;

  

  @override
  Widget build(BuildContext context) {
    

        return 
          Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.mission.description != "")
          ?
          FractionallySizedBox(
            widthFactor: 2.0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(242, 247, 255, 1),
                border: Border.symmetric(horizontal: BorderSide(width: 1, color: Color.fromRGBO(205, 208, 213, 1))),
                
              ),
              height: 50,
              child: 
              Padding(
                padding: const EdgeInsetsGeometry.directional(start: 139),
                child:  Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon12.svg',
                        height: 16,
                        width: 16,
                      
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Objectifs de la mission',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 19, 44, 1),
                        letterSpacing: -0.44
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          : Container(),
          (widget.mission.description != "")
          ?
          const SizedBox(height: 12)
          : Container(),
          (widget.mission.description != "")
          ?
          Column(
            children: [
              ExpandableWidget(
                content: widget.mission.description,
              )
            ]
          )
          : Container(),
          (widget.mission.description2 != "")
          ?
          FractionallySizedBox(
            widthFactor: 2.0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(242, 247, 255, 1),
                border: Border.symmetric(horizontal: BorderSide(width: 1, color: Color.fromRGBO(205, 208, 213, 1))),
                
              ),
              height: 50,
              child: 
              Padding(
                padding: const EdgeInsetsGeometry.directional(start: 139),
                child:  Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon13.svg',
                        height: 16,
                        width: 16,
                      
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Avancement',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 19, 44, 1),
                        letterSpacing: -0.44
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          : Container(),
          (widget.mission.description2 != "")
          ?
          const SizedBox(height: 12)
          : Container(),
          (widget.mission.description2 != "")
          ?
          Column(
            children: [
              ExpandableWidget(
                content: widget.mission.description2,
              )
            ]
          )
          : Container(),
          
        ],
      ),
    );
          
                
          
      
    
  }
}