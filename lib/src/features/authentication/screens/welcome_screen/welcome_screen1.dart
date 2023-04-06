import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CbColors.cbBackgoundBleuDark,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Image.asset(
                    'assets/images/background/bg.png',
                    color: CbColors.cbBlueLight,
                ),
              ),
            ),

          ),
          SizedBox(height: 40,),
          Expanded(
              child: Column(
                children: [
                  Text('Welcome to CashBack',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Read our ',
                        style: TextStyle(
                          color: CbColors.cbGreyDark,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: CbColors.cbBlueLight,
                            ),
                          ),
                          TextSpan(
                            text: ' Tap ',
                            style: TextStyle(
                              color: CbColors.cbGreyDark,
                            ),
                          ),
                          TextSpan(
                            text: ' "Agree and continue" ',
                            style: TextStyle(
                              color: Color(0xFF53BDEB),
                            ),
                          ),
                          TextSpan(
                            text: 'to accept ',
                            style: TextStyle(
                              color: CbColors.cbGreyDark,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Services',
                            style: TextStyle(
                              color: CbColors.cbBlueLight,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CbColors.cbBlueLight,
                          foregroundColor: Color(0xFF111B21),
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                            'AGREE AND CONTINUE'
                        )
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Material(
                    color: Color(0xFF111B21),
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: (){},
                      borderRadius: BorderRadius.circular(20),
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Color(0xFF111B21),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.language, color: CbColors.cbBlueLight,),
                            SizedBox(width: 10,),
                            Text(
                                'English',
                              style: TextStyle(
                                color: CbColors.cbBlueLight,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.keyboard_arrow_down, color: CbColors.cbBlueLight,),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ),
        ],
      ),

      /*body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [
                Color(0xFF2B4C9B),
                Colors.blue,
                Color(0xFF2B4C9B),
              ],
              radius: 0.8,
            stops: [0.0,0.0,1.0]
          ),
        ),
        child: Image.asset('assets/images/background/bgIcons_light.png'),
      ),*/
    );
  }
}
