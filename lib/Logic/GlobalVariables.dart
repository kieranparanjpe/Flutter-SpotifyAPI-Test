import 'package:flutter/material.dart';
import '../UI/StatsPageHome.dart';
import '../UI/ProfilePageHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
const Color darkGrey = Color(0xFF241F21);
const Color mediumGrey = Color(0xFF545454);
Size displaySize = const Size(1000, 2000);

String ConvertToUpperCamelCase(String input)
{
  String output = input.substring(0, 1).toUpperCase();
  for(int i = 1; i < input.length; i++)
  {
    String c = input.substring(i, i + 1);
    if(input.substring(i-1, i).compareTo(" ") == 0)
      output += c.toUpperCase();
    else
      output += c;
  }

  return output;
}

Future<void> saveData(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> loadData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: displaySize.height / 12,
        margin: EdgeInsets.only(
            left: displaySize.width * 0.01,
            right: displaySize.width * 0.01,
            bottom: displaySize.height * 0.01),
        decoration: BoxDecoration(
            color: mediumGrey, borderRadius: BorderRadius.circular(80)),
        child: BottomNavigationBar(
          onTap: (int index){
            Widget page = const StatsPageHome();
            if (index == 2) {
              page = const StatsPageHome();
            } else if (index == 3) {
              page = const ProfilePageHome();
            }

            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation1,
                    Animation<double> animation2) {
                  return page;
                },
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );

          },
          items: const [
            BottomNavigationBarItem(
                icon: Text("H",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Text("E",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                label: "Explore"),
            BottomNavigationBarItem(
                icon: Text("S",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                label: "Stats"),
            BottomNavigationBarItem(
                icon: Text("P",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                label: "Profile")
          ],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color(0x00000000),
          elevation: 0,
        ));
  }
}
