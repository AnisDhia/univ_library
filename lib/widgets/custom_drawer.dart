import 'package:flutter/material.dart';
import 'package:univ_library/screens/settings_screen.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'User name',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'examle@univ.edu',
                  style: TextStyle(color: Colors.grey[200], fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SettingsScreen()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              // AuthenticationService().signOut()
              // authenticationCubit.signout()
            },
          ),
          
        ],
      ),
    );
  }
}
