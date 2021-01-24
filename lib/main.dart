import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/myBloc.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (_) => MyCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SamplePage(),
      ),
    );
  }
}
class SamplePage extends StatefulWidget{
  @override
  _SamplePageState createState() => _SamplePageState();
}
class _SamplePageState extends State<SamplePage>{
  List<Widget> _samplePages = [
    Center(
      child: Text('Page 1'),
    ),
    Center(child: Text('Page 2')),
    Center(child: Text('Page 3')),
    Center(child: Text('Page 4')),
  ];
  final _controller = new PageController();
  static const _duration = const Duration(milliseconds: 300);
  static const _curve = Curves.ease;
  double currentPage = 1;
  
  @override 
  void initState() {
    // TODO: implement initState
    _controller.addListener(() { 
      setState(() {
        currentPage += _controller.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyCubit,int>(
        builder: (context, value){
          return SafeArea(child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(_samplePages.length,value),
                ),
              ),
              Flexible(child: PageView.builder(onPageChanged: (page){
                context.read<MyCubit>().changePage(page);
              },),),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(onPressed: (){
                      _controller.nextPage(duration: _duration, curve: _curve);
                    },
                        color: Colors.orange,
                        child: Text('Next'))
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          );
        },
      ),
    );
  }
  List<Widget> _buildIndicator(length,value){
    List<Widget> indicators = [];
    for(int i = 0;i<length;i++){
      if(value==i){
        indicators.add(_indicator(true));
      }else{
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
  Widget _indicator(bool isActive){
    return AnimatedContainer(duration: Duration(milliseconds: 300),
      height: 6,
      width: 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: isActive ? Colors.green: Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

}