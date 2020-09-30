import 'package:flutter/material.dart';

class RequestBox extends StatelessWidget {
  final _requestController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.indigo,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black87,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 10,
      child: Container(
        height: 235,
        padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: null,

                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '--> Your Request...',
                ),
                controller: _requestController,
                //onSubmitted: (_) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
