import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/location-bloc.dart';
import 'package:flutter_application_1/src/blocs/place-bloc.dart';
import 'package:flutter_application_1/src/resources/home-page.dart';
import 'package:flutter_application_1/src/resources/widgets/place-item.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RidePickerPage extends StatefulWidget {
  String type;
  RidePickerPage({Key? key, this.type = 'from'}) : super(key: key);

  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  LocationBloc locationBloc = LocationBloc();
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();
  PlaceBloc placeBloc = PlaceBloc();
  bool isSearch = false;

  var listPosition = [];

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    locationBloc.dispose();
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Text("Taxi App"),
                  centerTitle: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextField(
                    autofocus: true,
                    controller: searchController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      isDense: true,                      // Added this
                      contentPadding: EdgeInsets.all(8),
                      focusColor: Colors.orangeAccent,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.orangeAccent)),
                      prefixIcon: InkWell(
                        onTap: searchPlace,
                        borderRadius: BorderRadius.circular(50),
                        child: Icon(Icons.search),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(50),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
                if (isSearch) ... [
                  StreamBuilder(
                    stream: placeBloc.placeStream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                snapshot.data == true ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ) : Column(
                                  children: List.generate(snapshot.data?.length, (index) {
                                    return Material(
                                      color: Colors.white.withOpacity(0.0),
                                      child: InkWell(
                                        // splashColor: Colors.orange,
                                        onTap: () {
                                          selectPlace(widget.type, snapshot.data[index]);
                                        },
                                        child: PlaceItem(name: snapshot.data[index]["formatted_address"])
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  )
                ]
              ],
            )
          ],
        ),
      ),
    );
  }

  void selectPlace(type, location) {
    locationBloc.setListLocation(type, location);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void searchPlace() {
    setState(() {
      isSearch = true;
    });
    placeBloc.searchPlace(searchController.text);
  }
}
