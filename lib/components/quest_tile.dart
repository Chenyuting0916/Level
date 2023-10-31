import 'package:flutter/material.dart';
import 'package:level/components/my_icon_button.dart';

class QuestTile extends StatefulWidget {
  final String questName;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  const QuestTile(
      {super.key,
      required this.questName,
      required this.isCompleted,
      required this.onChanged});

  @override
  State<QuestTile> createState() => _QuestTileState();
}

class _QuestTileState extends State<QuestTile> {
  var toggleEdit = false;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: widget.questName);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(5),
            border: Border.all()),
        child: Row(
          children: [
            Visibility(
              visible: !toggleEdit,
              child: Row(
                children: [
                  Checkbox(
                      value: widget.isCompleted, onChanged: widget.onChanged),
                  Text(widget.questName),
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
              ),
            ),
            Visibility(
              visible: toggleEdit,
              child: Row(
                children: [
                  Checkbox(
                      value: widget.isCompleted, onChanged: widget.onChanged),
                  SizedBox(
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
                      // UserService()
                      //     .updateUser({"username": textController.value.text});
                      setState(() {
                        toggleEdit = !toggleEdit;
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
