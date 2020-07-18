import 'package:competition_arena/components/competition_list.dart';
import 'package:competition_arena/values/color_palette.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> tags = ['IT', 'Multimedia', 'Jaringan'];
  List<String> selectedTags = ['', '', ''];
  List<String> tagsToSend = [];
  List<bool> selectedStatus = [false, false, false];
  List<Color> colors = [
    ColorPalette.black,
    ColorPalette.black,
    ColorPalette.black
  ];
  String keyword;

  buildTagsToSend() {
    tagsToSend = [];
    for (int i = 0; i < selectedTags.length; i++) {
      if (selectedTags[i] != '') {
        tagsToSend.add(selectedTags[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorPalette.lightBlue_500,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          onChanged: (text) {
            setState(() {
              keyword = text;
            });
          },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 40,
              child: ListView.builder(
                //itemCount harus dibikin dinamis nanti
                itemCount: tags.length,
                scrollDirection: Axis.horizontal,

                //Buat build list
                itemBuilder: (context, index) {
                  return CategoryItem(
                    text: tags[index],
                    value: index,
                    selected: selectedStatus[index],
                    color: colors[index],
                    onPressed: () {
                      setState(() {
                        if (!selectedStatus[index]) {
                          selectedTags[index] = tags[index];
                          selectedStatus[index] = true;
                          colors[index] = ColorPalette.lightBlue_400;
                        } else {
                          selectedTags[index] = '';
                          selectedStatus[index] = false;
                          colors[index] = ColorPalette.black;
                        }
                        buildTagsToSend();
                      });
                    },
                  );
                },
              ),
            ),
            Flexible(
              child: Container(
                child: CompetitionList(keyword: keyword, tags: tagsToSend),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String text;
  final int value;
  final bool selected;
  final Function onPressed;
  final Color color;

  CategoryItem(
      {this.text, this.value, this.selected, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: color),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
