import 'package:flutter/material.dart';

class PlaceItem extends StatefulWidget {
  String name;
  bool isClose;
  bool isFrom;
  PlaceItem({ this.name = "", this.isClose = false, this.isFrom = true });

  @override
  _PlaceItemState createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Positioned(
                  left: 0,
                  child: Center(
                    child: Icon(
                      widget.isFrom ? Icons.location_on_outlined : Icons.anchor_rounded,
                      size: 16,
                      color: widget.isFrom ? Colors.blue : Colors.orangeAccent,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: SizedBox(
                  width: 220,
                  child: Text(
                    widget.name,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          if (widget.isClose) ... [
            const Positioned(
              right: 0,
              child: Icon(
                Icons.close,
                size: 16,
                color: Colors.blueGrey,
              ),
              
            )
          ]
          
        ],
      ),
    );
  }
}