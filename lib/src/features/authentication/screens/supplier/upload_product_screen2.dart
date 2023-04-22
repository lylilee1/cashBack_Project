import 'dart:io';

import 'package:cashback/src/common_widgets/form/auth_widget.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/categoryData.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class UploadProductsScreen extends StatefulWidget {
  const UploadProductsScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductsScreen> createState() => _UploadProductsScreenState();
}

class _UploadProductsScreenState extends State<UploadProductsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();

  late double _price;
  late int _quantity;
  String? _proName, _proBrand, _proModel, _proColor, _proSize,_proMarketDesc, _proDescription;
  late String _proLabel;
  String mainCategValue = 'choix categorie';
  String subCategValue = 'sous categorie';
  List<String> subCategList = [];
  bool processing = false;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imagesFileList = [];
  List<String>? _imagesUrlList = [];
  dynamic _pickedImageError;

  //function to pick image from gallery
  void _pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxWidth: 300, maxHeight: 300, imageQuality: 95);

      setState(() {
        _imagesFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (_imagesFileList!.isNotEmpty) {
      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _imagesFileList!.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: CbColors.cbPrimaryColor2,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(File(_imagesFileList![index].path)),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*
          Image.asset('assets/images/add-video-2969396.png',
              width: MediaQuery.of(context).size.width * 0.4),*/

          IconButton(
            onPressed: () {
              _pickProductImages();
            },
            icon: Icon(
              Icons.add_to_photos_rounded,
              color: Colors.black,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'aucune images selectionnée'.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(),
          ),
        ],
      );
    }
  }

  void selectedMainCateg(String? value) {
    if (value == 'choix categorie') {
      subCategList = [];
    } else if (value == 'hommes') {
      subCategList = hommes;
    } else if (value == 'femmes') {
      subCategList = femmes;
    } else if (value == 'enfants') {
      subCategList = enfants;
    } else if (value == 'electroniques') {
      subCategList = electroniques;
    } else if (value == 'accessoires') {
      subCategList = accessoires;
    } else if (value == 'maison & jardin') {
      subCategList = maisonetjardin;
    } else if (value == 'sport & loisirs') {
      subCategList = sportetloisirs;
    } else if (value == 'automobiles') {
      subCategList = automobiles;
    }
    /*
    else if(value == 'beaute & sante'){
      subCategList = beauteetsante;
    }
    else if(value == 'immobilier'){
      subCategList = immobilier;
    }
    else if(value == 'emploi'){
      subCategList = emploi;
    }
    else if(value == 'services'){
      subCategList = services;
    }*/
    else if (value == 'autres') {
      subCategList = autres;
    }

    print(value);
    setState(() {
      mainCategValue = value!;
      subCategValue = 'sous categorie';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'choix categorie' &&
        subCategValue != 'sous catégorie') {
      //upload product information to firebase
      //upload product images to firebase
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (_imagesFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          //upload product information to firebase
          try {
            for (var image in _imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${Path.basename(image.path)}');

              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  //print(value);
                  _imagesUrlList?.add(value);
                });
              })/*.catchError((onError) {
                print(onError);
              })*/;
            }
          } catch (e) {
            print(e);
            //MyMessageHandler.showSnackBar(_scaffoldkey, e.toString());
          }
        } else {
          MyMessageHandler.showSnackBar(
              _scaffoldkey, 'Veuillez joindre une image');
        }
      } else {
        MyMessageHandler.showSnackBar(
            _scaffoldkey, 'Veuillez remplir toutes les champs');
      }
    } else {
      MyMessageHandler.showSnackBar(
          _scaffoldkey, 'Veuillez joindre une catégories ou sous-catégorie');
    }
  }

  void uploadData() async {
    if (_imagesUrlList!.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');

      await productRef.doc().set({
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'price': _price,
        'discount': 0,
        'instock': _quantity!,
        'proname': _proName!,
        'prodesc': _proDescription!,
        'promarketing': _proMarketDesc,
        'probrand': _proBrand,
        'promodel': _proModel,
        'procolor': _proColor,
        'prosize': _proSize,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': _imagesUrlList,
        'prodate': DateTime.now(),
        'prostatus': 'en attente',
        'proviews': 0,
        'prolikes': 0,
        'prodislikes': 0,
        'procomments': 0,
        'proshares': 0,
        'prosold': 0,
        'prosoldprice': 0,
        'prosolddate': DateTime.now(),
      }).whenComplete(() {
        setState(() {
          _imagesFileList = [];
          mainCategValue = 'choix categorie';

          subCategList = [];
          _imagesUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    }
    else {
      MyMessageHandler.showSnackBar(_scaffoldkey, 'no images'); //'Veuillez joindre une image'
    }

    /*
    if (_imagesUrlList.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');

      await productRef.doc().set({
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'price': _price,
        'discount': 0,
        'instock': _quantity,
        'proname': _proName,
        'prodesc': _proDescription,
        'promarketing': _proMarketDesc,
        'probrand': _proBrand,
        'promodel': _proModel,
        'procolor': _proColor,
        'prosize': _proSize,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': _imagesUrlList,
        'prodate': DateTime.now(),
        'prostatus': 'en attente',
        'proviews': 0,
        'prolikes': 0,
        'prodislikes': 0,
        'procomments': 0,
        'proshares': 0,
        'prosold': 0,
        'prosoldprice': 0,
        'prosolddate': DateTime.now(),
      }).whenComplete(() {
        setState(() {
          processing = false;
          _imagesFileList = [];

          mainCategValue = 'choix categorie';
          subCategList = [];
          _imagesUrlList = [];
        });
        _formKey.currentState!.reset();
      });

      /*
      try{
        await FirebaseFirestore.instance.collection('products').add({
          'name': _productName,
          'description': _productDescription,
          'price': _productPrice,
          'category': mainCategValue,
          'subCategory': subCategValue,
          'images': _imagesUrlList,
          'date': DateTime.now(),
          'userId': _auth.currentUser!.uid,
          'userName': _auth.currentUser!.displayName,
          'userEmail': _auth.currentUser!.email,
          'userPhone': _auth.currentUser!.phoneNumber,
          'userPhoto': _auth.currentUser!.photoURL,
        }).then((value) {
          MyMessageHandler.showSnackBar(_scaffoldkey, 'produit ajouté avec succès');
          setState(() {
            _imagesUrlList = [];
          });
        });
      }catch(e){
        print(e);
      }*/
    } else {
      MyMessageHandler.showSnackBar(_scaffoldkey, 'aucune image chargée');
    }*/
  }

  //function to upload product information to firebase
  void uploadProduct() async  {
    await uploadImages().whenComplete(() =>
      uploadData()
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ScaffoldMessenger(
      key: _scaffoldkey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Upload Products'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: width * 0.4,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: _imagesFileList != null
                              ? previewImages()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Upload Product Image',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: width * 0.4,
                          width: width * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    'choix catégorie',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  DropdownButton(
                                      menuMaxHeight: 500,
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      dropdownColor: CbColors.cbPrimaryColor2,
                                      value: mainCategValue,
                                      items: maincateg
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        selectedMainCateg(value);
                                      })
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'choix sous-catégorie',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  DropdownButton(
                                      menuMaxHeight: 500,
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      dropdownColor: CbColors.cbPrimaryColor2,
                                      iconDisabledColor: Colors.black,
                                      disabledHint:
                                          const Text('choix catégorie'),
                                      value: subCategValue,
                                      items: subCategList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        print(value);
                                        setState(() {
                                          subCategValue = value!;
                                        });
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //prix
                        TextFieldDecoration2(
                          width: width,
                          label: 'Prix',
                          hintLabel: 'Ajouter prix',
                          emptyFieldError: 'Saisir le prix du produit',
                          textType:
                              TextInputType.numberWithOptions(decimal: true),
                          iconImage: Icons.attach_money,
                          iconImage2: Icons.attach_money,
                          //onPressed: () {},
                          obscureText: false,
                          onChanged: (value) {
                            _price = double.parse(value!);
                          },
                        ),

                        //quantité
                        TextFieldDecoration2(
                          width: width,
                          label: 'Quantité',
                          hintLabel: 'Ajouter quantité',
                          emptyFieldError: 'Saisir la quantité du produit',
                          textType: TextInputType.number,
                          //onPressed: () {},
                          obscureText: false,
                          onChanged: (value) {
                            _quantity = int.parse(value!);
                          },
                        ),
                      ],
                    ),

                    //nom de l'article
                    TextFieldDecoration(
                      maxlength: 50,
                      maxlins: 2,
                      label: 'Nom de l\'article',
                      hintLabel: 'saisir nom de l\'article',
                      emptyFieldError: 'saisir le nom de l\'article',
                      textType: TextInputType.text,
                      onPressed: () {},
                      obscureText: false,
                      onChanged: (value) {
                        _proName = value!;
                      },
                    ),

                    //phrase d'accroche
                    TextFieldDecoration(
                      maxlength: 50,
                      maxlins: 2,
                      label: 'Phrase d\'accroche',
                      hintLabel: 'Saisir phrase d\'accroche',
                      emptyFieldError: 'saisir la phrase d\'accroche',
                      textType: TextInputType.text,
                      onPressed: () {},
                      obscureText: false,
                      onChanged: (value) {
                        _proMarketDesc = value!;
                      },
                    ),

                    //description
                    TextFieldDecoration(
                      maxlength: 100,
                      maxlins: 3,
                      label: 'Description',
                      hintLabel: 'saisir description de l\'article',
                      emptyFieldError: 'saisir la description',
                      textType: TextInputType.text,
                      onPressed: () {},
                      obscureText: false,
                      onChanged: (value) {
                        _proDescription = value!;
                      },
                    ),

                    //marque
                    TextFieldDecoration(
                      label: 'Marque',
                      hintLabel: 'saisir marque de l\'article',
                      emptyFieldError: 'saisir la marque',
                      textType: TextInputType.text,
                      onPressed: () {},
                      obscureText: false,
                      onChanged: (value) {
                        _proLabel = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                onPressed: _imagesFileList!.isEmpty
                    ? () {
                        _pickProductImages();
                      }
                    : () {
                        setState(() {
                          _imagesFileList = [];
                        });
                      },
                backgroundColor: CbColors.cbPrimaryColor2,
                child: _imagesFileList!.isEmpty
                    ? const Icon(Icons.add_a_photo_outlined)
                    : const Icon(Icons.delete),
                //backgroundColor: kPrimaryColor,
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              backgroundColor: CbColors.cbPrimaryColor2,
              child: processing == true
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : Icon(Icons.upload, color: Colors.black),
              //backgroundColor: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
