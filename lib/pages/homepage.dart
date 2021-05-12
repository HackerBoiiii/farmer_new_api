import 'package:flutter/material.dart';

import '../models/newsInfo.dart';
import '../services/api_manager.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Welcome> _newsModel;
  @override
  void initState() {
    _newsModel = API_Manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(floatingActionButton: FloatingActionButton(
      onPressed:() =>print(_newsModel)
    ),
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LUGAR DE ENTERGA',
              softWrap: true,
              style: TextStyle(fontSize: size.height / 50),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'B-12 TOURCHTHERTEEN,',
              style: TextStyle(fontSize: size.height / 50),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'SEC-15 PARTUGAL,',
              softWrap: true,
              style: TextStyle(fontSize: size.height / 50),
            ),
          ],
        ),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.waves,
                size: 45,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ],
        ),
        toolbarHeight: 110,
        backgroundColor: Color(0xff5DB674),
        actions: [
          Icon(
            Icons.search,
            size: 45,
          ),
          Icon(
            Icons.shopping_cart,
            size: 45,
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<Welcome>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index){
                    var article = snapshot.data.data[index];
                    var detail=snapshot.data.data[index].cdata;
                    print(snapshot.data.data[index].cdata);
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  article.cImg,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(
                                  article.category,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  article.cdesc,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
