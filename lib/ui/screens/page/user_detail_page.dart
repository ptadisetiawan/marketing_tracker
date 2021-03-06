import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user.dart';
import 'package:marketing_tracker/core/viewmodels/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:time_formatter/time_formatter.dart';

class UserDetailPage extends StatelessWidget {
  User userDetail;
  UserDetailPage({this.userDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffFDCF09),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userDetail.photoUrl),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Nama : ${userDetail.nama}"),
                Text("No Telepon : ${userDetail.telp}"),
                Text("Alamat : ${userDetail.alamat}"),
                Text("Perusahaan : ${userDetail.perusahaan}"),
                Text("Alamat Perusahaan : ${userDetail.alamatPerusahaan}"),
                Consumer<LocationProvider>(
                  builder: (context, locationProv, _) {
                    if(locationProv.histories == null){
                       locationProv.getHistory(userDetail.email);
                      return Center(child:CircularProgressIndicator());
                    }

                      locationProv.getHistory(userDetail.email);
                       if(locationProv.histories.length < 1){
                      return Container(
                          height: 300,
                          child: Center(
                            child: Text('no history available'),
                          ));
                    }
                      var histories = locationProv.histories;
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: histories.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Card(
                                      child: ListTile(
                                    title: Text(
                                        "${histories[index].address}",
                                        style: TextStyle(fontSize: 12)),
                                        subtitle: Text(formatTime(histories[index].waktu),
                                        style: TextStyle(fontSize: 10)),
                                  )));
                            }),
                      );
      
                   
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}
