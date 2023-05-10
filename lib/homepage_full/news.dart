import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserNews extends StatefulWidget {
  const UserNews({Key? key}) : super(key: key);

  @override
  State<UserNews> createState() => _UserNewsState();
}

class _UserNewsState extends State<UserNews> {
  String _department = "";

  Future<void> _getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('/users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final DocumentSnapshot userSnapshot = querySnapshot.docs[0];
          final department = userSnapshot.get('Department') ?? '';
          setState(() {
            _department = department;
          });
          print('User details: $_department');
        } else {
          setState(() {
            _department = '';
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (_department.isEmpty) {
      return const Center(
        child: Text('Department is empty'),
      );
    }
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(_department)
            .collection('news')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching news'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> newsData =
                  documents[index].data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 187, 202, 223),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 46, 45, 45).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(newsData['imageUrl'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsData['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            newsData['description'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
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
