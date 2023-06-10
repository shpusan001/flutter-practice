import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? googleMapController;
  // 37.4073695	127.1162181
  static final LatLng companyLatLng = LatLng(37.4073695, 127.1162181);
  static final CameraPosition initialPosition =
      CameraPosition(target: companyLatLng, zoom: 15);
  static final double okDistance = 100;
  static final Circle withinDistanceCircle = Circle(
      circleId: CircleId("circle"),
      center: companyLatLng,
      fillColor: Colors.blue.withOpacity(0.5),
      radius: okDistance,
      strokeColor: Colors.blue,
      strokeWidth: 1);

  static final Circle notWithinDistanceCircle = Circle(
      circleId: CircleId("circle"),
      center: companyLatLng,
      fillColor: Colors.red.withOpacity(0.5),
      radius: okDistance,
      strokeColor: Colors.red,
      strokeWidth: 1);

  static final Circle checkDoneCircle = Circle(
      circleId: CircleId("circle"),
      center: companyLatLng,
      fillColor: Colors.green.withOpacity(0.5),
      radius: okDistance,
      strokeColor: Colors.green,
      strokeWidth: 1);

  static final Marker marker =
      Marker(markerId: MarkerId("marker"), position: companyLatLng);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar(),
        body: FutureBuilder(
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == "waiting") {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == "위치 권한이 허가되었습니다.") {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    bool isWithinRange = false;

                    if (snapshot.hasData) {
                      final start = snapshot.data!;
                      final end = companyLatLng;

                      final distance = Geolocator.distanceBetween(
                          start.latitude,
                          start.longitude,
                          end.latitude,
                          end.longitude);

                      if (distance < okDistance) {
                        isWithinRange = true;
                      }
                    }

                    return Column(
                      children: [
                        _CustomGoogleMap(
                          initialPosition: initialPosition,
                          circle: choolCheckDone
                              ? checkDoneCircle
                              : isWithinRange
                                  ? withinDistanceCircle
                                  : notWithinDistanceCircle,
                          marker: marker,
                          onMapCreated: onMapCreated,
                        ),
                        _ChoolCheckButton(
                          isWithinRange: isWithinRange,
                          choolCheckDone: choolCheckDone,
                          onPressed: onChoolCheckPressed,
                        ),
                      ],
                    );
                  });
            }

            return Center(
              child: Text(snapshot.data),
            );
          },
        ));
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  void onChoolCheckPressed() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("출근하기"),
            content: Text("출근을 하시겠습니까?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("취소")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("출근 하기"))
            ],
          );
        });

    if (result == true) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return "위치 서비스를 활성화해주세요.";
    }

    LocationPermission checkPermission = await Geolocator.checkPermission();

    if (checkPermission == LocationPermission.denied) {
      checkPermission = await Geolocator.requestPermission();

      if (checkPermission == LocationPermission.denied) {
        return "위치 권한을 허락해주세요.";
      }
    }

    if (checkPermission == LocationPermission.deniedForever) {
      return "앱의 위치권한을 설정해서 허락해주세요.";
    }

    return "위치 권한이 허가되었습니다.";
  }

  AppBar renderAppBar() {
    return AppBar(
      title: Text(
        "오늘도 출근",
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            if (googleMapController == null) {
              return;
            }

            final location = await Geolocator.getCurrentPosition();

            googleMapController!.animateCamera(CameraUpdate.newLatLng(
                LatLng(location.latitude, location.longitude)));
          },
          icon: Icon(Icons.my_location),
          color: Colors.blue,
        )
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _CustomGoogleMap(
      {required this.marker,
      required this.circle,
      required this.initialPosition,
      required this.onMapCreated,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        circles: Set.from([circle]),
        markers: Set.from([marker]),
        onMapCreated: onMapCreated,
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  const _ChoolCheckButton(
      {required this.choolCheckDone,
      required this.onPressed,
      required this.isWithinRange,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.timelapse_outlined,
          size: 50,
          color: choolCheckDone
              ? Colors.green
              : isWithinRange
                  ? Colors.blue
                  : Colors.red,
        ),
        SizedBox(
          height: 20,
        ),
        if (!choolCheckDone && isWithinRange)
          ElevatedButton(onPressed: onPressed, child: Text("출근 하기"))
      ],
    ));
  }
}
