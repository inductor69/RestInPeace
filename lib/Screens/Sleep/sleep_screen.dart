import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter_auth/Screens/Sleep/city_sound.dart';
import 'package:flutter_auth/Screens/Sleep/rain_sounds.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_auth/data/settings.dart';
import 'package:flutter_auth/widgets/settings_card.dart';
import 'package:provider/provider.dart';

import 'forest_sound.dart';
import 'meditating_sound.dart';

class SleepScreen extends StatefulWidget {
  SleepScreen({this.startingAnimation = false, Key key}) : super(key: key);

  /// Determins if the starting animation should be played. It should only be played when the app is first launched from quit.
  final bool startingAnimation;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<SleepScreen>
    with TickerProviderStateMixin {
  bool playSounds;
  bool isZenMode;
  Duration _presetDuration;

  AnimationController _scaffold;
  AnimationController _logo;
  Animation<Offset> _animation;
  Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();
    playSounds =
        Provider.of<MeditationModel>(context, listen: false).playSounds;
    isZenMode = Provider.of<MeditationModel>(context, listen: false).isZenMode;
    _presetDuration =
        Provider.of<MeditationModel>(context, listen: false).duration;

    _scaffold = AnimationController(
        vsync: this,
        value: widget.startingAnimation ? 0.0 : 1.0,
        duration: Duration(milliseconds: 1800));
    _logo = AnimationController(
        vsync: this,
        value: widget.startingAnimation ? 0.0 : 1.0,
        duration: Duration(milliseconds: 1800));
    _animation =
        Tween<Offset>(begin: Offset(0, 0.25), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _scaffold, curve: Curves.easeOutQuart),
    );

    _logoAnimation =
        Tween<Offset>(begin: Offset(0, 0.65), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _logo,
        curve: Interval(
          0.25,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    if (widget.startingAnimation) {
      _scaffold.forward();
      _logo.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Explore Meditation",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Calming Sounds",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: <Widget>[
                        cupertino.GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CityScreen()));
                          },
                          child: SettingsCard(
                            start: true,
                            title: Text(
                              'City Sounds',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            leading: Icon(Ionicons.ios_musical_note),
                            trailing: Icon(Ionicons.ios_arrow_forward),
                          ),
                        ),
                        cupertino.GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForestScreen()));
                          },
                          child: SettingsCard(
                            title: Text(
                              'Forest Sounds',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            leading: Icon(Ionicons.ios_musical_note),
                            trailing: Icon(Ionicons.ios_arrow_forward),
                          ),
                        ),
                        cupertino.GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MeditatingScreen()));
                          },
                          child: SettingsCard(
                            title: Text(
                              'Meditating Sounds',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            leading: Icon(Ionicons.ios_musical_note),
                            trailing: Icon(Ionicons.ios_arrow_forward),
                          ),
                        ),
                        cupertino.GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RainScreen()));
                          },
                          child: SettingsCard(
                            end: true,
                            title: Text(
                              'Rain Sounds',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            leading: Icon(Ionicons.ios_musical_note),
                            trailing: Icon(Ionicons.ios_arrow_forward),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
