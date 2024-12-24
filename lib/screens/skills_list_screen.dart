import 'package:flutter/material.dart';
import 'package:skilsmanager/models/skill.dart';
import 'package:skilsmanager/services/database_service.dart';

import 'skills_form_screen.dart';

class SkillsListScreen extends StatefulWidget {
  const SkillsListScreen({Key? key}) : super(key: key);

  @override
  _SkillsListScreenState createState() => _SkillsListScreenState();
}

class _SkillsListScreenState extends State<SkillsListScreen> {
  late DatabaseService databaseService;
  List<Skill> skills = [];
  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService();
    readSkills();
    print(skills);
  }

  void readSkills() async {
    final skills = await databaseService.fetchSkills();
    setState(() {
      this.skills = skills;
    });
  }

  void deleteSkill(int id) async {
    await databaseService.deleteSkill(id);
    readSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Tâches'),
      ),
      body: ListView.builder(
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final skill = skills[index];
          return ListTile(
            title: Text(skill.name),
            subtitle: Text(skill.level),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteSkill(skill.id!),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SkillsFormScreen(skill: skill),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            // ignore: prefer_const_constructors
            builder: (context) => SkillsFormScreen(),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
