import 'package:flutter/material.dart';
import 'package:olinom/Models/mission_model.dart';
import 'package:olinom/widgets/sesssion_item.dart';

typedef parentFunctionCallback = void Function(List<int> sessions, int idlevel, int idreplacement);

class SessionList extends StatefulWidget {
  SessionItem sessiondates;
  int index;
  int replacementid;
  int levelid;
  final parentFunctionCallback updateprice;
  List<int> selectedNumbers = [];

  SessionList({super.key, required this.sessiondates, required this.index, required this.replacementid, required this.updateprice, required this.levelid, required this.selectedNumbers});

@override
  State<SessionList> createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        color: widget.sessiondates.isAvailable 
            ? Colors.white
            : const Color(0xFFFF5A2E).withOpacity(0.35),
        border: const Border(
          top: BorderSide(color: Color(0xFFCDD0D5)),
          bottom: BorderSide(color: Color(0xFFCDD0D5)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            
            Expanded(
              flex: 1,
              child: Checkbox(
                key: ValueKey(widget.sessiondates.sessionId),
                value: (widget.sessiondates.isChecked == true && widget.selectedNumbers.contains(widget.sessiondates.sessionId))?? true,
                onChanged: (value) {
                  setState(() {
                    widget.sessiondates.isChecked = value ?? false; // Update the state
                    if (value == true && !widget.selectedNumbers.contains(widget.sessiondates.sessionId)) {
                      // Add number if checked
                      if (!widget.selectedNumbers.contains(widget.sessiondates.sessionId)) {
                        widget.selectedNumbers.add(widget.sessiondates.sessionId);
                      }
                    } else {
                      // Remove number if unchecked
                      widget.selectedNumbers.remove(widget.sessiondates.sessionId);
                    }
                  });
                  widget.updateprice(widget.selectedNumbers, widget.levelid, widget.replacementid);
                },
                fillColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Color.fromRGBO(0, 91, 254, 1); // Color when selected
                    }
                    return Color.fromRGBO(255, 255, 255, 1); // Color when unselected
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: const BorderSide(color: Color(0xFF9FA2A6)),
              ),
            ),
          
          Expanded(
            flex: 2,
            child: Text(
              'Session ${widget.index}',
              style: const TextStyle(
                color: Color(0xFF4F5A6B),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              widget.sessiondates.finalDate,
              style: const TextStyle(
                color: Color(0xFF4F5A6B),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}



