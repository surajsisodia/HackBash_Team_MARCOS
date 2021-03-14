import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';

import 'Utils/SizeConfig.dart';
import 'Utils/constants.dart';

class TimeTable extends StatelessWidget {
  final String photoUrl;
  TimeTable({this.photoUrl});

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bc,
        leading: Builder(builder: (BuildContext context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Icon(
              MdiIcons.sortVariant,
              color: pc,
              size: b * 24,
            ),
          );
        }),
        centerTitle: true,
        title: Text(
          "Time Table",
          style: TextStyle(
            color: Colors.white,
            fontSize: b * 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Container(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: bc,
          ),
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 2,
          //timeTable Link
          imageProvider: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/deff-fe04d.appspot.com/o/1.PNG?alt=media&token=6529af9e-ca32-4f32-9a2c-4203a26dc0de'),
        ),
      ),
    );
  }
}
