import 'package:flutter/material.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/constants.dart';

class Option {
  int index;
  String option;
  Option(this.index, this.option);
  static List<Option> getOption() {
    return <Option>[
      Option(0, 'Calculators'),
      Option(1, 'Cycles'),
      Option(2, 'Books'),
      Option(3, 'Hardware'),
      Option(4, 'Others')
    ];
  }
}

class DropDownMenuBar extends StatefulWidget {
  @override
  _DropDownMenuBarState createState() => _DropDownMenuBarState();
}

class _DropDownMenuBarState extends State<DropDownMenuBar> {
  List<Option> _option = Option.getOption();
  List<DropdownMenuItem<Option>> _dropdownMenuItemsTime;
  Option _selectedTime;
  @override
  void initState() {
    _dropdownMenuItemsTime = buildDropdownMenuItemsTime(_option);
    _selectedTime = _dropdownMenuItemsTime[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Option>> buildDropdownMenuItemsTime(List options) {
    List<DropdownMenuItem<Option>> items = List();

    for (Option options in options) {
      items.add(
        DropdownMenuItem(
          value: options,
          child: Container(
            child: Text(
              options.option,
              style: TextStyle(
                color: bc,
                fontSize: SizeConfig.screenWidth * 14 / 375,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  onchangeDropdownItemOption(Option selectedOption) {
    setState(() {
      _selectedTime = selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      alignment: Alignment.centerRight,
      width: SizeConfig.screenWidth * 280 / 375,
      height: SizeConfig.screenHeight * 35 / 812,
      decoration: BoxDecoration(
        color: Color(0xffd8d1ea),
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth / 375 * 10),
      ),
      child: Row(children: [
        SizedBox(width: SizeConfig.screenWidth * 15 / 375),
        Text(
          _selectedTime.option,
          style: TextStyle(
            color: brc,
            fontSize: SizeConfig.screenWidth * 14 / 375,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              padding: EdgeInsets.zero,
              child: DropdownButton(
                itemHeight: kMinInteractiveDimension,
                iconEnabledColor: bc,
                style: TextStyle(
                  color: bc,
                  fontSize: SizeConfig.screenWidth * 14 / 375,
                ),
                value: null,
                items: _dropdownMenuItemsTime,
                onChanged: onchangeDropdownItemOption,
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.screenWidth * 10 / 375),
      ]),
    );
  }
}
