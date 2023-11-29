import 'dart:async';

import 'package:almeerah/Components/customTextstyle.dart';
import 'package:flutter/material.dart';

import 'customcontainer.dart';

class tipsContainer extends StatefulWidget {
  const tipsContainer({Key? key}) : super(key: key);

  @override
  State<tipsContainer> createState() => _tipsContainerState();
}

class _tipsContainerState extends State<tipsContainer> {
  StreamController<DateTime> _timeController = StreamController.broadcast();
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    // Set up a periodic timer to update the time variable at midnight (00:00:00)
    _timer = Timer.periodic(Duration(days: 1), (Timer timer) {
      final now = DateTime.now();
      if (now.hour == 0 && now.minute == 0 && now.second == 0) {
        _timeController.add(now);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timeController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    final List<Color> colors = [
      Color(0xffffffff),
      Color(0xffFFC0CB),
      Color(0xff33FF57),
      Color(0xffFFFF33),
      Color(0xffADD8E6),
      Color(0xff090909),
      Color(0xffFF5733),
    ];
    final List<String> colornames = [
      'White',
      'Pink',
      'Green',
      'Yellow',
      'Light Blue',
      'black',
      'Red'
    ];
    // final List<String> reason = [
    //   'Monday is dedicated to the Moon (Chandra) and signifies purity, calmness, and peace. White represents serenity and simplicity.',
    //   'Tuesday, ruled by Mars (Mangal), is linked to strength, determination, and courage. Red or pink signifies love and auspiciousness.',
    //   'Wednesday is associated with Mercury (Budh) and symbolizes growth, harmony, and balance. Green represents freshness and renewal.',
    //   'Thursday is governed by Jupiter (Brihaspati) and signifies knowledge, wisdom, and expansion. Yellow represents prosperity and positivity.',
    //   'Friday is dedicated to Venus (Shukra) and represents love, beauty, and creativity. White or light blue symbolizes purity and harmony.',
    //   'Saturday is ruled by Saturn (Shani) and signifies discipline, patience, and responsibility. Black represents protection and strength.',
    //   'Sunday is associated with the Sun (Surya) and represents energy, vitality, and power. Red symbolizes courage and passion.',
    //
    // ];
   final List<String> reason = [
     'Purity, calmness, and peace.',
     'Love and auspiciousness.',
     'Freshness and renewal.',
     'Prosperity and positivity.',
     'Purity and harmony.',
     'Protection and strength.',
     'Courage and passion.',

   ];
    var time = DateTime.now();
    int colorIndex = time.weekday-1;
    return CustomContainer(child: Row(
      children: [
        Container(
          width: 64,height: 64,
        decoration: BoxDecoration(
          color: colors[colorIndex],
            borderRadius: BorderRadius.circular(8)),),
        SizedBox(width: 32,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("Today's Color: ",style: CustomTextStyles.paragraphTextStyle(context),),
              Text(colornames[colorIndex], style: CustomTextStyles.paragraphTextStyle(context),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Significance: ', style: CustomTextStyles.paragraphTextStyle(context),),
                Container(
                  width: 100,
                    child: Text(reason[colorIndex],maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.paragraphTextStyle(context),))
              ],),

          ],
        ),
      ],
    ),
        width: pageWidth-32,
         vpad: 16, hpad: 16);
  }
}
