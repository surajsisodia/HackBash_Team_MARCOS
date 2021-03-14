import 'package:IIIT_Surat_Connect/Utils/SizeConfig.dart';
import 'package:IIIT_Surat_Connect/Utils/constants.dart';
import 'package:IIIT_Surat_Connect/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Assignment extends StatefulWidget {
  Assignment({Key key}) : super(key: key);

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  SlidableController slidableController;
  final List<_HomeItem> items = List.generate(
    15,
    (i) => _HomeItem(i),
  );

  @protected
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return Scaffold(
      drawer: DrawerCode(),
      backgroundColor: bc,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bc,
        centerTitle: true,
        title: Text(
          "Assignments",
          style: txtS(Colors.white, 20, FontWeight.w300),
        ),
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
      ),
      body: SafeArea(
        child: Container(
          width: b * 375,
          height: h * 750,
          padding: EdgeInsets.symmetric(vertical: h * 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(b * 40),
              topRight: Radius.circular(b * 40),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xffc9c9c9).withOpacity(0.4),
                blurRadius: 20,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: _buildList(context, Axis.vertical),
        ),
      ),
    );
  }

  TextStyle txtS(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 375,
    );
  }

  SizedBox sh(double h) {
    return SizedBox(height: SizeConfig.screenHeight * h / 812);
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
            direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        var item = items[index];
        return _getSlidableWithDelegates(context, index, slidableDirection);
      },
      itemCount: items.length,
    );
  }

  Widget _getSlidableWithDelegates(
      BuildContext context, int index, Axis direction) {
    final _HomeItem item = items[index];

    return Slidable.builder(
      key: Key(item.index.toString()),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        closeOnCanceled: true,
        onWillDismiss: (false)
            ? null
            : (actionType) {
                return showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        'Completed',
                        style: TextStyle(
                          color: bc,
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenWidth * 20 / 375,
                        ),
                      ),
                      content: Text(
                        'This Assignment will be Marked Completed',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    );
                  },
                );
              },
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Completed'
                  : 'Dimiss Delete');
          setState(() {
            items.removeAt(index);
          });
        },
      ),
      actionPane: _getActionPane(item.index),
      actionExtentRatio: 0.75,
      child: VerticalListItem(items[index]),
      actionDelegate: SlideActionBuilderDelegate(
          actionCount: 1,
          builder: (context, index, animation, renderingMode) {
            return SizedBox(
              child: SizedBox(
                height: SizeConfig.screenHeight * 110 / 812,
                child: IconSlideAction(
                  caption: 'Done',
                  color: Colors.green[500],
                  icon: Icons.done,
                  onTap: () =>
                      _showSnackBar(context, 'Swipe Right to Mark Complete'),
                ),
              ),
            );
          }),
    );
  }

  static Widget _getActionPane(int index) {
    return SlidableBehindActionPane();
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);
  final _HomeItem item;
  TextStyle txtS1(Color col, double siz, FontWeight wg) {
    return TextStyle(
      color: col,
      fontWeight: wg,
      fontSize: SizeConfig.screenWidth * siz / 375,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return GestureDetector(
      onTap: () =>
          Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
              ? Slidable.of(context)?.open()
              : Slidable.of(context)?.close(),
      child: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 10),
          margin: EdgeInsets.symmetric(horizontal: b * 10, vertical: h * 0),
          height: h * 115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(b * 15),
              topRight: Radius.circular(b * 15),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(0.25),
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: pc, width: b * 1),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Image.asset('images/ass1.png', width: b * 55, height: h * 55),
              SizedBox(width: b * 10),
              Container(
                width: b * 150,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Assignment 4",
                        style: txtS1(bc, 18, FontWeight.w500),
                      ),
                      Text(
                        "Description Description Description Description Description",
                        style: txtS1(Color(0xff919191), 12, FontWeight.w300),
                      ),
                    ]),
              ),
              Spacer(),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.03125),
                    Text(
                      "23/04/2021", //date of assignment
                      style: txtS1(pc, 11, FontWeight.w500),
                    ),
                    Text(
                      "2:09 PM", // time of assignment
                      style: txtS1(pc, 11, FontWeight.w500),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0109375),
                    Container(
                      height: h * 20,
                      width: b * 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(b * 6),
                        color: false
                            ? Color(0xfff615151)
                            : Color(0xff44d141), //status
                      ),
                      child: Center(
                        child: Text(
                          "Done", //status
                          style: txtS1(Colors.white, 10, FontWeight.w500),
                        ),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 5),
          margin: EdgeInsets.only(bottom: h * 20, left: b * 10, right: b * 10),
          height: h * 35,
          width: b * 375,
          decoration: BoxDecoration(
            color: bc,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(b * 15),
              bottomRight: Radius.circular(b * 15),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(0.25),
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: pc, width: b * 1),
          ),
          child: Text(
            "Subject Name",
            style: txtS1(Colors.white, 14, FontWeight.w300),
          ),
        ),
      ]),
    );
  }
}

class _HomeItem {
  const _HomeItem(
    this.index,
  );

  final int index;
}
