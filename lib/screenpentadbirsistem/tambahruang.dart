import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:eaduanfsktm/model/modelPengguna.dart';
import 'package:http/http.dart' as http;
import 'package:eaduanfsktm/Services.dart';
import 'package:eaduanfsktm/api.dart';
import 'package:eaduanfsktm/model/modelRuang.dart';
import 'package:flutter/material.dart';

class TambahRuang extends StatefulWidget {
  TambahRuang() : super();

  final String title = 'RUANG';
  @override
  _TambahRuangState createState() => _TambahRuangState();
}

class _TambahRuangState extends State<TambahRuang> {
  List<Ruang> _ruang;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _namaruangController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lokasiController;
  TextEditingController _arasController;
  Ruang _selectedRuang;

  bool _isUpdating;
  String _titleProgress;

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Pengguna>> key = new GlobalKey();
  bool loading = true;
  static List<Pengguna> pengguna = new List<Pengguna>();

  @override
  void initState() {
    super.initState();
    _getRuang();
    getPengguna();
    _ruang = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _namaruangController = TextEditingController();
    _lokasiController = TextEditingController();
    _arasController = TextEditingController();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

//to get juruteknik that already in the database using typeahead
  getPengguna() async {
    try {
      final response = await http.get(BaseUrl.lihatjuruteknik());
      if (response.statusCode == 200) {
        pengguna = loadUsers(response.body);
        print('Users: ${pengguna.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<Pengguna> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Pengguna>((json) => Pengguna.fromJson(json)).toList();
  }

  Widget row(Pengguna pengguna) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          pengguna.namapenuh,
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          pengguna.id_pengguna,
        ),
      ],
    );
  }

  // Now lets add an Employee
  _addRuang() {
    if (_namaruangController.text.isEmpty ||
        _lokasiController.text.isEmpty ||
        _arasController.text.isEmpty ||
        searchTextField.textField.controller.text.isEmpty) {
      print('Empty Fields');
      return;
    }

    _showProgress('Tambah Ruang...');
    Services.tambahruang(_namaruangController.text, _lokasiController.text,
            _arasController.text, searchTextField.textField.controller.text)
        .then((result) {
      if ('success' == result) {
        _getRuang(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getRuang() {
    _showProgress('Loading Ruang...');
    Services.getRuang().then((ruang) {
      setState(() {
        _ruang = ruang;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${ruang.length}");
    });
  }

  _updateRuang(Ruang ruang) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Kemaskini Ruang...');
    Services.updateRuang(
            ruang.ruangid,
            _namaruangController.text,
            _lokasiController.text,
            _arasController.text,
            searchTextField.textField.controller.text)
        .then((result) {
      if ('success' == result) {
        _getRuang(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteRuang(Ruang ruang) {
    _showProgress('Padam Ruang...');
    Services.deleteRuang(ruang.ruangid).then((result) {
      if ('success' == result) {
        _getRuang(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _namaruangController.text = '';
    _lokasiController.text = '';
    _arasController.text = '';
    searchTextField.textField.controller.text = '';
  }

  _showValues(Ruang ruang) {
    _namaruangController.text = ruang.namaruang;
    _lokasiController.text = ruang.lokasi;
    _arasController.text = ruang.aras;
    searchTextField.textField.controller.text = ruang.juruteknik_id;
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('RUANG ID'),
            ),
            DataColumn(
              label: Text('NAMA RUANG'),
            ),
            DataColumn(
              label: Text('LOKASI'),
            ),
            DataColumn(
              label: Text('ARAS'),
            ),
            DataColumn(
              label: Text('JURUTEKNIK'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _ruang
              .map(
                (ruang) => DataRow(cells: [
                  DataCell(
                    Text(ruang.ruangid),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(ruang);
                      // Set the Selected employee to Update
                      _selectedRuang = ruang;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      ruang.namaruang.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(ruang);
                      // Set the Selected employee to Update
                      _selectedRuang = ruang;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      ruang.lokasi.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(ruang);
                      // Set the Selected employee to Update
                      _selectedRuang = ruang;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      ruang.aras.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(ruang);
                      // Set the Selected employee to Update
                      _selectedRuang = ruang;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      ruang.juruteknik_id.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(ruang);
                      // Set the Selected employee to Update
                      _selectedRuang = ruang;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteRuang(ruang);
                    },
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getRuang();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _namaruangController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Masukkan nama ruang';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "NAMA RUANG",
                            hintText: "Masukkan nama ruang"),
                      ),
                      SizedBox(width: 10.0),
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: new TextFormField(
                                controller: _lokasiController,
                                decoration: InputDecoration(
                                  labelText: "LOKASI",
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Container(
                              child: new TextFormField(
                                controller: _arasController,
                                decoration: InputDecoration(
                                  labelText: "ARAS",
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                      SizedBox(width: 10.0),
                      searchTextField = AutoCompleteTextField<Pengguna>(
                        key: key,
                        clearOnSubmit: false,
                        suggestions: pengguna,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: " Masukkan ID juruteknik",
                          labelText: "JURUTEKNIK ID",
                        ),
                        itemFilter: (item, query) {
                          return item.id_pengguna
                              .toLowerCase()
                              .startsWith(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.id_pengguna.compareTo(b.id_pengguna);
                        },
                        itemSubmitted: (item) {
                          setState(() {
                            searchTextField.textField.controller.text =
                                item.id_pengguna;
                          });
                        },
                        itemBuilder: (context, item) {
                          // ui for the autocomplete row
                          return row(item);
                        },
                      ),
                      SizedBox(height: 10.0),
                      _isUpdating
                          ? Row(
                              children: <Widget>[
                                OutlineButton(
                                  child: Text('UPDATE'),
                                  onPressed: () {
                                    _updateRuang(_selectedRuang);
                                  },
                                ),
                                OutlineButton(
                                  child: Text('CANCEL'),
                                  onPressed: () {
                                    setState(() {
                                      _isUpdating = false;
                                    });
                                    _clearValues();
                                  },
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Card(
              child: _dataBody(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addRuang();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
