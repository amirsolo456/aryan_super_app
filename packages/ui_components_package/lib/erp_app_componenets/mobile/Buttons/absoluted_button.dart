import 'package:flutter/material.dart';

class AbsoultNewButton extends StatefulWidget {
  const AbsoultNewButton({super.key});

  @override
  State<AbsoultNewButton> createState() => _AbsoultNewButtonState();
}
final Widget addIcon = Image.asset(
  'assets/images/add.png',
  width: 44,
  height: 44,
  package:'resources_package',
);
class _AbsoultNewButtonState extends State<AbsoultNewButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      child: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: addIcon,
      ),
    );
  }
}
