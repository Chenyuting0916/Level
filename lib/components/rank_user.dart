import 'package:flutter/material.dart';
import 'package:level/components/my_button.dart';
import 'package:level/components/my_row_status.dart';
import 'package:level/models/user.dart';
import 'package:level/services/user_service.dart';
import 'package:localization/localization.dart';

class RankUser extends StatelessWidget {
  final MyUser user;
  const RankUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final minutes = (user.seconds / 60).toStringAsFixed(2);

    return InkWell(
      child: ListTile(
          onTap: () async {
            var selectedUser = await UserService().getUser(user.userId);
            if (!context.mounted) return;
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      selectedUser!.username,
                      style: const TextStyle(fontSize: 18),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyRowStatus(
                            statusName: "STR".i18n(),
                            status: selectedUser.strength),
                        MyRowStatus(
                            statusName: "WIS".i18n(),
                            status: selectedUser.wisdom),
                        MyRowStatus(
                            statusName: "INT".i18n(),
                            status: selectedUser.intelligence),
                        MyRowStatus(
                            statusName: "AGI".i18n(),
                            status: selectedUser.agility),
                        MyRowStatus(
                            statusName: "LUK".i18n(),
                            status: selectedUser.luck),
                        MyRowStatus(
                            statusName: "VIT".i18n(),
                            status: selectedUser.vitality),
                        MyRowStatus(
                            statusName: "PS".i18n(),
                            status: selectedUser.professionalSkill),
                        MyRowStatus(
                            statusName: "FQ".i18n(),
                            status: selectedUser.financialQuotient),
                      ],
                    ),
                    actions: [
                      MyButton(
                          buttonBackgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          buttonChild: Text("Confirm".i18n()),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  );
                });
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 24,
              backgroundImage: NetworkImage(user.imageUrl == ""
                  ? "https://firebasestorage.googleapis.com/v0/b/level-36ac1.appspot.com/o/profileImage%2Fv10.png?alt=media&token=d4c980bf-7a75-4d23-9472-1370c22d6f53&_gl=1*13ol4ak*_ga*MTM5MjA3NjE2MC4xNjk4OTA5NzAx*_ga_CW55HF8NVT*MTY5OTM2MjMxNy40LjEuMTY5OTM2NDk0MS40MC4wLjA."
                  : user.imageUrl),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tooltip(
                message: user.username,
                triggerMode: TooltipTriggerMode.tap,
                child: Text(
                  user.username.length > 10
                      ? '${user.username.substring(0, 10)}...'
                      : user.username,
                ),
              ),
            ],
          ),
          subtitle: Text(
            "TimeSpend".i18n([minutes]),
            style: const TextStyle(fontSize: 12),
          ),
          trailing: Text(
            "RankLevel".i18n([user.level.toString()]),
            style: const TextStyle(fontSize: 14),
          )),
    );
  }
}