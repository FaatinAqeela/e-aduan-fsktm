import 'package:eaduanfsktm/model/modelPengguna.dart';
import 'package:flutter/material.dart';
import 'package:eaduanfsktm/JuruteknikServices.dart';

class JuruteknikItem extends StatefulWidget {
  JuruteknikItem() : super();

  final String title = 'JURUTEKNIK';
  @override
  _JuruteknikItemState createState() => _JuruteknikItemState();
}

class _JuruteknikItemState extends State<JuruteknikItem> {
  List<Pengguna> _pengguna;
  GlobalKey<ScaffoldState> _scaffoldKey;
  Pengguna _selectedJuruteknik;
  TextEditingController _idjuruteknikController;
  TextEditingController _namajuruteknikController;
  TextEditingController _nombortelefonController;
  TextEditingController _jabatanController;
  bool _isUpdating, readonly;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _getJuruteknik();
    readonly = false;
    _pengguna = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _idjuruteknikController = TextEditingController();
    _namajuruteknikController = TextEditingController();
    _nombortelefonController = TextEditingController();
    _jabatanController = TextEditingController();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _addJuruteknik() {
    if (_idjuruteknikController.text.isEmpty ||
        _namajuruteknikController.text.isEmpty ||
        _nombortelefonController.text.isEmpty ||
        _jabatanController.text.isEmpty) {
      print('Empty Fields');
      return;
    }

    _showProgress('Tambah Juruteknik...');
    JuruteknikServices.tambahjuruteknik(
            _idjuruteknikController.text,
            _namajuruteknikController.text,
            _nombortelefonController.text,
            _jabatanController.text)
        .then((result) {
      if ('success' == result) {
        _getJuruteknik(); // Refresh the List after adding each employee...
        _clearValues();
      } else if ('idpengguna telah wujud' == result) {
        setState(() {
          Center(
            child: AlertDialog(
                title: new Text("ID Pengguna telah wujud"),
                content: new Text("Click OK untuk keluar"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text("OK"))
                ]),
          );
        });
      }
    });
  }

  _getJuruteknik() {
    _showProgress('memuatkan Juruteknik...');
    JuruteknikServices.getJuruteknik().then((pengguna) {
      setState(() {
        _pengguna = pengguna;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${pengguna.length}");
    });
  }

  _updateJuruteknik(Pengguna pengguna) {
    setState(() {
      _isUpdating = true;
      readonly = true;
    });
    _showProgress('Kemaskini juruteknik...');
    JuruteknikServices.updateJuruteknik(
            _idjuruteknikController.text,
            _namajuruteknikController.text,
            _nombortelefonController.text,
            _jabatanController.text)
        .then((result) {
      if ('success' == result) {
        _getJuruteknik(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _idjuruteknikController.text = '';
    _namajuruteknikController.text = '';
    _nombortelefonController.text = '';
    _jabatanController.text = '';
  }

  _showValues(Pengguna pengguna) {
    _idjuruteknikController.text = pengguna.id_pengguna;
    _namajuruteknikController.text = pengguna.namapenuh;
    _nombortelefonController.text = pengguna.nombortelefon;
    _jabatanController.text = pengguna.jabatan;
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
              label: Text('ID JURUTEKNIK'),
            ),
            DataColumn(
              label: Text('NAMA JURUTEKNIK'),
            ),
            // Lets add one more column to show a delete button
          ],
          rows: _pengguna
              .map(
                (pengguna) => DataRow(cells: [
                  DataCell(
                    Text(pengguna.id_pengguna.toUpperCase()),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(pengguna);
                      // Set the Selected employee to Update
                      _selectedJuruteknik = pengguna;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      pengguna.namapenuh.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(pengguna);
                      // Set the Selected employee to Update
                      _selectedJuruteknik = pengguna;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                        readonly = true;
                      });
                    },
                  ),
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
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getJuruteknik();
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
                  child: Form(
                    //key: _key,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: _idjuruteknikController,
                          readOnly: readonly,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Masukkan ID juruteknik';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "ID JURUTEKNIK",
                          ),
                        ),
                        SizedBox(width: 10.0),
                        TextFormField(
                          controller: _namajuruteknikController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Masukkan nama juruteknik';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "NAMA JURUTEKNIK",
                              hintText: "Masukkan nama jurutenik"),
                        ),
                        SizedBox(width: 10.0),
                        new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: new TextFormField(
                                  controller: _nombortelefonController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "NO TELEFON",
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Masukkan nombor telefon juruteknik';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              flex: 2,
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Container(
                                child: new TextFormField(
                                  controller: _jabatanController,
                                  decoration: InputDecoration(
                                    labelText: "JABATAN",
                                    hintText: 'FSKTM',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Masukkan jabatan';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        _isUpdating
                            ? Row(
                                children: <Widget>[
                                  OutlineButton(
                                    child: Text('UPDATE'),
                                    onPressed: () {
                                      _updateJuruteknik(_selectedJuruteknik);
                                    },
                                  ),
                                  OutlineButton(
                                    child: Text('CANCEL'),
                                    onPressed: () {
                                      setState(() {
                                        _isUpdating = false;
                                        // readonly = false;
                                      });
                                      _clearValues();
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(width: 10.0),
                      ],
                    ),
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
          _addJuruteknik();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
