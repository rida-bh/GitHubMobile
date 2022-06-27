import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:git_hub_mobile_app/UI/pages/repositories/gitrepositories.page.dart';
import 'package:http/http.dart' as http;
class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController queryTextEditingController =new TextEditingController();
  bool notVisible=false;
  String query="";
  dynamic data =null;
  int currentPage=0;
  int totalPages=0;
  int pageSize=20;
  List<dynamic> items =[];
  ScrollController scrollcontroller=ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollcontroller.addListener(() {
      if(scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent){
        setState((){
          if(currentPage<totalPages-1){
            ++currentPage;
            _search(query);
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users => ${query} =>${currentPage}/${totalPages}')),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: notVisible,
                      onChanged: (value){
                        setState((){
                          this.query=value;
                        });
                      },
                        controller: queryTextEditingController,
                        decoration: InputDecoration(
                          //icon: Icon(Icons.logout),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  notVisible==true?Icons.visibility_off:Icons.visibility),
                              onPressed: (){
                                setState((){
                                  notVisible=!notVisible;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1,color: Colors.deepOrange
                                )
                            )
                        )
                    )
                )
                ),
                IconButton(
                    onPressed: (){
                      setState((){
                        items=[];
                        currentPage=0;
                        this.query=queryTextEditingController.text;
                        _search(query);
                      });
                    },
                    icon: Icon(Icons.search,color: Colors.deepOrange,)
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => 
                    Divider(height: 2,color: Colors.deepOrange,),
                controller: scrollcontroller,
                  itemBuilder:(context,index){
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => GitRepositoriesPage(
                                login: items[index]['login'],
                                avatarUrl:items[index]['avatar_url'])
                        )
                        );
                      },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(items[index]['avatar_url']),
                                  radius: 40,
                                ),
                                SizedBox(width: 20,),
                                Text("${items[index]['login']}"),

                              ],
                            ),
                            CircleAvatar(
                              child: Text("${items[index]['score']}"),
                            )
                          ],
                        )
                    );
                  },
                itemCount:items.length
              ),
            )
          ],
        ),
      ),
    );
  }

  void _search(String query) {
    String url ="https://api.github.com/search/users?q=${query}&per_page=${pageSize}&page=${currentPage}";
    print(url);
      http.get(Uri.parse(url))
          .then((response){
            setState((){
              this.data=json.decode(response.body);
              this.items.addAll(data['items']);
              if(data['total_count'] % pageSize ==0)
                totalPages=data['total_count']~/pageSize;
              else{
                totalPages=(data['total_count']~/pageSize).floor()+1;
              }
            });
          }).catchError((err){
         print(err);
      });
  }
}