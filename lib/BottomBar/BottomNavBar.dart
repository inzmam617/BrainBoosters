import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Models/CoursesModels.dart';
import 'AllPages/HomePage.dart';
import 'AllPages/MainPeoplePage.dart';
import 'AllPages/dashBoardPage.dart';
import 'AllPages/SettingsPage.dart';

class BottomNavBar extends StatefulWidget {
  final int page;
  final String? courseName;


  final List<SubCourse>? subcourses;

  BottomNavBar({Key? key, required this.page, this.subcourses,  this.courseName}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  late IO.Socket socket;

  void connectToServer() {
    try {
      // Configure socket transports must be specified
      print("starting");
      socket = IO.io('http://192.168.0.172:3000/',IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
      socket.connect();

    } catch (e) {
      // print("hello");
      print(e.toString());
    }
  }
  late int selectedIndex ;
  late List<SubCourse>?  subcourses;
  late String? courseName;


  void _handleIncomingMessage(data) {
    setState(() {
      Map<String, String> message = {
        'senderId': data['senderId'],
        'receiverId': data['receiverId'],
        'roomId': data['roomId'].toString(),
      };
      if(message["senderId"] == id){
        print("this is id" +  id);
        _dialogBuilder(context, message);

      }
      print(message);
    });

  }
  void _handleStartingQuize(data) {
    print("Coming");
    setState(() {
      Map<String, String> message = {
        'roomId': data['roomId'].toString(),
      };
      print(message);

      // print(message);
    });

  }

   String id = "";
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id =  prefs.getString("id").toString();
    });
  }
  Future<void> _dialogBuilder(BuildContext context,Map<String, String> message  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                Text( message[ "senderId"]!
                ),
                Text(message[ "roomId"]!)


              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Accept'),
              onPressed: () {
                Map<String, String> Accept = {
                'roomId': message[ "roomId"]!,
                };
                _assetsAudioPlayer.stop();

                socket.emit("accept_invite" ,Accept);
                Navigator.of(context).pop();

              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Reject'),
              onPressed: () {
                _assetsAudioPlayer.stop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    connectToServer();
    initialize();
    socket.on("a", _handleStartingQuize);

    _assetsAudioPlayer.open(
        Playlist(
          audios: [
            Audio('assets/audio/medieval-fanfare-6826.mp3'),
            Audio('assets/audio/let-it-go-12279.mp3'),
            Audio('assets/audio/fast tempo.mp3'),
            Audio('assets/audio/medium tempo.mp3'),
            // Add more audio tracks here...
          ],
        ),
        showNotification: true,
        autoStart: false,
        loopMode: LoopMode.none
    );
    socket.on("invite", _handleIncomingMessage);

    selectedIndex = widget.page;
    subcourses = widget.subcourses;
    courseName = widget.courseName;
    print("courseName"+courseName.toString());
    setState(() {

      _widgetOptions = <Widget>[
        HomePage(subcourses : subcourses ,courseName : courseName),
        MainPeoplePage(),
        DashPage(subcourses : subcourses ,courseName : courseName),
        SettingPage()
      ];
    });
  }

   late List<Widget> _widgetOptions = <Widget>[
    HomePage(subcourses : subcourses ,courseName : courseName),
    MainPeoplePage(),
    DashPage(subcourses : subcourses ,courseName : courseName),
     SettingPage()

   ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor:  Color(0xff2a2e4d),
              icon: Icon(Icons.home,size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor:  Color(0xff2a2e4d),
              icon: Icon(Icons.person,size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.request_page_rounded,size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor:  Color(0xff2a2e4d),
              icon: Icon(Icons.settings,size: 30,
              ),
              label: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: const Color(0xff494FC7),
          unselectedItemColor: Colors.grey,
          // selectedIconTheme: const IconThemeData(color: Colors.white),
          onTap: _onItemTapped,

        ),
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
      ),
    );
  }
}
