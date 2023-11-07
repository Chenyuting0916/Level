import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:level/components/my_icon_button.dart';
import 'package:level/services/image_service.dart';
import 'package:level/services/user_service.dart';

// ignore: must_be_immutable
class MyHeadshotAndUsername extends StatefulWidget {
  String username;
  final String imageUrl;
  MyHeadshotAndUsername(
      {super.key, required this.username, required this.imageUrl});

  @override
  State<MyHeadshotAndUsername> createState() => _MyHeadshotAndUsernameState();
}

class _MyHeadshotAndUsernameState extends State<MyHeadshotAndUsername> {
  var toggleEdit = false;
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: widget.username);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(children: [
            _image != null
                ? CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 37,
                      backgroundImage:MemoryImage(_image!),
                    ),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 37,
                      backgroundImage: AssetImage(widget.imageUrl),
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
    setState(() {
      _image = img;
    });
  }
}
