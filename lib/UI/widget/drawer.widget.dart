import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.deepOrange
                      ]
                  )
              ),
              child:Center(
                child: CircleAvatar(
                  radius: 40,
                ),
              )
          ),
          ListTile(
            title: Text('Search GIT',
              style: TextStyle(
                  fontSize: 22
              ),
            ),
            leading: Icon(Icons.search),
            trailing: Icon(Icons.arrow_right,color: Colors.deepOrange,),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/users");
            },
          )
        ],
      ),
    );
  }
}