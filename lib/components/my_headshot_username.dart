import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:level/components/my_icon_button.dart';
import 'package:level/services/image_service.dart';
import 'package:level/services/user_service.dart';

// ignore: must_be_immutable
class MyHeadshotAndUsername extends StatefulWidget {
  String username;
  String imageUrl;
  MyHeadshotAndUsername(
      {super.key, required this.username, required this.imageUrl});

  @override
  State<MyHeadshotAndUsername> createState() => _MyHeadshotAndUsernameState();
}

class _MyHeadshotAndUsernameState extends State<MyHeadshotAndUsername> {
  var toggleEdit = false;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: widget.username);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 37,
                backgroundImage: NetworkImage(widget.imageUrl == ""
                    ? "https://firebasestorage.googleapis.com/v0/b/level-36ac1.appspot.com/o/profileImage%2Fv10.png?alt=media&token=d4c980bf-7a75-4d23-9472-1370c22d6f53&_gl=1*13ol4ak*_ga*MTM5MjA3NjE2MC4xNjk4OTA5NzAx*_ga_CW55HF8NVT*MTY5OTM2MjMxNy40LjEuMTY5OTM2NDk0MS40MC4wLjA."
                    : widget.imageUrl),
              ),
            ),
            Positioned(
              bottom: -14,
              left: 45,
              child: IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: selectImage,
              ),
            )
          ]),
          const SizedBox(
            width: 18,
          ),
          Visibility(
              visible: !toggleEdit,
              child: Row(
                children: [
                  Tooltip(
                    message: widget.username,
                    triggerMode: TooltipTriggerMode.tap,
                    child: Text(
                      widget.username.length > 10
                          ? '${widget.username.substring(0, 10)}...'
                          : widget.username,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  MyIconButton(
                    onPressed: () {
                      setState(() {
                        toggleEdit = !toggleEdit;
                      });
                    },
                    buttonChild: const Icon(Icons.edit),
                    buttonBackgroundColor: Colors.transparent,
                  )
                ],
              )),
          Expanded(
            child: Visibility(
                visible: toggleEdit,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 55,
                      width: 100,
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    MyIconButton(
                      onPressed: () {
                        UserService().updateUser(
                            {"username": textController.value.text});
                        setState(() {
                          toggleEdit = !toggleEdit;
                          widget.username = textController.value.text;
                        });
                      },
                      buttonChild: const Icon(Icons.save),
                      buttonBackgroundColor: Colors.transparent,
                    ),
                    MyIconButton(
                      onPressed: () {
                        setState(() {
                          toggleEdit = !toggleEdit;
                        });
                      },
                      buttonChild: const Icon(Icons.keyboard_return_outlined),
                      buttonBackgroundColor: Colors.transparent,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  void selectImage() async {
    Uint8List? img = await ImageService().pickImage(ImageSource.gallery);
    if (img != null) {
      var downloadUrl = await ImageService().saveToFirebase(img);
      await UserService().updateUser({'imageUrl': downloadUrl});
      setState(() {
        widget.imageUrl = downloadUrl;
      });
    }
  }
}
