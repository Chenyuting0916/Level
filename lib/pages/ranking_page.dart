import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_rank_header.dart';
import 'package:level/components/my_title.dart';
import 'package:level/components/rank_user.dart';
import 'package:level/models/user.dart';
import 'package:level/services/user_service.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:localization/localization.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  String filter = 'level';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        child: FutureBuilder<List<MyUser>>(
          future: UserService().getRankedUsers(filter),
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
                        title: "Rank".i18n() + " - $filter".i18n(),
                        titleIcon: const Icon(Icons.bar_chart_outlined)),
                    const MyDivider(),
                    MyRankHeader(
                      onTap: changeFilter,
                      currentSelected: filter,
                    ),
                    ...rankedUsers
                        .map((user) => RankUser(
                              user: user,
                            ))
                        .toList(),
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
                    const MyDivider(),
                    Text("NoDataFound".i18n()),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  changeFilter(value) {
    setState(() {
      filter = value;
    });
  }

  Future<void> _handleRefresh() async {
    await UserService().getRankedUsers(filter);
  }
}
