import 'package:flutter/material.dart';
import 'package:fluttersqlite_02/helpers/dbhelper.dart';
import 'package:fluttersqlite_02/models/contact.dart';
import 'package:fluttersqlite_02/pages/contactForm.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);
  @override
  _ListKontakPageState createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ContactListPage> {
  List<Contact> listKontak = [];
  DbHelper db = DbHelper();
  @override
  void initState() {
//menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text("Contact App"),
        ),
      ),
      body: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, index) {
            Contact kontak = listKontak[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${kontak.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Phone: ${kontak.mobileNo}"),
                    ),Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${kontak.email}"),
                    ),
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
// button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(kontak);
                          },
                          icon: Icon(Icons.edit)),
// button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
//membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [Text("Are you sure delete? ${kontak.name}")],
                              ),
                            ),
//terdapat 2 button.
//jika ya maka jalankan _deleteKontak() dan tutup dialog
//jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteKontak(kontak, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
//membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

//mengambil semua data Kontak
  Future<void> _getAllKontak() async {
//list menampung data dari database
    var list = await db.getAllKontak();
//ada perubahanan state
    setState(() {
//hapus data pada listKontak
      listKontak.clear();
//lakukan perulangan pada variabel list
      list!.forEach((kontak) {
//masukan data ke listKontak
        listKontak.add(Contact.fromMap(kontak));
      });
    });
  }

//menghapus data Kontak
  Future<void> _deleteKontak(Contact kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

// membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactForm()));
    if (result == 'save') {
      await _getAllKontak();
    }
  }

//membuka halaman edit Kontak
  Future<void> _openFormEdit(Contact kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactForm(kontak: kontak)));
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}