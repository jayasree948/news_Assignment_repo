// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List newsList = [{'title' : 'News1', 'desc' : 'Hello welcome to news+'},
{'title' : 'News2', 'desc' : 'Hello welcome to news2+'},
{'title' : 'News3', 'desc' : 'Hello welcome to news3+'}
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _search = TextEditingController();
  List items = [];

int count = 0;
bool fav = false;

    void filterSearchResults(String query) {
      List dummySearchList = [];
      newsList.map((element) {
        dummySearchList =
        element['title'];});
      if(query.isNotEmpty) {
        List<String> dummyListData = [];
        dummySearchList.forEach((item) {
          if(item.contains(query)) {
            dummyListData.add(item);
          }
        });
        setState(() {
          items.clear();
          items.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          items.clear();
          items.addAll(newsList);
        });
      }
    }


  countOfLikes() {
setState(() {
  count++;
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text('News'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) {
                filterSearchResults(val);
              },
              controller: _search,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search'
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
          itemCount: newsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index){
    return Card(
    margin: EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Row(
        children:  [
          Text('${newsList[index]['title']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        ],
      ),
      Row(
        children:  [
          Text('${newsList[index]['desc']}', style: TextStyle(fontWeight: FontWeight.w500),),
        ],
      ),
        Row(
          children: [
            TextButton.icon(
                onPressed: () { countOfLikes(); },
                icon: Icon(Icons.thumb_up_rounded),
            label:Text('$count')),

        IconButton(
            icon :Icon(fav == false ? Icons.favorite_border : Icons.favorite), onPressed: () { setState(() {
              if(fav == false) {
                fav = true;
      }else {
               fav = false;}
            }); },
        ),
          ],
        ),
      ],
      ),
    ),
    );
    }
          ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder:  (BuildContext context) => const AddNews()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Post')
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _title,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              labelText: 'Enter Title'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _desc,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Description'
              ),
            ),
          ),

          TextButton(onPressed: (){
            Navigator.of(context).pop(context);
            newsList.add({'title': _title.text, 'desc': _desc.text});

          }, child: Text('Submit'))
        ],
      ),
    );
  }
}