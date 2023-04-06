import 'package:cashback/src/constants/colors.dart';
import 'package:cashback/src/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullScreenView extends StatefulWidget {
  final List<dynamic> imagesList;

  const FullScreenView({Key? key, required this.imagesList}) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          //title: const Text('Full Screen View'),
          leading: IconButton(
            icon: SvgPicture.asset(
              CbImageStrings.cbSvgBackArrow,
              height: height * 0.03,
              color: CbColors.cbPrimaryColor2,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  ('${index + 1}/${widget.imagesList.length}'),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                ),
              ),
              SizedBox(
                height: height * 0.5,
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  controller: _controller,
                  children: images(),
                ),
              ),
              SizedBox(
                height: height * 0.2,
                child: imageView(width),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //principal image
  List<Widget> images() {
    return List.generate(
      widget.imagesList.length,
          (index) {
        return InteractiveViewer(
          transformationController: TransformationController(),
          child: Image.network(
            widget.imagesList[index].toString(),
          ),
        );

        /*Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.imagesList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );*/
      },
    );
  }

  //down images carousel slider
  Widget imageView(double width){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.imagesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _controller.animateToPage(index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut);
            //_controller.jumpToPage(index);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            width: width * 0.3,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: CbColors.cbPrimaryColor2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imagesList[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
