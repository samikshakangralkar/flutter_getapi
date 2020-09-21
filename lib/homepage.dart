import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'models/data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<List<Data>> getAllData() async {
    var api = 'http://jsonplaceholder.typicode.com/photos';
    var data = await http.get(api);

    var jsondata = json.decode(data.body);

    List<Data>Listof = [];

    for (var i in jsondata){

      Data data = new Data(i['id'], i['title'], i['url'], i['thumbnailUrl']);
      Listof.add(data);



  }
    return Listof;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('json parsing app'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(icon: Icon(Icons.search),
              onPressed: ()=> debugPrint('search')
          ),
          IconButton(icon: Icon(Icons.account_circle),
          onPressed: ()=> debugPrint('google account')
          )
        ]
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text('code with netzary',style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal

            ),),
                accountEmail: Text('netzary@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.deepOrange
              ),
            ),
            ListTile(
               title: Text('service page',style: TextStyle(
                 fontSize: 18,fontWeight: FontWeight.w300


               ),
               ),
              leading: Icon(Icons.search,color: Colors.deepOrangeAccent,),
              onTap: () {
                 Navigator.of(context).pop();
              },

            ),
            ListTile(
              title: Text('Media and news reconization',style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w300
              ),),
              leading: Icon(Icons.card_travel,color: Colors.deepOrangeAccent,),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Testimonials',style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w300
              ),),
              leading: Icon(Icons.speaker_notes,color: Colors.deepOrangeAccent,),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Patnership',style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w300
              ),),
              leading: Icon(Icons.accessibility,color: Colors.deepOrangeAccent,),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Certifications', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w300

              ),),
              leading: Icon(Icons.ac_unit,color: Colors.deepOrangeAccent,),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),

            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text('Close',style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w300
              ),),
              leading: Icon(Icons.close,color: Colors.deepOrangeAccent,),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),

      ),

      body: ListView(
        children: [
          Container(
            height: 250.0,
          margin: EdgeInsets.all(10.0),

            child: FutureBuilder(
              future: getAllData(),
              builder: (BuildContext c,AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text('Loading data...'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext c, int index){
                      return Card(
                        elevation: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(snapshot.data[index].url,
                            height: 150.0,
                            width: 150.0,
                            fit: BoxFit.cover,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              margin: EdgeInsets.all(6.0),
                              height: 50.0,

                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.redAccent,
                                      radius: 25.0,
                                      child: Text(snapshot.data[index].id.toString(),style: TextStyle(
                                        color: Colors.yellow
                                      ),
                                      ),
                                    ),

                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Container(
                                    width: 60.0,
                                    child: Text(snapshot.data[index].title,maxLines: 1, style: TextStyle(
                                      fontSize: 18,fontWeight: FontWeight.w300,color: Colors.deepOrangeAccent
                                    ),),

                                  )


                                ],
                              ),
                            )
                          ],
                        ),
                      );


                      }
                  );
                }
              }



            )
            ),
          SizedBox(height: 7.0,),
          Container(
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: getAllData(),
                builder: (BuildContext c,AsyncSnapshot snapshot){
                return ListView.builder(
                    itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext c, int index){
                      return Card(
                        elevation: 10.0,
                        child: Container(
                          height: 80.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start ,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  snapshot.data[index].thumbnailUrl,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 6.0,),
                              Expanded(

                              flex: 2,
                              child: Text(
                                  snapshot.data[index].title, maxLines: 2,
                                style: TextStyle(
                                fontStyle: FontStyle.normal,fontWeight: FontWeight.w400,
                                    fontSize: 15

                              ),

                              ),

                              ),
                               Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,

                                  child: CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    radius: 20.0,
                                    child: Text(snapshot.data[index].id.toString(),style: TextStyle(
                                        color: Colors.yellow
                                    ),
                                    ),
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),


                      );
                  }
                );
                  }
                )

            )

        ],
      ),
    );
  }
}
