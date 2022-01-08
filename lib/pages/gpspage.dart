import 'dart:async';
import 'dart:typed_data';
import 'package:batsystem/Animation/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

Set<Polyline> _polylines = {};
final dbRef = FirebaseDatabase.instance.reference();
User user = FirebaseAuth.instance.currentUser;
double latittude = 0;
double longittude = 0;
Future<void> main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

void initState() {
  read_state("enginestate");
}

String read_state(String name) {
  dbRef.child(user.uid + "/Variables/").once().then((DataSnapshot data) {
    Map list = data.value;
    print(list);
    //return list[name];

    latittude = list["latitude"];
    longittude = list["longitude"];
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GpsScreen(title: 'Flutter Map Home Page'),
    );
  }
}

class GpsScreen extends StatefulWidget {
  GpsScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GpsScreen> {
  @override
  void initState() {
    read_state("enginestate");
    getCurrentLocation();
    print(latittude);
    print(longittude);
  }

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(9.9774, 76.4116),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("images/images/logo.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: LatLng(latittude, longittude),
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.transparent,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 0,
                  target: LatLng(latittude, longittude),
                  tilt: 0,
                  zoom: 17.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    initState();
    initState();
    return Scaffold(
        // appBar: AppBar(
        //  title: Text("widget.title"),
        //),
        body: FadeAnimation(
            .7,
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialLocation,
              polylines: _polylines,
              markers: Set.of((marker != null) ? [marker] : []),
              circles: Set.of((circle != null) ? [circle] : []),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            )),
        floatingActionButton: Container(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
              backgroundColor: Colors.cyan[700],
              child: Icon(
                Icons.location_searching,
              ),
              onPressed: () {
                getCurrentLocation();
              }),
        ));
  }
}
