import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BuildInfo extends StatefulWidget {
  final Color color;
  final double fontSize;
  BuildInfo({this.color = Colors.black38, this.fontSize = 10});

  @override
  _BuildInfoState createState() => _BuildInfoState();
}

class _BuildInfoState extends State<BuildInfo> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          "Version:${_packageInfo.version}",
          style: TextStyle(fontSize: widget.fontSize, color: widget.color),
        ),
        Text("Customer Support No +6011-5900 8821",
            style:
                TextStyle(fontSize: widget.fontSize - 1, color: widget.color))
      ],
    ));
  }
}
