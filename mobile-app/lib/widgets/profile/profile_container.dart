import 'package:flutter/material.dart';
import '../../constants.dart';

class ProfileContainer extends StatelessWidget {
  final String name;
  final String email;
  final String building;

  const ProfileContainer(
      {required this.name, required this.email, required this.building});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector( //TODO: add the ability to change profile here.
            child: Stack(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: CircleAvatar()),
                Positioned(
                  top: 95,
                  left: 54,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: kTitleMedium.copyWith(color: Colors.white),
              ),
              Text(
                email,
                style: kTitleSmall.copyWith(color: Colors.white),
              ),
              Text(
                building,
                style: kTitleSmall.copyWith(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
