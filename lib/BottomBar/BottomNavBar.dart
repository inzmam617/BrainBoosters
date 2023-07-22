import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../Models/CoursesModels.dart';
import '../QuizePage/QuizePage.dart';
import '../const.dart';
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
      print("starting");
      socket = IO.io(baseUrl,IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
      socket.connect();

    } catch (e) {
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
      if(message["receiverId"] == id){
        // _assetsAudioPlayer.playlistPlayAtIndex(1);
        print("this is id$id");
        _dialogBuilder(context, message);
      }
      print(message);
    });

  }
  void _handleStartingQuize(data) {
    setState(() {
      String quizData =data["quizData"];
      // print(quizData.split('courseName: ')[1].split(',')[0]);
      // print(quizData.split('subcourseName: ')[1].split(',')[0]);
      // print(quizData.split('chapterName: ')[1].split(',')[0].split('}')[0]);
      String roomId =data["roomId"];
      String senderId =data["senderId"];
      String receiverId =data["receiverId"];
      if((roomId ==   senderId+receiverId&&id==senderId)||(roomId ==   senderId+receiverId&&id==receiverId)){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          return QuizPage(courseName :quizData.split('courseName: ')[1].split(',')[0],
            roomId: roomId,
            Id:id,
              MatchType: "1v1",
              subcourseName :quizData.split('subcourseName: ')[1].split(',')[0],chapterName:quizData.split('chapterName: ')[1].split(',')[0].split('}')[0] ,);
        }));
      }
    });
  }
   String id = "";
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id =  prefs.getString("id").toString();
    });
  }
  Future<void> _dialogBuilder(BuildContext context, Map<String, String> message) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // Show the dialog
        AlertDialog dialog = AlertDialog(
          title: const Text('Basic dialog title'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Text("You Have 10 sec to accept otherwise it will be rejected",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text( "${message["senderId"]!}wants to send you invitation to quiz"),
                SizedBox(height: 10,),
                Text( "Room Id: ${message["roomId"]!}"),
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
                Map<String, String> quizData = {
                  "courseName": "Physics",
                  "subcourseName": "Mechanics",
                  "chapterName": "Motion",
                };
                Map<String, String> Accept = {
                  'roomId': message["roomId"]!,
                  "quizData": quizData.toString(),
                };
                _assetsAudioPlayer.stop();
                socket.emit("accept_invite", Accept);
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

        // Automatically close the dialog after 10 seconds
        Future.delayed(const Duration(seconds: 10), () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
            content: Text('Invitation Has been rejected'),
          ));

        });

        return dialog;
      },
    );
  }
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
    connectToServer();
    initialize();
    socket.on("quiz_started", _handleStartingQuize);
    _assetsAudioPlayer.open(
        Playlist(
          audios: [
            Audio('assets/audio/popup.wav'),
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
    print("courseName$courseName");
    setState(() {

      _widgetOptions = <Widget>[
        HomePage(subcourses : subcourses ,courseName : courseName),
        MainPeoplePage(subcourses : subcourses ,courseName : courseName),
        DashPage(subcourses : subcourses ,courseName : courseName),
        const SettingPage()
      ];
    });
  }

   late List<Widget> _widgetOptions = <Widget>[
    HomePage(subcourses : subcourses ,courseName : courseName),
    MainPeoplePage(subcourses : subcourses ,courseName : courseName),
    DashPage(subcourses : subcourses ,courseName : courseName),
     const SettingPage()

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
