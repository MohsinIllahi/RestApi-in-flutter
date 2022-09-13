import 'dart:convert';

import 'package:apitutorial/Models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LastExampleScreen extends StatefulWidget {
  const LastExampleScreen({Key? key}) : super(key: key);

  @override
  State<LastExampleScreen> createState() => _LastExampleScreenState();
}

class _LastExampleScreenState extends State<LastExampleScreen> {

  Future<ProductsModel> getProductsApi() async{
    final response = await http.get(Uri.parse('https://webhook.site/1152d4e2-feee-4fae-bfa0-03619bb6544c'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    } else{
      return ProductsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Course'),

      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder<ProductsModel>(
            future: getProductsApi(),
            builder: (context,  snapshot){
             if(snapshot.hasData){
               return ListView.builder(
                   itemCount: snapshot.data!.data!.length,
                   itemBuilder: (context, index){
                     return Column(
                       children: [
                         Container(
                             height: MediaQuery.of(context).size.height* .3,
                             width: MediaQuery.of(context).size.width*.2,
                             child: ListView.builder(
                               itemCount: snapshot.data!.data![index].image!.length,
                                 itemBuilder: (context, position){
                                   return Container(
                                     height: MediaQuery.of(context).size.height* .3,
                                     width: MediaQuery.of(context).size.width* .1,
                                     decoration: BoxDecoration(
                                       color: Colors.blue,
                                       image: DecorationImage(
 image: NetworkImage(snapshot.data!.data![index].image!.toString()),
                                       )
                                     ),

                                   );
                                 }
                             ),
                           ),

                       ],
                     );
                   });
             }else{
               return Text('Loading');
             }
            },
          )),
        ],
      ),
    );
  }
}
