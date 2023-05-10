import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

          if (messages.isEmpty) {
            return Center(child: Text('No messages found'));
          }

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              Map<String, dynamic>? message =
                  messages[index].data() as Map<String, dynamic>?;
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message!['title'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      message['description'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
