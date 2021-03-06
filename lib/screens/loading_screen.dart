import 'package:applaluz_chat/screens/login_screen.dart';
import 'package:applaluz_chat/screens/user_screen.dart';
import 'package:applaluz_chat/services/auth_service.dart';
import 'package:applaluz_chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Autenticando...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      socketService.connect();
      //Navigator.pushReplacementNamed(context, 'user');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UserScreen(),
              transitionDuration: Duration(microseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginScreen(),
              transitionDuration: Duration(microseconds: 0)));
    }
  }
}
