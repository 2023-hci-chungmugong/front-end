import 'package:chungmugong_front_end/intent/entry_reservation.dart';
import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WifiModal extends StatefulWidget {
  final int idx;
  const WifiModal({super.key, required this.idx});

  @override
  State<WifiModal> createState() => _WifiModal();
}

class _WifiModal extends State<WifiModal> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Center(
      child: Container(
        width: DesignKit.getWidth(context, 300),
        height: DesignKit.getHeight(context, 330),
        padding: EdgeInsets.all(DesignKit.getHeight(context, 30)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(DesignKit.getWidth(context, 10))),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: DesignKit.getWidth(context, 20),
            //   height: DesignKit.getHeight(context, 20),
            // ),
            const BoldText16('지란지교 입장알림'),
            SizedBox(height: DesignKit.getHeight(context, 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText14(dateTimeToString(
                        appState.myReservations[widget.idx].date)),
                    SizedBox(
                      height: DesignKit.getHeight(context, 20),
                    ),
                    BoldText14(
                        "<${sectionNameToString(appState.myReservations[widget.idx].section)}>"),
                    BoldText14(
                        "${appState.myReservations[widget.idx].start}:00 ~ ${appState.myReservations[widget.idx].end + 1}:00")
                  ],
                ),
                // SizedBox(height: DesignKit.getHeight(context, 30)),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EntrySection('가'),
                        EntrySection('나'),
                        EntrySection('다')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [EntrySection('라'), EntrySection('마')],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: DesignKit.getHeight(context, 30)),
            Container(
              padding: EdgeInsets.only(
                bottom: DesignKit.getHeight(context, 10),
              ),
              child: FilledButton(
                onPressed: () {
                  // appState 예약상태 변경 => inherited ㅠㅠ
                  entryReservation();
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: DesignKit.mainBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(DesignKit.getWidth(context, 10)))),
                  fixedSize: Size(
                    DesignKit.getWidth(context, 220),
                    DesignKit.getWidth(context, 50),
                  ),
                ),
                child: const BoldText20(
                  '입장하기',
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

class EntrySection extends StatelessWidget {
  const EntrySection(this.section, {super.key});
  final String section;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return Column(
      children: [
        Container(
          width: DesignKit.getWidth(context, 20),
          height: DesignKit.getHeight(context, 30),
          margin: EdgeInsets.only(
            top: DesignKit.getHeight(context, 10),
            bottom: DesignKit.getHeight(context, 7),
            left: DesignKit.getWidth(context, 5),
            right: DesignKit.getWidth(context, 5),
          ),
          decoration: BoxDecoration(
            color: (sectionNameToString(appState.myReservations[0].section) ==
                    section
                ? DesignKit.green
                : DesignKit.gray),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        )
      ],
    );
  }
}
