import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techaway/components/Themeprovider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool night = false;
  String n = "Night Mode";
  Icon icon = const Icon(
    Icons.nightlight,
    color: Colors.redAccent,
  );

  void toggle() {
    setState(() {
      night = !night;
      if (night) {
        n = "Day Mode";
        icon = Icon(Icons.sunny, color: Colors.redAccent);
      } else {
        n = "Night Mode";
        icon = const Icon(Icons.nightlight, color: Colors.redAccent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    themeProvider.toggleTheme();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(children: [
                            icon,
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              n,
                              style: TextStyle(color: Colors.redAccent),
                            )
                          ]),
                        ),
                      ))),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(children: [
                          Icon(
                            Icons.share,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Share this app",
                            style: TextStyle(color: Colors.redAccent),
                          )
                        ]),
                      ),
                    ))),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Notification",
                            style: TextStyle(color: Colors.redAccent),
                          )
                        ]),
                      ),
                    ))),
          ),
        ]),
      ),
    );
  }
}
