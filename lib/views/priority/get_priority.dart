import 'package:flutter/material.dart';
import 'package:hammad_wasay_firebase/models/priority.dart';
import 'package:hammad_wasay_firebase/services/priority.dart';
import 'package:hammad_wasay_firebase/views/priority/create_priority.dart';
import 'package:provider/provider.dart';

class GetAllPriorityView extends StatefulWidget {
  const GetAllPriorityView({super.key});

  @override
  State<GetAllPriorityView> createState() => _GetAllPriorityViewState();
}

class _GetAllPriorityViewState extends State<GetAllPriorityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get All Priority")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePriorityView(
                isUpdateMode: false,
                model: PriorityModel(),
              ),
            ),
          ).then((val) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureProvider.value(
        value: PriorityServices().getPriority(),
        initialData: [PriorityModel()],
        builder: (context, child) {
          List<PriorityModel> priorityList = context
              .watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.category),
                title: Text(priorityList[i].name.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          await PriorityServices()
                              .deletePriority(priorityList[i])
                              .then((val) {
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Priority has been deleted successfully",
                                    ),
                                  ),
                                );
                              });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatePriorityView(
                              isUpdateMode: true,
                              model: priorityList[i],
                            ),
                          ),
                        ).then((val){
                          setState(() {
                            
                          });
                        });
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
