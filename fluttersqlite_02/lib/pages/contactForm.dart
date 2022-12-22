import 'package:flutter/material.dart';
import 'package:fluttersqlite_02/helpers/dbhelper.dart';
import 'package:fluttersqlite_02/models/contact.dart';

class ContactForm extends StatefulWidget {
  final Contact? kontak;
  ContactForm({this.kontak});
  @override
  _FormContactState createState() => _FormContactState();
}

class _FormContactState extends State<ContactForm> {
  DbHelper db = DbHelper();
  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;
  @override
  void initState() {
    name = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.name);
    mobileNo = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.mobileNo);
    email = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Form')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: mobileNo,
              decoration: InputDecoration(
                  labelText: 'Mobile No',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.kontak == null)
                  ? Text('Add', style: TextStyle(color: Colors.white))
                  : Text('Update', style: TextStyle(color: Colors.white)),
              onPressed: () {
                upsertKontak();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
//update
      await db.updateKontak(Contact(
        id: widget.kontak!.id,
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
      ));
      Navigator.pop(context, 'update');
    } else {
//insert
      await db.saveKontak(Contact(
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
