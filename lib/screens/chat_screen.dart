import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olinom/common/custom_snackbar.dart';
import 'package:olinom/screens/home_screen.dart';
import 'package:olinom/services/api_connection.dart';
import 'package:olinom/services/local_storage.dart';

class ChatScreen extends StatefulWidget {
  final int replacementid;
  final String appbartext;
  final int currentindex;

  const ChatScreen({super.key, 
    required this.replacementid,
    required this.appbartext,
    required this.currentindex});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  ApiConnection apiConnection = ApiConnection();
  String _data = "Initial Data";
  final _localStorage = LocalStorage();

  Future<dynamic> _fetchMessages() async {
    try {
     
      final results = await Future.wait([
        apiConnection.getMessageChat(widget.replacementid)
        
      ]);
      
      return {
        'messagearr': results[0],
        
      };
      
    } catch (e, stackTrace) {

      // Re-throw to let FutureBuilder handle it
      rethrow;
    }
  }

  Future<void> _createMessage(int idConversation, int sessionid, int idAccountEstab, String pathEstablishment, int replacementid) async {
    
    ApiConnection apiConnection = ApiConnection();
    
    bool accept = await apiConnection.createMessage(idConversation, sessionid, idAccountEstab, pathEstablishment, widget.replacementid, _messageController.text);
    

    if (accept) {
      setState(() {
        // Update your data here, e.g., fetch new data from an API
        _data = "New Data: ${DateTime.now().second}";
      });
    } else {
      showMySnackBar(
          message: "Unable to apply at the moment!",
          context: context,
          success: false);
      Navigator.pop(context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _fetchMessages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading...'),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 64),
                SizedBox(height: 16),
                Text('Error1: ${snapshot.error}'),
                ElevatedButton(
                  onPressed: () => setState(() {}), // Rebuild to retry
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        }

        final data = snapshot.data!;
        final messages = data['messagearr']['messages'];
        final sessionid = data['messagearr']['sessionid'];
        final idConversation = data['messagearr']['idConversation'];
        final replacement = data['messagearr']['replacement'];
        final replacementReq = data['messagearr']['replacementReq'];
        final idAccountEstab = data['messagearr']['idAccountEstab'];
        final pathEstablishment = data['messagearr']['pathEstablishment'];
        final participants = data['messagearr']['participants'];
        final cdnprofile = data['messagearr']['cdnprofile'];
        
        var index = 0;
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: ElevatedButton(
                        onPressed: () async {
                          print("detailbar");
                          print(await _localStorage.getBacklink());
                          if(await _localStorage.getBacklink() == "mission") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(currentindex: 1,),
                              ),
                            );
                          } else if(await _localStorage.getBacklink() == "welcome") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(currentindex: 0,),
                              ),
                            );
                          } else if(await _localStorage.getBacklink() == "session") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(currentindex: 2,),
                              ),
                            );
                          } else if(await _localStorage.getBacklink() == "messagerie") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(currentindex: 3,),
                              ),
                            );
                          } else if(await _localStorage.getBacklink() == "sessiondetail") {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(currentindex: 0,),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0, // Removes the shadow/elevation
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Removes rounded corners
                          ),
                          side: const BorderSide(
                            width: 0, // Removes the border
                            color: Colors.transparent, // Makes the border transparent
                          ),
                          // You can also set other properties like backgroundColor, foregroundColor, padding, etc.
                          backgroundColor: Colors.white, // Example background color
                          foregroundColor: Colors.blue, // Example text color
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min, // To keep the row size minimal
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_back_ios, size: 20,),
                            SizedBox(width: 1.0), // Adjust spacing as needed
                            Text('Back'),
                            
                            
                          ],
                        ),
                      ),
              title: Text(
                replacement['title'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 16, bottom: 12),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      ...participants.map((participant) {
                        return Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                              radius: 60.0, // Adjust the radius to control the size of the circle
                              backgroundImage: NetworkImage(
                                participant['photo'], // Replace with your network image URL
                              ),
                            ),
                        );
                      }),
                      const Text(
                        '3 personnes',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: 
            SingleChildScrollView(
              child: 
            Column(
              children: [
                
                    
                    ...messages.map((message) {
                    return 
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 16),
                      child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          message['isMe'] ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!message['isMe']) ...[
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 60.0, // Adjust the radius to control the size of the circle
                              backgroundImage: NetworkImage(
                                cdnprofile+message['photo'], // Replace with your network image URL
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Column(
                            crossAxisAlignment: message['isMe']
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: message['isMe'] ? Colors.blue : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message['content'],
                                  style: TextStyle(
                                    color: message['isMe'] ? Colors.white : Colors.black87,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message['createdAt'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (message['isMe'] == true) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 60.0, // Adjust the radius to control the size of the circle
                              backgroundImage: NetworkImage(
                                cdnprofile+message['photo'], // Replace with your network image URL
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    );
                    }).toList(),
                  
                _buildMessageInput(idConversation,sessionid,idAccountEstab,pathEstablishment,replacementReq['id']),
              ],
            ),
            ),
          );
      },
    );
  }

  Widget _buildAvatar(Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: CircleAvatar(
          radius: 60.0, // Adjust the radius to control the size of the circle
          backgroundImage: NetworkImage(
            'https://via.placeholder.com/150', // Replace with your network image URL
          ),
        ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isMe ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isMe ? Colors.white : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(idConversation,sessionid,idAccountEstab,pathEstablishment,replacementid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _messageController,
                validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Déclarer une raison";
                      }
                      return null;
                    },
                decoration: InputDecoration(
                  hintText: 'Votre message ici',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.image, color: Colors.grey[400]),
              onPressed: () {
                _createMessage(idConversation,sessionid,idAccountEstab,pathEstablishment,replacementid);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}
