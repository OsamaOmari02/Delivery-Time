import 'package:app/LanguageProvider.dart';
import 'package:app/Myprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Drawer.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    Provider.of<MyProvider>(context, listen: false).getDarkMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    dialog() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const SizedBox(width: 10),
                  const Text("عربي", style: const TextStyle(fontSize: 20)),
                  Switch(
                      activeColor: Colors.blueAccent,
                      activeTrackColor: Colors.blue[200],
                      value: Provider.of<LanProvider>(context,listen: false).isEn,
                      onChanged: (val) async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('language', val);
                        setState(() {
                          Provider.of<LanProvider>(context,listen: false).isEn = val;
                        });
                        Navigator.of(context).pop();
                      }),
                  const Text("English", style: const TextStyle(fontSize: 20)),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              actions: [
                TextButton(
                    child: Text(Provider.of<LanProvider>(context,listen: false).texts('ok'),
                        style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }
    dialog2() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () async =>
                            await launch('tel://0779434462'),
                        child: const Text(
                          "0779434462",
                          style: const TextStyle(fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () async =>
                            await launch('tel://0795143290'),
                        child: const Text(
                          "0795143290",
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              elevation: 24,
              actions: [
                TextButton(
                    child: Text(Provider.of<LanProvider>(context,listen: false).texts('cancel?'),
                        style: const TextStyle(fontSize: 21)),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            );
          });
    }

    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

    Future<bool> _onWillPop() async {
      await Navigator.of(context).pushReplacementNamed('MyHomepage');
      throw "";
    }
    return Directionality(
      textDirection: Provider.of<LanProvider>(context,listen: false).isEn ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            title: Text(Provider.of<LanProvider>(context,listen: false).texts('Drawer6')),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: ListView(
            children: [
              SizedBox(height: height * 0.05),
              ListTile(
                leading: const Icon(Icons.language),
                title: InkWell(
                  child: Text(Provider.of<LanProvider>(context,listen: false).texts('language'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                  onTap: () => dialog(),
                ),
              ),
              SizedBox(height: height * 0.013),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text(Provider.of<LanProvider>(context,listen: false).texts('dark mode'),
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                trailing: Switch(
                    activeColor: Colors.blueAccent,
                    activeTrackColor: Colors.blue[200],
                    value: Provider.of<MyProvider>(context,listen: false).isDark,
                    onChanged: (bool val) async {
                      await Provider.of<MyProvider>(context,listen: false).setDarkMode(val);
                    }),
              ),
              SizedBox(height: height * 0.013),
              ListTile(
                leading: const Icon(Icons.phone),
                title: InkWell(
                  child: Text(Provider.of<LanProvider>(context,listen: false).texts('call us'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                  onTap: () => dialog2(),
                ),
              ),
              const Divider(thickness: 0.6),
              if (isAndroid)
              ListTile(
                leading: const Icon(Icons.star_rate_outlined),
                title: InkWell(
                  child: Text(Provider.of<LanProvider>(context,listen: false).texts('rate app'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                  onTap: () async{
                    await launch('https://play.google.com/store/apps/details?id=com.delivery.time.osama');
                  },
                ),
              ),
              if (isAndroid)
              SizedBox(height: height * 0.013),
              if (isAndroid)
              ListTile(
                leading: const Icon(Icons.share),
                title: InkWell(
                  child: Text(Provider.of<LanProvider>(context,listen: false).texts('share app'),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: width * 0.055)),
                  onTap: () async{
                     await Share.share('https://play.google.com/store/apps/details?id=com.delivery.time.osama');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
