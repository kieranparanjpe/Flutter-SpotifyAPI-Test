import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import '../Logic/GlobalVariables.dart';
import '../Logic/SpotifyAPIHandler.dart';
import '../Logic/Templates.dart';



class StatsPageSongs extends StatefulWidget {
  const StatsPageSongs({Key? key, this.titleText = "", this.span = TimeSpan.short_term}) : super(key: key);

  final String titleText;
  final TimeSpan span;

  @override
  State<StatsPageSongs> createState() => _StatsPageSongsState();
}

class _StatsPageSongsState extends State<StatsPageSongs> {
  @override
  Widget build(BuildContext context) {
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
                        padding:
                        const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AppBar(
                              backwardsCompatibility: false,
                              toolbarHeight: displaySize.height / 12,
                              centerTitle: true,
                              title: FittedBox(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(ConvertToUpperCamelCase(widget.titleText),
                                        style: const TextStyle(
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold))),
                              ),
                              backgroundColor: darkGrey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                                child: ListView(children:
                                List.generate(50, (index) => SongItem(index: index))
                                ))
                          ],
                        ),
                      ))))),
      bottomNavigationBar: const NavBar(),
    );
  }
}

class SongItem extends StatelessWidget {
  const SongItem({super.key, this.index = 0});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //margin: const EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
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
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(myProfile.myTopItems.topTrackMonth[index].albumCover),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextScroll(myProfile.myTopItems.topTrackMonth[index].title,
                              selectable: true,
                              delayBefore: const Duration(milliseconds: 1000),
                              pauseBetween: const Duration(milliseconds: 1000),
                              velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.left),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextScroll("on ${myProfile.myTopItems.topTrackMonth[index].album}",
                              selectable: true,
                              delayBefore: const Duration(milliseconds: 1000),
                              pauseBetween: const Duration(milliseconds: 1000),
                              velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextScroll("by ${myProfile.myTopItems.topTrackMonth[index].artistToString()}",
                              selectable: true,
                              delayBefore: const Duration(milliseconds: 1000),
                              pauseBetween: const Duration(milliseconds: 1000),
                              velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    )
                )


              ]
          ),
        ),
      ),
    );
  }
}
