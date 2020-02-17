import 'package:flutter/material.dart';

class CategoryListing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryListingState();
}

class _CategoryListingState extends State<CategoryListing> {
  var listUnselected = ['A', 'B', 'C'];
  var listSelected = ['A', 'B', 'C'];

  // TODO: Make the
  @override
  Widget build(BuildContext context) {
    var lvUnselected = rebuildUnselected();
    var lvSelected = rebuildSelected();

    Widget searchBox = Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        decoration: InputDecoration(labelText: 'Masukkan kata kunci...'),
      ),
    );

    Widget searchTerm = Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Kategori yang dipilih: ' + getSelectedList(),
      ),
    );

    Widget listing = Container(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5, left: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
              ),
              child: lvSelected,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5, left: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(10),
                ),
              ),
              child: lvUnselected,
            ),
          ),
        ],
      ),
    );

    Widget search = Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          searchBox,
          searchTerm,
          listing,
        ],
      ),
    );

    return search;
  }

  rebuildUnselected() {
    return ListView.builder(
      //itemCount harus dibikin dinamis nanti
      itemCount: listUnselected.length,
      scrollDirection: Axis.vertical,

      //Buat build list
      itemBuilder: (context, index) {
        return CategoryItem(
          name: listUnselected[index],
          onPress: () {
            listSelected.add(listUnselected[index]);
            listUnselected.removeAt(index);

            setState(() {
              rebuildUnselected();
              rebuildSelected();
            });
          },
        );
      },
    );
  }

  rebuildSelected() {
    return ListView.builder(
      //itemCount harus dibikin dinamis nanti
      itemCount: listSelected.length,
      scrollDirection: Axis.vertical,
      //Buat build list
      itemBuilder: (context, index) {
        return CategoryItem(
          name: listSelected[index],
          onPress: () {
            listUnselected.add(listSelected[index]);
            listSelected.removeAt(index);

            setState(() {
              rebuildUnselected();
              rebuildSelected();
            });
          },
        );
      },
    );
  }

  getSelectedList() {
    String list = "";
    for (var i = 0; i < listSelected.length; i++) {
      list += listSelected[i] + ", ";
    }
    return list;
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final Function onPress;

  CategoryItem({
    Key key,
    this.name,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onPress,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
