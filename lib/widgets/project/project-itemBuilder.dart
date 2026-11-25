import 'package:flutter/material.dart';
import 'package:insync/model/project.dart';
import 'package:insync/widgets/InSync_list.dart';

class ProjectListItemBuilder {
  static List<InSyncListItem> build(
    BuildContext context,
    List<Project> projects,
  ) {
    return projects.map((project) {
      return InSyncListItem(
        title: project.name,
        subtext: project.description,
        trailingAccessory: ListChevronAccessory(),
        spacing: 12,
        leadingAccessory: Container(
          padding: const EdgeInsets.all(2),
          child: Image.asset(
            "assets/images/logo.png",
            width: 46,
            height: 46,
          ),
        ),
      );
    }).toList();
  }
}

List<Project> getSampleProjects() {
  final now = DateTime.now();

  return [
    Project(
      'project1',
      'InSync',
      'A collaborative task and project management platform.',
      'A platform that helps organizations manage projects, assign tasks, and track team progress.',
      now.subtract(const Duration(days: 30)),
      75,
    ),
    Project(
      'project2',
      'Elevate',
      'Discover and register for professional development programs.',
      'A mobile application that connects learners with training opportunities and helps administrators manage programs.',
      now.subtract(const Duration(days: 15)),
      45,
    ),
    Project(
      'project3',
      'SpendWise',
      'Track your expenses and manage your personal budget.',
      'A personal finance application that allows users to record expenses, analyze spending habits, and manage their budgets.',
      now.subtract(const Duration(days: 10)),
      90,
    ),
    Project(
      'project4',
      'SafeTalk',
      'A secure messaging application focused on privacy.',
      'An end-to-end encrypted messaging system that enables users to communicate securely using modern cryptographic techniques.',
      now.subtract(const Duration(days: 5)),
      30,
    ),
    Project(
      'project5',
      'TaskFlow',
      'Organize daily tasks and improve productivity.',
      'A productivity platform designed to help individuals organize their work, set priorities, and monitor task completion.',
      now,
      10,
    ),
  ];
}