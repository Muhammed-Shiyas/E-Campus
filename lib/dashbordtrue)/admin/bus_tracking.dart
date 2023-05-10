import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import 'order_tracking_page.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('live location tracker'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextButton(
              onPressed: () {
                _getLocation(_nameController.text);
              },
              child: Text('add bus GPS')),
          TextButton(
              onPressed: () {
                _listenLocation(_nameController.text);
              },
              child: Text('enable live location')),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: Text('stop live location')),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('location')
                .where('name', isEqualTo: _nameController.text)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MyMap(snapshot.data!.docs[index].id)));
                        },
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }

  _getLocation(String name) async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc(name).set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': name
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation(String name) async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc(name).set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': name
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
