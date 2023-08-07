import 'package:first_flutter_app/Logic/SpotifyAPIHandler.dart';
import 'package:first_flutter_app/Logic/Templates.dart';
import 'package:flutter/material.dart';
import '../Logic/GlobalVariables.dart';
import 'StatsPageSongs.dart';

class StatsPageHome extends StatefulWidget {
  const StatsPageHome({super.key});

  @override
  State<StatsPageHome> createState() => _StatsPageHomeState();
}

class _StatsPageHomeState extends State<StatsPageHome> {
  @override
  Widget build(BuildContext context) {
    displaySize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: darkGrey,
      body: SafeArea(
          child: Center(
              child: FractionallySizedBox(
                  widthFactor: 0.97,
                  heightFactor: 0.98,
                  child: Container(
                      decoration: BoxDecoration(
                          color: mediumGrey,
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 10, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppBar(
                              automaticallyImplyLeading: false,
                              toolbarHeight: displaySize.height / 12,
                              centerTitle: true,
                              title: const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Your Stats",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold))),
                              backgroundColor: darkGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                                child: ListView(children: const [
                              StatButton(index: 0, title: "top songs of the month"),
                              SizedBox(height: 10),
                              StatButton(index: 1, title: "top songs of the year"),
                              SizedBox(height: 10),
                              StatButton(index: 2, title: "top songs of all time"),
                              SizedBox(height: 10),
                              StatButton(index: 3, title: "top artists of the month"),
                              SizedBox(height: 10),
                              StatButton(index: 4, title: "top artists of the year"),
                              SizedBox(height: 10),
                              StatButton(index: 5, title: "top artists of all time"),
                              SizedBox(height: 10),
                              StatButton(index: 6, title: "top albums of the month"),
                              SizedBox(height: 10),
                              StatButton(index: 7, title: "top albums of the year"),
                              SizedBox(height: 10),
                              StatButton(index: 8, title: "top albums of all time"),
                              SizedBox(height: 10),
                            ]))
                          ],
                        ),
                      ))))),
      bottomNavigationBar: const NavBar(),
    );
  }
}

class StatButton extends StatelessWidget {
  const StatButton({super.key, this.index = 0, this.title = ""});

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Widget page;
          if (index < 3) {
            page = StatsPageSongs(titleText: title, span: TimeSpan.values[index]);

            getTopTracks(TimeSpan.values[index]);
          } else {
            page = const StatsPageHome();
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
        style:  ElevatedButton.styleFrom(
            backgroundColor: darkGrey,
            elevation: 0,
            splashFactory:
            NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            //  crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Placeholder(
                  strokeWidth: 3,
                  fallbackHeight: displaySize.height * 0.095,
                  fallbackWidth: displaySize.height * 0.095,
                  color: Colors.white,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                        ),
                        textAlign: TextAlign.right),
                  ),
                ),


              ]
          ),
        ),
      ),
    );
  }
}


