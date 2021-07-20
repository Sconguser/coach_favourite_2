import 'package:coach_favourite/services/mentee_provider.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'package:coach_favourite/shared/divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/report_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:coach_favourite/models/firebase_file.dart';

import 'loading.dart';


class ReportDetail extends StatefulWidget {
  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {

  List<FirebaseFile> pics = [];
  List<String>names = ['Calf', 'Hips', 'Belly', 'Waist', 'Chest', 'Biceps', 'Weight', 'Height', 'Diet opinion', 'Workout opinion'];
  List<String>urlNames = ['calf', 'hips','belly','waist','chest','biceps','weight','height','dietOpinion', 'workoutOpinion'];

  bool isVisibleLoading = false;
  @override

  void initState(){
    super.initState();
    String path = '${Provider.of<MenteeProvider>(context,listen:false).focusedMentee.id}/${Provider.of<ReportProvider>(context,listen:false).focusedReport.id}';
    _loadPhotos(path);
  }
  Future<Null>_loadPhotos(String path)async{
    setState(() {
      isVisibleLoading=true;
    });
    List<FirebaseFile> list = await listAll(path);
    setState(() {
      isVisibleLoading = false;
      pics = list;
    });
  }
  Future<List<FirebaseFile>>listAll(String path)async{
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);
    return urls
        .asMap()
        .map((index,url) {
      final ref = result.items[index];
      final name = ref.name;
      final file = FirebaseFile(ref:ref, name:name, url:url);
      return MapEntry(index, file);
    }
    ).values.toList();
  }
  Future<List<String>>_getDownloadLinks(List<Reference>refs){
    return Future.wait(refs.map((ref)=>ref.getDownloadURL()).toList());
  }


  Future<void> _showImageDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              children: [
                Dialog(
                    child: Container(
                      width: 500,
                      height: 680,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(pics[index].url),
                            fit: BoxFit.cover),
                      ),
                    )),
                ButtonBar(

                    children: [
                      Material(
                          shape: CircleBorder(),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.check,
                                color: orango,
                                size: 30,
                              ))),
                    ]
                )
              ],
            ),
          );
        });
  }

  Widget _decideView(int index){
    if(index >= pics.length) return SizedBox(height:0);
    else return SizedBox(
      width: 200,
      height: 150,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Card(
            child: Image.network(pics[index].url,height:200,width: 150,),
          ),
          onTap:(){_showImageDialog(context,index);}
        ),
      ),
    );
  }


  Widget build(BuildContext context) {
    ReportProvider reportProvider = Provider.of<ReportProvider>(context,listen:false);

    return isVisibleLoading? Loading():Scaffold(
        appBar: AppBar(
        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
          children: [
            ListTile(
              trailing: Text(reportProvider.focusedReport.date.toString(), style: titleFont3.copyWith(fontSize:25)),
            ),
            MySmallDivider(),
            ListTile(
              title:Text('Calf', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.calf.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            ListTile(
              title:Text('Hips', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.hips.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            ListTile(
              title:Text('Belly', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.belly.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            ListTile(
              title:Text('Waist', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.waist.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            ListTile(
              title:Text('Chest', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.chest.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            ListTile(
              title:Text('Biceps', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.biceps.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            ListTile(
              title:Text('Weight', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.weight.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            ListTile(
              title:Text('Height', style: titleFont3.copyWith(fontSize: 30),),
              trailing: Text(reportProvider.focusedReport.height.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            MySmallDivider(),
            ListTile(
              isThreeLine: true,
              title:Text('Diet opinion', style: titleFont3.copyWith(fontSize: 30),),
              subtitle: Text(reportProvider.focusedReport.dietOpinion.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            MySmallDivider(),
            ListTile(
              isThreeLine:true,
              title:Text('Workout opinion', style: titleFont3.copyWith(fontSize: 30),),
              subtitle: Text(reportProvider.focusedReport.workoutOpinion.toString(),
                  style: titleFont3.copyWith(fontSize:25)),
            ),
            MySmallDivider(),
            SizedBox(height:20),
            _decideView(0),
            _decideView(1),
            _decideView(2)
          ],
            ),
        )
    );
  }
  
}
