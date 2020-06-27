import 'package:eaduanfsktm/model/modelFasiliti.dart';
import 'package:flutter/material.dart';
import 'package:eaduanfsktm/FasilitiServices.dart';

class FasilitiItem extends StatefulWidget {
  FasilitiItem() : super();

  final String title = 'FASILITI';
  @override
  _FasilitiItemState createState() => _FasilitiItemState();
}

class _FasilitiItemState extends State<FasilitiItem> {
  List<Fasiliti> _fasiliti;
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _namafasilitiController;
  // controller for the Last Name TextField we are going to create.

  Fasiliti _selectedFasiliti;

  bool _isUpdating;
  String _titleProgress;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getFasiliti();
    _fasiliti = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _namafasilitiController = TextEditingController();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  // Now lets add an Employee
  _addFasiliti() {
    if (_namafasilitiController.text.isEmpty) {
      print('Empty Fields');
      return;
    }

    _showProgress('Tambah Fasiliti...');
    FasilitiServices.tambahfasiliti(_namafasilitiController.text)
        .then((result) {
      if ('success' == result) {
        _getFasiliti(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getFasiliti() {
    _showProgress('Loading Fasiliti...');
    FasilitiServices.getFasiliti().then((fasiliti) {
      setState(() {
        _fasiliti = fasiliti;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${fasiliti.length}");
    });
  }

  _updateFasiliti(Fasiliti fasiliti) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Kemaskini Fasiliti...');
    FasilitiServices.updateFasiliti(
            fasiliti.fasiliti_id, _namafasilitiController.text)
        .then((result) {
      if ('success' == result) {
        _getFasiliti(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteFasiliti(Fasiliti fasiliti) {
    _showProgress('Padam Fasiliti...');
    FasilitiServices.deleteFasiliti(fasiliti.fasiliti_id).then((result) {
      if ('success' == result) {
        _getFasiliti(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _namafasilitiController.text = '';
    ;
  }

  _showValues(Fasiliti fasiliti) {
    _namafasilitiController.text = fasiliti.namafasiliti;
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
              label: Text('Fasliti ID'),
            ),
            DataColumn(
              label: Text('NAMA Fasiliti'),
            ),

            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _fasiliti
              .map(
                (fasiliti) => DataRow(cells: [
                  DataCell(
                    Text(fasiliti.fasiliti_id),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(fasiliti);
                      // Set the Selected employee to Update
                      _selectedFasiliti = fasiliti;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      fasiliti.namafasiliti.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(fasiliti);
                      // Set the Selected employee to Update
                      _selectedFasiliti = fasiliti;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteFasiliti(fasiliti);
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
              _getFasiliti();
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
                        controller: _namafasilitiController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Masukkan nama fasiliti';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "NAMA FASILITI",
                            hintText: "Masukkan nama fasiliti"),
                      ),
                      SizedBox(height: 10.0),
                      _isUpdating
                          ? Row(
                              children: <Widget>[
                                OutlineButton(
                                  child: Text('UPDATE'),
                                  onPressed: () {
                                    _updateFasiliti(_selectedFasiliti);
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
          _addFasiliti();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
