# Avatar Glow [![GitHub stars](https://img.shields.io/github/stars/apgapg/avatar_glow.svg?style=social)](https://github.com/apgapg/avatar_glow) [![Twitter Follow](https://img.shields.io/twitter/url/https/@ayushpgupta.svg?style=social)](https://twitter.com/ayushpgupta) ![GitHub last commit](https://img.shields.io/github/last-commit/apgapg/avatar_glow.svg) [![Website shields.io](https://img.shields.io/website-up-down-green-red/http/shields.io.svg)](https://play.google.com/store/apps/details?id=com.coddu.flutterprofile)

This Flutter package provides a Avatar Glow Widget with cool background glowing animation.

# 💻 Installation
In the `dependencies:` section of your `pubspec.yaml`, add the following line:

[![Version](https://img.shields.io/pub/v/avatar_glow.svg)](https://pub.dartlang.org/packages/avatar_glow)

```yaml
dependencies:
  avatar_glow: <latest version>
```

# ❔ Usage

### Import this class

```dart
import 'package:avatar_glow/avatar_glow.dart';
```

#### Usage is simple. Avatar Glow is a widget offering different customizable optional parameters with child displayed at its center.

<img src="https://raw.githubusercontent.com/apgapg/avatar_glow/master/src/app.gif" align = "right" height = "400" alt="PieChart">

```dart
AvatarGlow(
    glowColor: Colors.blue,
    endRadius: 90.0,
    duration: Duration(milliseconds: 2000),
    repeat: true,
    showTwoGlows: true,
    repeatPauseDuration: Duration(milliseconds: 100),
    child: Material(
      elevation: 8.0,
      shape: CircleBorder(),
      child: CircleAvatar(
        backgroundColor:Colors.grey[100] ,
        child: Image.asset('assets/images/flutter.png',height: 60,),
        radius: 40.0,
      ),
    ),
  )
```
# ⭐ Other Flutter Packages
- [pie_chart](https://pub.dartlang.org/packages/pie_chart)  [![GitHub stars](https://img.shields.io/github/stars/apgapg/pie_chart.svg?style=social)](https://github.com/apgapg/pie_chart)  Flutter Pie Chart with cool animation.

# 👍 Contribution
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
