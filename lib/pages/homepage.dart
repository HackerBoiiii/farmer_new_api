import 'package:farmer_api_second/pages/detailview.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/newsInfo.dart';
import '../services/api_manager.dart';
import 'package:expandable/expandable.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailView(),
              ))),
      drawer: Drawer(child: Center(child: Text('Cynoteck pvt. Limited'))),
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
        toolbarHeight: 75,
        backgroundColor: Color(0xff5DB674),
        actions: [
          Icon(
            Icons.search_outlined,
            size: 40,
          ),
          Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              width: 60,
              child: Image.asset(
                'lib/assets/images/cart.png',
                fit: BoxFit.contain,
                color: Colors.white,
                height: 10,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<Welcome>(
                future: _newsModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var article = snapshot.data.data;
                    var fruits=snapshot.data.data[0].cdata;
                    var vegetables=snapshot.data.data[1].cdata;
                    return Column(
                      children: [
                        Container(
                          color: Colors.green,
                          child: CarouselSlider(
                            options: CarouselOptions(height: 150.0),
                            items: [1, 2, 3, 4].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            child: Container(
                                                height: 140,
                                                color: Colors.green,
                                                width: size.width,
                                                child: Image.network(
                                                  snapshot.data.data[i].cImg,
                                                  fit: BoxFit.fill,
                                                )),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          Center(
                                            child: Text(
                                              snapshot.data.data[i].category,
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.deepOrange,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ));
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          child: Container(
                            width: size.width / 2.5,
                            height: 35,
                            color: Colors.green,
                            child: Center(
                                child: Text(
                              'Category',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                          ),
                        ),
                  ExpandablePanel(
                  header: Text('Fruits',style: TextStyle(
                  fontSize: 18
                  ),),
                  expanded: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,childAspectRatio: 1,crossAxisSpacing: 20),
                    itemBuilder: (context, index) =>
                        GridTile(
                          child: Image.network(fruits[index].image),
                          footer: GridTileBar(

                            backgroundColor: Colors.black12,

                            trailing: Icon(Icons.add_shopping_cart,color: Colors.blueAccent,),
                            title: Text('₹'+'${fruits[index].costPrice}',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.blueAccent,
                            ),),
                          ),
                        ),
                    itemCount: 6,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),

                  ),
                       SizedBox(
                         height: 10,
                       ),
                        ExpandablePanel(
                          header: Text('Vegetables'),
                          expanded: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,childAspectRatio: 1,crossAxisSpacing: 20),
                            itemBuilder: (context, index) =>
                                GridTile(
                                  child: Image.network(vegetables[index].image,height: 50,width: 50,),
                                  footer: GridTileBar(
                                    backgroundColor: Colors.black12,
                                    leading: Icon(Icons.favorite_border,color: Colors.red,),
                                    trailing: Icon(Icons.add_shopping_cart,color: Colors.blueAccent,),
                                    title: Text(vegetables[index].costPrice,textAlign: TextAlign.center,style: TextStyle(
                                        color: Colors.blueAccent
                                    ),),
                                  ),
                                ),
                            itemCount: 6,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                          ),

                        )
                      ],
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
