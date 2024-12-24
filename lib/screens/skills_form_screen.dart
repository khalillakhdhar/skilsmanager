import 'package:flutter/material.dart';
import 'package:skilsmanager/models/skill.dart';
import 'package:skilsmanager/services/database_service.dart';

class SkillsFormScreen extends StatefulWidget {
  final Skill? skill;
  const SkillsFormScreen({Key? key, this.skill}) : super(key: key);

  @override
  _SkillsFormScreenState createState() => _SkillsFormScreenState();
}

class _SkillsFormScreenState extends State<SkillsFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, description, level;
  late DatabaseService databaseService;
  //init state if skill is not null or empty
  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService();

    name = widget.skill?.name ?? '';
    description = widget.skill?.description ?? '';
    level = widget.skill?.level ?? '';
  }

  void saveSkill() async {
    if (_formKey.currentState!.validate()) {
      final skill = Skill(
        id: widget.skill?.id,
        name: name,
        description: description,
        level: level,
      );
      if (widget.skill == null) {
        await databaseService.insertSkill(skill);
      } else {
        await databaseService.updateSkill(skill);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.skill == null ? 'Add Skill' : 'Update Skill'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              initialValue: name,
              decoration: InputDecoration(labelText: 'Name*'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onChanged: (value) => name = value,
            ),
            TextFormField(
              initialValue: description,
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              onChanged: (value) => description = value,
            ),
            TextFormField(
              initialValue: level,
              decoration: InputDecoration(labelText: 'Level*'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a level';
                }
                return null;
              },
              onChanged: (value) => level = value,
            ),
            ElevatedButton(
              onPressed: saveSkill,
              child: Text('Save'),
            ),
          ]),
        ),
      ),
    );
  }
}
