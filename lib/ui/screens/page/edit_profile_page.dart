import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/core/viewmodels/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  User user;
  EditProfilePage({Key key, this.user}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // TextEditingController _email;
  TextEditingController _nama;
  TextEditingController _telp;
  TextEditingController _alamat;
  TextEditingController _perusahaan;
  TextEditingController _alamatPerusahaan;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // _email = TextEditingController(text: "");
    _nama = TextEditingController(text: widget.user.nama);
    _telp = TextEditingController(text: widget.user.telp);
    _alamat = TextEditingController(text: widget.user.alamat);
    _perusahaan = TextEditingController(text: widget.user.perusahaan);
    _alamatPerusahaan =
        TextEditingController(text: widget.user.alamatPerusahaan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(title: Text('Edit profile')),
        body: Form(
          key: _formKey,
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: TextFormField(
                        controller: _nama,
                        validator: (value) =>
                            (value.isEmpty) ? "Please enter nama" : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Nama",
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _telp,
                      validator: (value) =>
                          (value.isEmpty) ? "Please Enter Telepon" : null,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: "Telepon",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _alamat,
                      validator: (value) =>
                          (value.isEmpty) ? "Please Enter Alamat" : null,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.pin_drop),
                          labelText: "Alamat",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _perusahaan,
                      validator: (value) =>
                          (value.isEmpty) ? "Please Enter Perusahaan" : null,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          labelText: "Perusahaan",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _alamatPerusahaan,
                      validator: (value) => (value.isEmpty)
                          ? "Please Enter Alamat Perusahaan"
                          : null,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.pin_drop),
                          labelText: "Alamat perusahaan",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            await Provider.of<UserProvider>(context,
                                    listen: false)
                                .updateUser(
                                    User(
                                        nama: _nama.text,
                                        alamat: _alamat.text,
                                        telp: _telp.text,
                                        perusahaan: _perusahaan.text,
                                        alamatPerusahaan:
                                            _alamatPerusahaan.text),
                                    widget.user.email);
                            await Provider.of<AuthService>(context,
                                    listen: false)
                                .setDbUser(
                              User(
                                  nama: _nama.text,
                                  alamat: _alamat.text,
                                  telp: _telp.text,
                                  perusahaan: _perusahaan.text,
                                  alamatPerusahaan: _alamatPerusahaan.text,
                                  email: widget.user.email),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Simpan",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

  @override
  void dispose() {
    // _email.dispose();
    _nama.dispose();
    _alamat.dispose();
    _telp.dispose();
    _perusahaan.dispose();
    _alamatPerusahaan.dispose();
    super.dispose();
  }
}
