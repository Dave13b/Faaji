import 'package:flutter/material.dart';
import 'package:untitled/data/providers/auth_provider.dart';
import 'package:untitled/ui/screens/home_page.dart';
import 'package:untitled/ui/screens/login_page.dart';


class LandingPage extends StatefulWidget{
  @override
  State<LandingPage>createState() {
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage>{


  @override
  void dispose() {
    authProvider.removeListener(onChangeNotify);
    super.dispose();
  }

  @override
  void initState() {
    authProvider.checkLoginState();
    authProvider.addListener(onChangeNotify);
    super.initState();
  }
  onChangeNotify(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    if (!authProvider.isLoggedIn) {
      return LoginPage();
    }
    return HomePage(title: "welcome ${authProvider.username}!");

  }
}