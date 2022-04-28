
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_package/model/inputform.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({ Key? key }) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

bool isDarkMode = false;

class _UserListPageState extends State<UserListPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  //final users = <InputForm>[];

  late Box<InputForm> _inputFormBox;

  late Box _darkMode;

  @override
  void initState() {
    super.initState();
    _darkMode = Hive.box('darkModeBox');
    _inputFormBox = Hive.box<InputForm>('inputFormBox');
  }
  
  

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (val){
              setState(() {
                isDarkMode = val;
                _darkMode.put('mode', val);
              }); 
            },
          )
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(label: Text('name')),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(label: Text('age')),
              ),
              ElevatedButton(
                onPressed: (){
                    _inputFormBox.add(InputForm(name: nameController.text, age: int.parse(ageController.text)));
                },
                child: const Text('add')
              )
            ],
          ),
          const Divider(),
          ValueListenableBuilder(
            valueListenable: Hive.box<InputForm>('inputFormBox').listenable(),
            builder: (context, Box<InputForm> inputFormBox, widget) {
              final users = inputFormBox.values.toList();
              return Expanded(
                child: users.isEmpty ? const Text('empty') : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, i){
                    return ListTile(
                      title: Text(users[i].name),
                      subtitle: Text(users[i].age.toString())
                    );
                  }
                )

              );
            }
          )
          
        ],
      )
    );
  }
}