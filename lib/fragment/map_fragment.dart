import 'dart:async';

import 'package:egattracking/dao/TowerDao.dart';
import 'package:egattracking/service/TowerService.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapFragment extends StatefulWidget {
  @override
  State<MapFragment> createState() => MapSampleState();
}

class MapSampleState extends State<MapFragment> {
  // Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  late BitmapDescriptor myIcon;
  late Position userLocation;
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(300, 300)), 'assets/pole.png')
        .then((onValue) {
      myIcon = onValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เลือกเสา")),
      body: FutureBuilder(
        future: _getLocation(),
          // future: Geolocator.getCurrentPosition(
          //     desiredAccuracy: LocationAccuracy.high),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              LatLng latlang;
              Position position = snapshot.data as Position;
              latlang = LatLng(position.latitude, position.longitude);
              CameraPosition kGooglePlex = CameraPosition(
                  target: latlang, zoom: 15);
              // CameraPosition(
              //   target: latlang,
              //   zoom: 14.4746,
              // );

              return FutureBuilder(
                future: TowerService.getTowerInRang(
                    latlang.latitude, latlang.longitude),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    TowerDao mData = snapshot.data as TowerDao;
                    if (mData.data != null) {
                      markers.addAll(mData.data!.map((it) => Marker(
                          markerId: MarkerId(it.id),
                          position: LatLng(it.latitude, it.longitude),
                          icon: myIcon,
                          infoWindow: InfoWindow(
                              title:
                                  it.name.replaceAll("_", "-") + " " + it.type,
                              onTap: () {
                                Navigator.pop(context, it);
                              }))));
                    }

                    return GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: kGooglePlex,
                      onMapCreated: _onMapCreated,
                      // (GoogleMapController controller) {
                      //   _controller.complete(controller);
                      // },
                      markers: markers,
                      myLocationEnabled: true,
                    );
                  } else
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Colors.blueGrey,
                            valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
                            strokeWidth: 8.0,
                          ),
                        ],
                      ),
                    );
                },
              );
            } else
              return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Colors.blueGrey,
                            valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
                            strokeWidth: 8.0,
                          ),
                        ],
                      ),
                    );
          }),
          floatingActionButton:FloatingActionButton.extended(
            onPressed: () {
              mapController.animateCamera(CameraUpdate.newLatLngZoom(
                LatLng(userLocation.latitude, userLocation.longitude),18));
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      'Your location has been send !\nlat: ${userLocation.latitude} long: ${userLocation.longitude}'
                    ),
                  );
                }
              );
            }, 
            label: Text("Send Location"),
            icon: Icon(Icons.near_me),
          ),
    );
  }

   Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location permissions are denied');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanetly denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }
}
