import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 196, 152, 207),
          centerTitle: true,
          title: Text(
            "Home page",
            style: TextStyle(fontSize: 30, color: Colors.white),
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/avatar.png"),
                    radius: 30,
                  ),
                  Text("Jadid imane",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("jadid.imane@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 20))
                ],
              ),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Covid Tracker'),
                onTap: () {
                  Navigator.pop(context);
                }),
            Divider(
              color: const Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Emsi Chatbot'),
                onTap: () {
                  Navigator.pop(context);
                }),
            Divider(
              color: const Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profil'),
                onTap: () {
                  Navigator.pop(context);
                }),
            Divider(
              color: const Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                }),
            Divider(
              color: const Color.fromARGB(255, 196, 152, 207),
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Center(
        child: Text("Welcome !!",
            style: TextStyle(fontSize: 40, color: Colors.blueGrey)),
      ),
    );
  }
}
