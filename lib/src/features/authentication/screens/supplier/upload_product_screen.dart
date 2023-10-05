import 'dart:io';

import 'package:cashback/src/common_widgets/form/auth_widget.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

List<String> categ = [
  'selectionner categorie',
  'hommes',
  'femmes',
  'enfants',
];

List<String> hommes = [
  'montre',
  'chaussure',
  /*
  't-shirt',
  'hoddies',
  'sweater',
  'sweatshirt',
  'jeans',
  'shorts',
  'jacket',
  'pants',
  'socks',
  'suit',
  'underwear',
  'sac',
  'bijoux',
  'ceinture',
  'chapeau',
  'lunette',
  'parfum',*/
];

List<String> femmes = [
  'bijoux',
  'ceinture',
  'chapeau',
  'lunette',
  'sac',
  /*
  'dress',
  'sets',
  't-shirt',
  'top',
  'skirt',
  'jeans',
  'pants',
  'coat',
  'jacket',
  'sweater',
  'sweatshirt',
  'shorts',
  'socks',
  'suit',
  'underwear',
  'sac',
  'montre',
  'bijoux',
  'ceinture',
  'chapeau',
  'lunette',
  'parfum',*/
];

List<String> enfants = [
  'hoodies',
  't-shirt',
  'jeans',
  'pants',
  'jacket',
  'shorts',
  'socks',
  'suit',
  'underwear',
  'dress',
  'sets',
  'top',
  'skirt',
  'coat',
  'sweater',
  'sweatshirt',
  'shoes',
];

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
  late String _proName;
  late String _proMarketDesc;
  late String _proDescription;
  late String _proLabel;
  String mainCategValue = 'hommes';
  String subCategValue = 'montre';
  List<String> subCategList = [];

  /*
  String mainCategValue         = 'choix categorie';
  String subCategValue          = 'sous-categorie';
  List<String> subCategList     = [];*/

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imagesFileList = [];
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
            icon: const Icon(
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
            style: Theme
                .of(context)
                .textTheme
                .labelLarge!
                .copyWith(),
          ),
        ],
      );
    }
  }

  /*
  selectedMainCateg(String ? value) {
    if (value == 'selectionner categorie') {
      subCategList = [];
    }
    else if (value == 'hommes') {
      subCategList = hommes;
    }
    else if (value == 'femmes') {
      subCategList = femmes;
    }
    else if (value == 'enfants') {
      subCategList = enfants;
    }
    else if (value == 'electroniques') {
      subCategList = electroniques;
    }
    else if (value == 'accessoires') {
      subCategList = accessoires;
    }
    else if (value == 'maison & jardin') {
      subCategList = maisonetjardin;
    }
    else if (value == 'automobiles') {
      subCategList = accessoires;
    }
    else if (value == 'sports & loisirs') {
      subCategList = sportsetloisirs;
    }
    else if (value == 'autres') {
      subCategList = autres;
    }
    print(value);
    setState(() {
      //_proLabel = value.toString();
      //maincategValue = value.toString();
      mainCategValue = value!;
      subCategValue = 'sous-catégorie';
    });

  }*/

  //function to upload product information to firebase
  void uploadProduct() {
    // if (mainCategValue!= 'choix categorie' && subCategValue!= 'sous-catégorie') {
    //upload product information to firebase
    //upload product images to firebase
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_imagesFileList!.isNotEmpty) {
        //upload product information to firebase
        setState(() {
          _imagesFileList = [];
          /*
            mainCategValue = 'choix categorie';
            subCategValue = 'sous-catégorie';*/
        });
        _formKey.currentState!.reset();
      } else {
        MyMessageHandler.showSnackBar(
            _scaffoldkey, 'Veuillez joindre une image');
      }
    } else {
      MyMessageHandler.showSnackBar(
          _scaffoldkey, 'Veuillez remplir toutes les champs');
    } /*
    }
    else {
      MyMessageHandler.showSnackBar(
          _scaffoldkey, 'Veuillez joindre une catégories ou sous-catégorie'
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

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
                                style: Theme
                                    .of(context)
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
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const Text('choix catégorie'),
                                  DropdownButton(
                                      value: mainCategValue,
                                      items: categ.map<DropdownMenuItem<String>>((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        if (value == 'selectionner categorie') {
                                          subCategList = [];
                                        }
                                        else if (value == 'hommes') {
                                          setState(() {
                                            subCategValue = 'montre';
                                          });
                                          subCategList = hommes;
                                        }
                                        else if (value == 'femmes') {
                                          setState(() {
                                            subCategValue = 'bijoux';
                                          });
                                          subCategList = femmes;
                                        }
                                        else if (value == 'enfants') {
                                          setState(() {
                                            subCategValue = 'hoodies';
                                          });
                                          subCategList = enfants;
                                        }
                                        print(value);
                                        setState(() {
                                          mainCategValue = value!;
                                        });
                                      })
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('choix sous-catégorie'),
                                  DropdownButton(
                                      value: subCategValue,
                                      items: subCategList.map<DropdownMenuItem<String>>((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
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
                          const TextInputType.numberWithOptions(decimal: true),
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

                    //categorie
                    TextFieldDecoration(
                      label: 'Categorie',
                      hintLabel: 'saisir categorie de l\'article',
                      emptyFieldError: 'saisir la categorie',
                      textType: TextInputType.text,
                      onPressed: () {},
                      obscureText: false,
                      onChanged: (value) {},
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
              onPressed: () {
                uploadProduct();
              },
              backgroundColor: CbColors.cbPrimaryColor2,
              child: const Icon(Icons.upload),
              //backgroundColor: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
