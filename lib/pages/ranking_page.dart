import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_title.dart';
import 'package:level/models/user.dart';
import 'package:level/services/user_service.dart';
import 'package:localization/localization.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<User>>(
        stream: UserService().getRankedUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final rankedUsers = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: ListView(
                children: [
                  MyTitle(
                      title: "Rank".i18n(),
                      titleIcon: const Icon(Icons.bar_chart_outlined)),
                  const MyDevider(),
                  ...rankedUsers.map(buildUser).toList(),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: ListView(
                children: [
                  MyTitle(
                      title: "Rank".i18n(),
                      titleIcon: const Icon(Icons.bar_chart_outlined)),
                  const MyDevider(),
                  Text("NoDataFound".i18n()),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(User user) {
    final minutes = (user.seconds / 60).toStringAsFixed(2);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[350],
        foregroundColor: Colors.grey.shade900,
        child: Text(user.level.toString()),
      ),
      title: Text(user.username),
      subtitle: Text(
        "TimeSpend".i18n([minutes]),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
