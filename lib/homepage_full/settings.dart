import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roule_based_auth/registerAndLogin/login.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              userName: "Babacar Ndong",
              backgroundColor: Color.fromARGB(255, 101, 220, 178),
              userProfilePic: AssetImage("assets/ajk1.png"),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Color.fromARGB(255, 189, 166, 60),
                ),
                title: "Modify",
                subtitle: "Tap to change your data",
                onTap: () {
                  print("OK");
                },
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  subtitle: "Make Ziar'App yours",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Ziar'App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    _signOut();
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
