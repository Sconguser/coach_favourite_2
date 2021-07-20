import 'package:coach_favourite/shared/divider.dart';
import 'package:flutter/material.dart';
import 'package:coach_favourite/shared/constants.dart';
import 'dart:convert';
import 'package:coach_favourite/services/report_provider.dart';
import 'package:provider/provider.dart';
import 'package:coach_favourite/services/authorization.dart';
import 'package:coach_favourite/services/coach_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'loading.dart';

class CreateReport extends StatefulWidget {
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  List<XFile?> imageFile = [null, null, null];

  _openGallery(BuildContext context, int index) async {
    final image = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    this.setState(() {
      imageFile[index] = image;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context, int index) async {
    final image = (await ImagePicker().pickImage(source: ImageSource.camera))!;
    this.setState(() {
      imageFile[index] = image;
    });
    Navigator.of(context).pop();
  }

  _changePhoto(BuildContext context, int index, ImageSource source) async {
    final image = (await ImagePicker().pickImage(source: source))!;
    this.setState(() {
      imageFile[index] = image;
    });
    Navigator.of(context).pop();
  }

  Future<void> _cropImage(int index) async {
    File? cropped = await ImageCropper.cropImage(
        sourcePath: (imageFile[index]!.path),
        androidUiSettings:
            AndroidUiSettings(toolbarColor: greyo, toolbarWidgetColor: orango));
    if (cropped != null) {
      setState(() {
        imageFile[index] = XFile(cropped.path);
        Navigator.pop(context);
      });
    }
  }

  Future<void> _showImageDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: [
              Dialog(
                  child: Container(
                width: 500,
                height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(imageFile[index]!.path)),
                      fit: BoxFit.cover),
                ),
              )),
              ButtonBar(

                  children: [

                Material(
                    shape: CircleBorder(),
                    child: IconButton(
                        onPressed: () {
                          _cropImage(index);
                        },
                        icon: Icon(
                          Icons.crop,
                          color: orango,
                          size: 30,
                        ))),
                Material(
                    shape: CircleBorder(),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            imageFile[index] = null;
                          });
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          color:orango,
                          size: 30,
                        ))),
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
          );
        });
  }

  Future<void> _showChoiceDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add an image',
                textAlign: TextAlign.center, style: titleFont),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  MySmallDivider(),
                  SizedBox(height: 30),
                  GestureDetector(
                    child: Text('Gallery',
                        textAlign: TextAlign.center, style: titleFont),
                    onTap: () {
                      _changePhoto(context, index, ImageSource.gallery);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  GestureDetector(
                      child: Text('Camera',
                          textAlign: TextAlign.center, style: titleFont),
                      onTap: () {
                        _changePhoto(context, index, ImageSource.camera);
                      })
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView(int index) {
    if (imageFile[index] == null) {
      return Card(
          child: Image.asset(
        'assets/images/add_orango.png',
        height: 50,
        width: 50,
      ));
    } else {
      return Card(
          child: Image.file(File(imageFile[index]!.path),
              height: 300, width: 300));
    }
  }

  bool isVisibleLoading = false;
  final _formKey = GlobalKey<FormState>();
  double calf = 0;
  double hips = 0;
  double belly = 0;
  double waist = 0;
  double chest = 0;
  double biceps = 0;
  double weight = 0;
  double height = 0;
  String dietOpinion = '';
  String workoutOpinion = '';

  @override
  Widget build(BuildContext context) {
    var reportProvider = Provider.of<ReportProvider>(context, listen: false);
    var auth = Provider.of<AuthorizationProvider>(context, listen: false);
    var coaches = Provider.of<CoachProvider>(context, listen: false);
    return isVisibleLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20),
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Calf size in cm'),
                          onChanged: (value) {
                            setState(() {
                              calf = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Hips size in cm'),
                          onChanged: (value) {
                            setState(() {
                              hips = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Belly size in cm'),
                          onChanged: (value) {
                            setState(() {
                              belly = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Waist size in cm'),
                          onChanged: (value) {
                            setState(() {
                              waist = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Chest size in cm'),
                          onChanged: (value) {
                            setState(() {
                              chest = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Biceps size in cm'),
                          onChanged: (value) {
                            setState(() {
                              biceps = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Height in cm'),
                          onChanged: (value) {
                            setState(() {
                              height = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Weight in kg'),
                          onChanged: (value) {
                            setState(() {
                              weight = double.parse(value);
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          minLines: 1,
                          maxLines: null,
                          style: TextStyle(fontSize: 20),
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Opinion on your diet'),
                          onChanged: (value) {
                            setState(() {
                              dietOpinion = value;
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          minLines: 1,
                          maxLines: null,
                          style: TextStyle(fontSize: 20),
                          decoration: signInInputDecoration.copyWith(
                              hintText: 'Opinion on your workout'),
                          onChanged: (value) {
                            setState(() {
                              workoutOpinion = value;
                            });
                          }),
                      SizedBox(height: 20),
                      Text(
                        'Add photos',
                        style: TextStyle(
                          fontSize: 30,
                          color: orango,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      MySmallDivider(),
                      SizedBox(height: 50),
                      Center(
                        child: Wrap(children: [
                          for (int i = 0; i < 3; i++)
                            Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: _decideImageView(i),
                                      onTap: () {
                                        imageFile[i] == null
                                            ? _showChoiceDialog(context, i)
                                            : _showImageDialog(context, i);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20)
                              ],
                            ),
                        ]),
                      ),
                      OutlinedButton(
                          onPressed: () async {
                            setState(() {
                              isVisibleLoading = true;
                            });
                            int reportId = await reportProvider.createReport(
                                auth.user.bearerToken,
                                auth.user.id,
                                calf,
                                hips,
                                belly,
                                waist,
                                chest,
                                biceps,
                                weight,
                                height,
                                dietOpinion,
                                workoutOpinion);
                            if (reportId == -1) {
                              print('nie udalo sie'); ///// do dodania error!!!1
                            } else {
                              isVisibleLoading = false;
                              await coaches.getCoaches(auth.user.bearerToken);
                              await Navigator.pushNamed(
                                  context, '/select_coaches');
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Create a report!',
                              style: titleFont.copyWith(fontSize: 20)))
                    ],
                  ),
                ),
              ),
            ));
  }
}
