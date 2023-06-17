import 'package:chungmugong_front_end/intent/reservation_intent.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ReservationModal extends StatefulWidget {
  final String sectionName;

  const ReservationModal({super.key, required this.sectionName});

  @override
  State<ReservationModal> createState() => _ReservationModalState();
}

class _ReservationModalState extends State<ReservationModal> {
  List<int> clicked = [];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    // print(appState.reservations.reservations[SectionName.na]!.reserved);

    return Center(
      child: Container(
        width: DesignKit.getWidth(context, 300),
        height: DesignKit.getHeight(context, 423),
        padding: EdgeInsets.all(DesignKit.getHeight(context, 30)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(DesignKit.getWidth(context, 20))),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: DesignKit.getWidth(context, 20),
                  height: DesignKit.getWidth(context, 20),
                ),
                const BoldText16('예약하기'),
                SizedBox(
                  width: DesignKit.getWidth(context, 20),
                  height: DesignKit.getWidth(context, 20),
                  child: MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    child: SvgPicture.asset(
                      'assets/icons/cross.svg',
                    ),
                  ),
                ),
              ],
            ),
            PeriodGrid(
              avaliable: appState.availableTime,
              reserved: appState
                  .reservations
                  .reservations[stringToSectionName(widget.sectionName)]!
                  .reserved,
              clicked: clicked,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: DesignKit.getHeight(context, 10),
              ),
              child: FilledButton(
                onPressed: () {
                  clicked.sort();
                  makeReservation(
                      stringToSectionName(widget.sectionName)!, clicked);
                  // print(clicked);
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: DesignKit.mainBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(DesignKit.getWidth(context, 10)))),
                  fixedSize: Size(
                    DesignKit.getWidth(context, 130),
                    DesignKit.getWidth(context, 40),
                  ),
                ),
                child: const BoldText20(
                  '예약하기',
                  textColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PeriodGrid extends StatefulWidget {
  final List<int> avaliable;
  final List<int> reserved;
  final List<int> clicked;

  const PeriodGrid(
      {super.key,
      required this.avaliable,
      required this.reserved,
      required this.clicked});

  @override
  State<PeriodGrid> createState() => _PeriodGridState();
}

class _PeriodGridState extends State<PeriodGrid> {
  DateTime time = DateTime.now();

  bool getClickable(period) {
    if (period < time.hour) {
      return false;
    }

    if (widget.reserved.contains(period)) {
      return false;
    } else {
      return true;
    }
  }

  Color getColor(period) {
    if (period < time.hour) {
      return DesignKit.gray;
    }

    if (widget.reserved.contains(period)) {
      return DesignKit.red;
    } else {
      return DesignKit.green;
    }
  }

  BoxShadow getShadow(period) {
    if (widget.clicked.contains(period)) {
      return const BoxShadow(
        color: Colors.black38,
        spreadRadius: 0,
        blurRadius: 0,
      );
    } else {
      return const BoxShadow(
        color: Colors.black38,
        spreadRadius: 2,
        blurRadius: 3,
        offset: Offset(0, 4), // 그림자의 위치 조정 (가로, 세로)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DesignKit.getWidth(context, 240),
      height: DesignKit.getWidth(context, 160),
      child: GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing: DesignKit.getWidth(context, 10),
        crossAxisSpacing: DesignKit.getWidth(context, 10),
        children: widget.avaliable
            .map(
              (period) => Container(
                width: DesignKit.getWidth(context, 40),
                height: DesignKit.getWidth(context, 40),
                decoration: BoxDecoration(color: getColor(period), boxShadow: [
                  getShadow(period),
                ]),
                child: MaterialButton(
                  onPressed: () {
                    if (getClickable(period)) {
                      if (widget.clicked.contains(period)) {
                        setState(() {
                          widget.clicked.remove(period);
                        });
                      } else {
                        setState(() {
                          widget.clicked.add(period);
                        });
                      }
                    }
                  },
                  padding: EdgeInsets.zero,
                  child: BoldText16(period < 10
                      ? '0${period.toString()}'
                      : period.toString()),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
