import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb/BloC/imdb_bloc.dart';
import 'package:imdb/Ui/details.dart';

import '../Repository/ModelClass/IMDbModel.dart';
import 'Home.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

late ImDbModel data;

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<ImdbBloc>(context).add(FetchImdb());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ImdbBloc, ImdbState>(builder: (context, state) {
        if (state is ImdbBlocLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ImdbBlocError) {
          return Center(child: Text('something else !!'));
        }
        if (state is ImdbBlocLoaded) {
          data = BlocProvider.of<ImdbBloc>(context).imDbModel;
          return Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Details(img:data.image.toString() ,)));
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      data.image.toString(),
                      height: 150,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 220,
                            child: Text(
                              data.title.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Row(
                          children: [
                            Text(
                              'Director :  ',
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                            ),
                            Text(
                              data.director.toString(),
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey[800]),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              'Rating :  ',
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              data.rating.toString(),
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Year :  ',
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              data.year.toString(),
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
