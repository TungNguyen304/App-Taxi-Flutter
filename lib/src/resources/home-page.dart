import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/location-bloc.dart';
import 'package:flutter_application_1/src/resources/widgets/home-menu.dart';
import 'package:flutter_application_1/src/resources/widgets/ride-picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  late LatLng _center = const LatLng(10.762622, 106.660172);
  late List<Marker> markers = [];
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LocationBloc locationBloc = LocationBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    locationBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    markers.add(
        Marker(
            markerId: MarkerId('1'),
            position: LatLng(10.762622, 106.660172),
            infoWindow: InfoWindow(
              title: 'My Position',
            )),
      );

      markers.add(
        Marker(
            markerId: MarkerId('2'),
            position: LatLng(16.047079, 108.206230),
            infoWindow: InfoWindow(
              title: 'Location 1',
            )),
      );
    locationBloc.getfieldlocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Stack(
          children: [
            StreamBuilder(
                stream: locationBloc.myLocationStream,
                builder: (context, snapshot) {
                  return GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 7.0,
                    ),
                    // markers: Set.from(markers),
                  );
                }),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      title: Text("Taxi App"),
                      centerTitle: true,
                      leading: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(Icons.menu),
                      ),
                      actions: [
                        IconButton(
                          onPressed: onPressed,
                          icon: Icon(Icons.settings),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                      child: RidePicker(),
                    )
                  ],
                ))
          ],
        ),
      ),
      drawer: HomeMenu(),
    );
  }

  void setMarkers(type, location) {
    // late List<Marker> markers = [];
    // int index = type == 'from' ? 0 : 1;
    // markers[index] = Marker(
    //   markerId: MarkerId(index.toString()),
    //   position: LatLng(location["geometry"]["location"]["lat"], location["geometry"]["location"]["lng"]),
    //   infoWindow: InfoWindow(
    //     title: 'My Position',
    //   )
    // );
    // setState(() {
    //   markers = 
    // });
  }

  void onPressed() {}
}
