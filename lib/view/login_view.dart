import 'package:chungmugong_front_end/intent/auth.dart';
import 'package:chungmugong_front_end/intent/fetch_data.dart';
import 'package:chungmugong_front_end/util/styled_component.dart';
import 'package:chungmugong_front_end/view/wifi_in.dart';
import 'package:chungmugong_front_end/util/design_kit.dart';
import 'package:chungmugong_front_end/view/lobby_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String id = '', pw = '';

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<AppState>();

    // Future.delayed(Duration(seconds: 3), () {
    //   appState.reservations.reservations
    //       .forEach((key, value) => print(value.reserved.toString()));
    // });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width),
          const Image(image: AssetImage('assets/images/login_logo.png')),
          SizedBox(
            width: 180,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() => id = value);
                  },
                  decoration: InputDecoration(hintText: '학번'),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() => pw = value);
                  },
                  obscureText: true,
                  decoration: InputDecoration(hintText: '비밀번호'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fixedSize: Size(130, 40),
              backgroundColor: DesignKit.mainBlue,
            ),
            onPressed: () {
              Auth.auth(id, pw).then((result) {
                if (result) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WifiIn(
                      child: LobbyView(),
                    ),
                  ));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const PlainText14('학번과 비밀번호를 확인하세요'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
            child: const Text(
              '로그인',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 111),
          const Image(image: AssetImage('assets/images/cnu_watermark.png')),
          const Text(
            '34134 대전광역시 유성구 대학로 99\n충남대학교 공과대학 5호관 406호(W2)\n컴퓨터융합학부: TEL: 042-821-6651,7456\n\nCopyright (C) 2023 CNU All Rights Reserved.',
            style: TextStyle(
              color: Color.fromARGB(255, 17, 22, 160),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
