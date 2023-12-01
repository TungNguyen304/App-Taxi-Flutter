import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resources/login-page.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({ Key? key }) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            ListTile(
              iconColor: Colors.orangeAccent,
              onTap: () {},
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text(
                "My profile",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              iconColor: Colors.orangeAccent,
              onTap: () {},
              leading: const Icon(Icons.history_rounded),
              title: const Text(
                "Ride history",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              iconColor: Colors.orangeAccent,
              onTap: () {},
              leading: const Icon(Icons.add_box_outlined),
              title: const Text(
                "Offers",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              iconColor: Colors.orangeAccent,
              onTap: () {},
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              iconColor: Colors.orangeAccent,
              onTap: () {},
              leading: const Icon(Icons.help_outline_outlined),
              title: const Text(
                "Help and support",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              iconColor: Colors.orangeAccent,
              onTap: logout,
              leading: const Icon(Icons.logout_rounded),
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void logout() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}