import 'package:flutter/material.dart';
import 'package:level/components/my_button.dart';
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

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: widget.username);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 37,
              backgroundImage: AssetImage(widget.imageUrl),
            ),
          ),
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
                  MyButton(
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
          Visibility(
              visible: toggleEdit,
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  MyButton(
                    onPressed: () {
                      UserService()
                          .updateUser({"username": textController.value.text});
                      setState(() {
                        toggleEdit = !toggleEdit;
                        widget.username = textController.value.text;
                      });
                    },
                    buttonChild: const Icon(Icons.save),
                    buttonBackgroundColor: Colors.transparent,
                  ),
                  MyButton(
                    onPressed: () {
                      setState(() {
                        toggleEdit = !toggleEdit;
                      });
                    },
                    buttonChild: const Icon(Icons.keyboard_return_outlined),
                    buttonBackgroundColor: Colors.transparent,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
