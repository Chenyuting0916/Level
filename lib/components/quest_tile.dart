import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QuestTile extends StatefulWidget {
  final String questName;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? editOnPressed;
  final Function(BuildContext)? deleteOnPressed;
  final VoidCallback questOnTapped;

  const QuestTile(
      {super.key,
      required this.questName,
      required this.isCompleted,
      required this.onChanged,
      required this.editOnPressed,
      required this.deleteOnPressed,
      required this.questOnTapped});

  @override
  State<QuestTile> createState() => _QuestTileState();
}

class _QuestTileState extends State<QuestTile> {
  var toggleEdit = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: widget.editOnPressed,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: widget.deleteOnPressed,
            backgroundColor: const Color.fromARGB(255, 253, 94, 83),
            icon: Icons.delete,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Checkbox(
                      checkColor: const Color.fromARGB(221, 37, 37, 37),
                      activeColor: Colors.green.shade300,
                      value: widget.isCompleted,
                      onChanged: widget.onChanged),
                  InkWell(
                    onTap: widget.questOnTapped,
                    child: Text(widget.questName,
                        style: TextStyle(
                            decoration: widget.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
