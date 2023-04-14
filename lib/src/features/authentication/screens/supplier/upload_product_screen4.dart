import 'dart:io';

import 'package:cashback/src/common_widgets/form/auth_widget.dart';
import 'package:cashback/src/common_widgets/snackBar/snackBarWidget.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductsScreen extends StatefulWidget {
  const UploadProductsScreen({Key? key}) : super(key: key);
  static String routeName = '/uploadProduct';

  @override
  State<UploadProductsScreen> createState() => _UploadProductsScreenState();
}

class _UploadProductsScreenState extends State<UploadProductsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldkey =
      GlobalKey<ScaffoldMessengerState>();

  late double _proWeight, _proSize, _price;
  late int _quantity;
  late String _proName,
      _proBrand,
      _proModel,
      _proColor,
      _proMaterial,
      _proMarketDesc,
      _proDescription;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ScaffoldMessenger(
      key: _scaffoldkey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: /*_imagesFileList != null
                                    ? previewImages()
                                    :*/
                            Column(
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Price and Quantity
                  Row(
                    children: [
                      /*
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: size.width * 0.45,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Prix',
                              hintText: 'Prix ..\XAF',
                              labelStyle: Theme.of(context).textTheme.labelLarge,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: CbColors.cbPrimaryColor2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),*/
                      //Price
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Prix ..\FCFA',
                        labelText: 'Prix',
                        textInputType:
                            TextInputType.numberWithOptions(decimal: true),
                        emptyFieldError: 'Saisir le prix du produit',
                        onChanged: (value) {
                          _price = double.parse(value!);
                        },
                      ),
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Quantité',
                        labelText: 'Quantité',
                        textInputType: TextInputType.number,
                        emptyFieldError: 'Saisir la quantité du produit',
                        onChanged: (value) {
                          _quantity = int.parse(value!);
                        },
                      ),
                      //CustomeSmallTextField(size: size, hintText: 'Poids ..\Kg', labelText: 'Poids'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Brand and Model
                  Row(
                    children: [
                      //Brand
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Saisir Marque',
                        labelText: 'Marque',
                        textInputType: TextInputType.text,
                        emptyFieldError: 'Saisir la marque du produit',
                        onChanged: (value) {
                          _proBrand = value!;
                        },
                      ),

                      //Model
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Saisir Model',
                        labelText: 'Model',
                        textInputType: TextInputType.text,
                        emptyFieldError: 'Saisir le model du produit',
                        onChanged: (value) {
                          _proModel = value!;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Color and Material
                  Row(
                    children: [
                      //Color
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Saisir Couleur',
                        labelText: 'Couleur',
                        textInputType: TextInputType.text,
                        emptyFieldError: 'Saisir la couleur du produit',
                        onChanged: (value) {
                          _proColor = value!;
                        },
                      ),

                      //Material
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Saisir Matériel',
                        labelText: 'Matériel',
                        textInputType: TextInputType.text,
                        emptyFieldError: 'Saisir le type de matériel',
                        onChanged: (value) {
                          _proMaterial = value!;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Size and Weight
                  Row(
                    children: [
                      //Size
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Saisir Taille',
                        labelText: 'Taille',
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        emptyFieldError: 'Saisir la taille du produit',
                        onChanged: (value) {
                          _proSize = double.parse(value!);
                        },
                      ),

                      //Weight
                      CustomeSmallTextField(
                        size: size,
                        hintText: 'Saisir Poids',
                        labelText: 'Poids',
                        textInputType:
                            TextInputType.numberWithOptions(decimal: true),
                        emptyFieldError: 'Saisir le poids du produit',
                        onChanged: (value) {
                          _proWeight = double.parse(value!);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Saisir la phrase d\'accroche';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _proMarketDesc = value!;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Phase d\'accroche',
                      hintText: 'Phrase d\'accroche',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: CbColors.cbPrimaryColor2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: CbColors.cbPrimaryColor2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Saisir la description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _proDescription = value!;
                    },
                    keyboardType: TextInputType.text,
                    maxLength: 800,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Saisir la Description',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: CbColors.cbPrimaryColor2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: CbColors.cbPrimaryColor2,
                        ),
                      ),
                    ),
                  ),
                ],
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
                      if (_formKey.currentState!.validate()) {
                        print('valid');
                        print(_price);
                        print(_proName);
                      } else {
                        MyMessageHandler.showSnackBar(
                            _scaffoldkey, 'please fill all fields');
                      }
                      //uploadProduct();
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

class CustomeSmallTextField extends StatelessWidget {
  const CustomeSmallTextField({
    super.key,
    required this.size,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
    required this.emptyFieldError,
    this.onChanged,
  });

  final Size size;
  final String hintText;
  final String labelText;
  final String emptyFieldError;
  final TextInputType? textInputType;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.45,
        child: TextFormField(
          validator: (value) {
            if (labelText == 'Prix') {
              if (value!.isEmpty) {
                return emptyFieldError;
              } else if (value.isValidPrice() != true) {
                return 'Format du montant invalide';
              }
              return null;
            } else if (labelText == 'Quantité') {
              if (value!.isEmpty) {
                return emptyFieldError;
              } else if (value.isValidQuantity() != true) {
                return 'Format de la Quantité invalide';
              }
              return null;
            }
            /*
          else if (label == 'Téléphone'){
            if (value!.isEmpty) {
              return emptyFieldError;
            }
            else if (value.isValidPhone() == false) {
              return 'Invalid phone number';
            }
            else if (value.isValidPhone() == true) {
              return null;
            }
            return null;
          }*/
            else {
              if (value!.isEmpty) {
                return emptyFieldError;
              }
              return null;
            }
          },
          onSaved: onChanged,
          keyboardType: textInputType,
          decoration: InputDecoration(
            labelText: labelText,
            //'Quantité',
            hintText: hintText,
            //'Saisir la quantité',
            labelStyle: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: CbColors.cbPrimaryColor2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CbColors.cbPrimaryColor2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
