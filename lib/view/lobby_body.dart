import 'package:chungmugong_front_end/model/app_state.dart';
import 'package:chungmugong_front_end/model/reservation.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/view/reservation_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LobbyBody extends StatefulWidget {
  const LobbyBody({super.key});

  @override
  State<LobbyBody> createState() => _LobbyBodyState();
}

class _LobbyBodyState extends State<LobbyBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LobbyBodyInfo(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: DesignKit.getHeight(context, 80)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TableItem('가'), TableItem('나'), TableItem('다')],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TableItem('라'), TableItem('마')],
            ),
          ],
        ),
      ],
    );
  }
}

class TableItem extends StatefulWidget {
  const TableItem(this.name, {super.key});

  final String name;

  @override
  State<TableItem> createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  Color getColor(DateTime now, List<int> available, List<int> reserved) {
    List<int> checker = List.from(available);
    checker.removeWhere((e) => reserved.contains(e) || e < now.hour);

    if (checker.isEmpty) {
      return DesignKit.red;
    } else if (checker[0] != now.hour) {
      return DesignKit.blue;
    } else {
      return DesignKit.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Column(
      children: [
        BoldText16(widget.name),
        Container(
          width: DesignKit.getWidth(context, 80),
          height: DesignKit.getHeight(context, 150),
          margin: EdgeInsets.only(
            top: DesignKit.getHeight(context, 2),
            bottom: DesignKit.getHeight(context, 20),
            left: DesignKit.getWidth(context, 12),
            right: DesignKit.getWidth(context, 12),
          ),
          decoration: BoxDecoration(
            color: getColor(
              appState.appDate,
              appState.availableTime,
              appState.reservations
                  .reservations[stringToSectionName(widget.name)]!.reserved,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 4),
                blurRadius: 2,
              )
            ],
          ),
          child: OutlinedButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return ReservationModal(sectionName: widget.name);
                },
              );
            },
            child: null,
          ),
        ),
      ],
    );
  }
}

class LobbyBodyInfo extends StatelessWidget {
  const LobbyBodyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    int availableStart = appState.availableTime[0];
    int availableEnd =
        appState.availableTime[appState.availableTime.length - 1] + 1;

    return Container(
      height: DesignKit.getHeight(context, 100),
      padding: EdgeInsets.symmetric(
        horizontal: DesignKit.getWidth(context, 16),
        vertical: DesignKit.getHeight(context, 18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: DesignKit.getHeight(context, 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: DesignKit.getHeight(context, 16),
                      height: DesignKit.getHeight(context, 16),
                      margin: EdgeInsets.only(
                          right: DesignKit.getWidth(context, 8)),
                      child: const ColoredBox(color: DesignKit.green),
                    ),
                    const BoldText12('예약가능'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: DesignKit.getHeight(context, 16),
                      height: DesignKit.getHeight(context, 16),
                      margin: EdgeInsets.only(
                          right: DesignKit.getWidth(context, 8)),
                      child: const ColoredBox(color: DesignKit.blue),
                    ),
                    const BoldText12('예약가능 (사용중)'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: DesignKit.getHeight(context, 16),
                      height: DesignKit.getHeight(context, 16),
                      margin: EdgeInsets.only(
                          right: DesignKit.getWidth(context, 8)),
                      child: const ColoredBox(color: DesignKit.red),
                    ),
                    const BoldText12('예약마감'),
                  ],
                ),
              ],
            ),
          ),
          BoldText12(
            '금일 이용 가능 시각\n${availableStart.toString().padLeft(2, '0')}:00 ~ ${availableEnd.toString().padLeft(2, '0')}:00',
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
