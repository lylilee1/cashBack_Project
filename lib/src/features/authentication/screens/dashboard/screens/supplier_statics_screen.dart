import 'package:cashback/src/common_widgets/app_bar/appBarWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupplierStaticsScreen extends StatelessWidget {
  SupplierStaticsScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldMessengerState> _scaffoldskey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        num itemCount = 0;
        for (var item in snapshot.data!.docs) {
          itemCount += item['orderqty'].length;
        }

        double totalPrice = 0.0;
        for (var item in snapshot.data!.docs) {
          totalPrice += item['orderqty'] * item['orderprice'];
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: const AppBarBackButton(),
            title: const AppBarTitle(title: 'Statistiques Fournisseur'),
          ),
          body: SafeArea(
            child: ScaffoldMessenger(
              key: _scaffoldskey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SupplierStaticsModelWidget(
                          width: width,
                          label: 'sold out',
                          value: snapshot.data!.docs.length, decimal: 0,
                        ),
                        SupplierStaticsModelWidget(
                          width: width,
                          label: 'item count',
                          value: itemCount, decimal: 0,
                        ),
                        SupplierStaticsModelWidget(
                          width: width,
                          label: 'total Statics',
                          value: totalPrice, decimal: 2,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SupplierStaticsModelWidget extends StatelessWidget {
  final dynamic value;
  final String label;
  final int decimal;

  const SupplierStaticsModelWidget({
    super.key,
    required this.width,
    required this.label,
    required this.value, required this.decimal,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: width * 0.55,
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 90,
          width: width * 0.7,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AnimatedCounter(count: value, decimal: decimal,),
        ),
      ],
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int decimal;
  final dynamic count;
  const AnimatedCounter({Key? key, this.count, required this.decimal}) : super(key: key);

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    //_animation = IntTween(begin: 0, end: 100).animate(_controller);
    _animation = _controller;
    setState(() {
      _animation = Tween(begin: _animation.value, end: widget.count).animate(_controller);
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child){
        return Center(
          child: Text(
            _animation.value.toStringAsFixed(widget.decimal),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        );
      },
    );
  }
}
