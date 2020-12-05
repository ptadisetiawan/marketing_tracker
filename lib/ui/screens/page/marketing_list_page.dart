import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/viewmodels/user_provider.dart';
import 'package:marketing_tracker/ui/screens/items/drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketingListPage extends StatefulWidget {
  @override
  _MarketingListPageState createState() => _MarketingListPageState();
}

class _MarketingListPageState extends State<MarketingListPage> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Marketing List')),
        drawer: DrawerApp(),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Consumer<UserProvider>(
      builder: (context, userProv, _) {
        userProv.getUserList();
        if (userProv.users.length > 0) {
          var userList = userProv.users;
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      child: ListTile(title: Text(userList[index].nama, style: TextStyle(fontSize: 20)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: Icon(Icons.person), onPressed: (){
                             Navigator.pushNamed(context, '/marketing/details', arguments: userList[index]);
                          },),
                          SizedBox(width:10),
                          IconButton(icon: Icon(Icons.call), onPressed:(){
                            _makePhoneCall('tel:${userList[index].telp}');
                          }),
                        ],
                      ),
                      )
                  ));
                }),
          );
        } else {
          return Center(child: Text('tidak ada data'));
        }
      },
    );
  }
}
