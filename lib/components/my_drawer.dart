import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // logo 
          DrawerHeader(child: Center(child: Icon(Icons.music_note,size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,),),
          ),
          // home
          ListTile(
            title: const Text('H O M E'),
            leading: const Icon(Icons.home),
            onTap: ()=> Navigator.pop(context),
          ).pOnly(left: 25, top: 25),
          // settings
          ListTile(
            title: const Text('S E T T I N G S'),
            leading: const Icon(Icons.settings),
            onTap: (){
              // pop drawer
              Navigator.pop(context);
              // Navigate to setting page
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
            },
          ).pOnly(left: 25, top: 0)
        ],
      ),
    );
  }
}
