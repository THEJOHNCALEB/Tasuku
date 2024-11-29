import 'package:flutter/material.dart';
import 'package:tasuku/pages/home_page.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _homeHeaderWidget(),
            _mainImageWidget(context),
            _descriptionWidget(),
            _getStartedButtonWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _homeHeaderWidget() {
    return const Column(
      children: [
        Text(
          "Welcome to Tasuku",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Stay organized and boost productivity!",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _mainImageWidget(BuildContext context) {
    var _deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: _deviceHeight * 0.3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/onboarding.png"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _descriptionWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Easily add, manage, and complete your daily tasks with our intuitive and user-friendly interface.",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _getStartedButtonWidget(BuildContext context) {
    var _deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: _deviceWidth * 0.9,
      child: TextButton(
        onPressed: () {
          // var box = await Hive.openBox('settings');
          // box.put('isFirstLaunch', false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'GET STARTED',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
