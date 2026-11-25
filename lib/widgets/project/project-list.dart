import 'package:flutter/material.dart';
import 'package:insync/model/project.dart';
import 'package:insync/widgets/InSync_list.dart';
import 'package:insync/widgets/common/app_bar.dart';
import 'package:insync/widgets/project/project-itemBuilder.dart';


class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({super.key});

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
  late final List<Project> projects = getSampleProjects();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InSyncAppBar(title: 'My Projects', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.only(top: 10, bottom: 100),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InSyncList(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  items: ProjectListItemBuilder.build(context, projects),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}