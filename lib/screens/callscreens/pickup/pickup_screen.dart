import 'package:flutter/material.dart';
import 'package:video_call/models/call.dart';
import 'package:video_call/resources/call_methods.dart';
import 'package:video_call/screens/chatscreens/widgets/cached_image.dart';
import 'package:video_call/utils/permissions.dart';
import '../call_screen.dart';


class PickupScreen extends StatefulWidget {
  final Call call;

  PickupScreen({
    @required this.call,
  });

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final CallMethods callMethods = CallMethods();
  // final LogRepository logRepository = LogRepository(isHive: true);
  // final LogRepository logRepository = LogRepository(isHive: false);

  bool isCallMissed = true;


  @override
  void dispose() {
    if (isCallMissed) {
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Incoming...",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 36),
                CachedImage(
                  widget.call.callerPic,
                  isRound: true,
                  radius: 180,
                ),
                SizedBox(height: 12),
                Text(
                  widget.call.callerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 72),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.call_end),
                      color: Colors.redAccent,
                      onPressed: () async {
                        isCallMissed = false;
                        await callMethods.endCall(call: widget.call);
                      },
                    ),
                    SizedBox(width: 24),
                    IconButton(
                        icon: Icon(Icons.call),
                        color: Colors.green,
                        onPressed: () async {
                          isCallMissed = false;
                          await Permissions.cameraAndMicrophonePermissionsGranted()
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CallScreen(call: widget.call),
                                  ),
                                )
                              // ignore: unnecessary_statements
                              : {};
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
