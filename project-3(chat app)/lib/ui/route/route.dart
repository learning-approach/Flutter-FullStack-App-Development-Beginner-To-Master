import 'package:chatapp/ui/views/auth/sign_in.dart';
import 'package:chatapp/ui/views/auth/sign_up.dart';
import 'package:chatapp/ui/views/chat_room.dart';
import 'package:chatapp/ui/views/home_screen.dart';
import 'package:chatapp/ui/views/splash_screen.dart';
import 'package:get/get.dart';

const String splash = '/splash';
const String signUp = '/signUp';
const String signIn = '/signIn';
const String homeScreen = '/home';
const String chatRoom = '/chat-room';

//  control our page route flow

List<GetPage> getPages = [

  GetPage(
    name: splash,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: signUp,
    page: () => SignUp(),
  ),
  GetPage(
    name: signIn,
    page: () => SignIn(),
  ),
  GetPage(
    name: homeScreen,
    page: () => HomePage(),
  ),
  GetPage(
    name: chatRoom,
    page: () {
      ChatRoom chatRoom = Get.arguments;
      return chatRoom;
    },
  ),
];
