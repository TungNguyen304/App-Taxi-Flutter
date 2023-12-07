import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/location-bloc.dart';
import 'package:flutter_application_1/src/resources/ride-picker-page.dart';
import 'package:flutter_application_1/src/resources/widgets/place-item.dart';

class RidePicker extends StatefulWidget {
  const RidePicker({Key? key}) : super(key: key);

  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  LocationBloc locationBloc = LocationBloc();

  @override
  void initState() {
    // TODO: implement initState
    // locationBloc.setListLocation("type", {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // locationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  color: Color.fromARGB(255, 230, 228, 228))
            ]),
        // padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: StreamBuilder<List<dynamic>>(
            stream: locationBloc.listLocationStream,
            builder: (context, snapshot) {
              print('list location ${snapshot.data?.length}');
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          redirectRidePickerPage('from');
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: PlaceItem(
                            name: snapshot.data?[0]?["formatted_address"] ??
                                "From",
                            isClose: true,
                            isFrom: true,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          redirectRidePickerPage('to');
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: PlaceItem(
                              name: snapshot.data?[1]?["formatted_address"] ??
                                  "To",
                              isClose: true,
                              isFrom: false),
                        )),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void redirectRidePickerPage(type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RidePickerPage(
                  type: type,
                )));
  }
}
