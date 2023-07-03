import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_styles.dart';
import '../../../../constants/size_config.dart';
import '../main/main_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static String routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        OnboardingPageModel(
          title: 'Bienvenue sur Cashback',
          //Fast, Fluid and Secure
          description:
              'Achetez et vendez vos articles remis à neuf et d\'occasion abordables',
          //description: 'Profitez du meilleur du pays dans la paume de vos mains.',
          imageUrl: CbImageStrings.cbOnBoardingImage1,
          bgColor: CbColors.cbOnBoardingPage2Color,
        ),
        OnboardingPageModel(
          title: 'Connect with your friends.',
          description: 'Connect with your friends anytime anywhere.',
          imageUrl: CbImageStrings.cbOnBoardingImage2,
          bgColor: CbColors.cbOnBoardingPage3Color,
        ),
        OnboardingPageModel(
          title: 'Bookmark your favourites',
          description:
              'Bookmark your favourite quotes to read at a leisure time.',
          imageUrl: CbImageStrings.cbOnBoardingImage3,
          bgColor: CbColors.cbBlueLight,
        ),
        /*
        OnboardingPageModel(
          title: 'Follow creators',
          description: 'Follow your favourite creators to stay in the loop.',
          imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
          bgColor: Colors.purple,
        ),*/
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {Key? key, required this.pages, this.onSkip, this.onFinish})
      : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  bool processing = false;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  late String _uid;

  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              item.imageUrl,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  item.title,
                                  style: cbMontserratBold.copyWith(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal! * 4,
                                    color: item.textColor,
                                  ),
                                ),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: cbMontserratRegular.copyWith(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal! * 3,
                                    color: item.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 30
                              : 8,
                          height: 8,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        widget.onSkip?.call();
                      },
                      child: const Text("Skip"),
                    ),
                    processing == true
                        ? const CircularProgressIndicator(
                            color: CbColors.cbPrimaryColor2,
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                                visualDensity: VisualDensity.comfortable,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              if (_currentPage == widget.pages.length - 1) {
                                setState(() {
                                  processing = true;
                                });

                                // Sign in anonymously with Firebase
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .signInAnonymously()
                                          .whenComplete(() async {
                                    _uid =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    await anonymous.doc(_uid).set({
                                      'name': 'Invité',
                                      'email': 'guest@example.com',
                                      'profileImage': '',
                                      'phone': '11111',
                                      'adress': 'Guest place area',
                                      'cid': _uid,
                                    });
                                  });

                                  User? user = userCredential.user;
                                  if (user != null) {
                                    // Navigate to the home screen after successful sign-in
                                    await Future.delayed(
                                            const Duration(microseconds: 100))
                                        .whenComplete(() =>
                                            Navigator.pushReplacementNamed(
                                                context, MainScreen.routeName));
                                  }
                                } catch (e) {
                                  print('Error signing in anonymously: $e');
                                  // Show error message to the user
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Error signing in anonymously.'),
                                    ),
                                  );
                                }
                                //widget.onFinish?.call();
                              } else {
                                _pageController.animateToPage(_currentPage + 1,
                                    curve: Curves.easeInOutCubic,
                                    duration:
                                        const Duration(milliseconds: 250));
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  _currentPage == widget.pages.length - 1
                                      ? "Finish"
                                      : "Next",
                                ),
                                const SizedBox(width: 8),
                                Icon(_currentPage == widget.pages.length - 1
                                    ? Icons.done
                                    : Icons.arrow_forward),
                              ],
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.imageUrl,
      this.bgColor = Colors.blue,
      this.textColor = Colors.white});
}
