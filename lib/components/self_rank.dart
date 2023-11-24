import 'package:flutter/material.dart';
import 'package:level/components/rank_user.dart';
import 'package:level/models/self_rank.dart';
import 'package:level/services/self_rank_service.dart';
import 'package:localization/localization.dart';

class SelfRank extends StatelessWidget {
  final String filter;
  const SelfRank({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SelfRankViewModel>(
        future: SelfRankService().getSelfRankViewModel(filter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final selfRank = snapshot.data!;
            final self = selfRank.self;

            return Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Text("#${selfRank.rank}"),
                    Expanded(child: RankUser(user: self))
                  ],
                ));
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: ListView(
                children: [
                  Text("NoDataFound".i18n()),
                ],
              ),
            );
          }
        });
  }
}
