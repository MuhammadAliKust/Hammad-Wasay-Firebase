import 'package:flutter/material.dart';
import 'package:hammad_wasay_firebase/models/priority.dart';
import 'package:hammad_wasay_firebase/services/priority.dart';

class CreatePriorityView extends StatefulWidget {
  final PriorityModel model;
  final bool isUpdateMode;
  const CreatePriorityView({
    super.key,
    required this.isUpdateMode,
    required this.model,
  });

  @override
  State<CreatePriorityView> createState() => _CreatePriorityViewState();
}

class _CreatePriorityViewState extends State<CreatePriorityView> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    if (widget.isUpdateMode) {
      nameController = TextEditingController(text: widget.model.name);
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isUpdateMode ? "Update Priority" : "Create Priority",
        ),
      ),
      body: Column(
        children: [
          TextField(controller: nameController),
          SizedBox(height: 20),

          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Name cannot be empty.")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      if (widget.isUpdateMode) {
                        await PriorityServices()
                            .updatePriority(
                              PriorityModel(
                                name: nameController.text,
                                docId: widget.model.docId.toString(),
                              ),
                            )
                            .then((val) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text(
                                      "Priority has been updated successfully",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                      } else {
                        await PriorityServices()
                            .createPriority(
                              PriorityModel(
                                name: nameController.text,
                                createdAt:
                                    DateTime.now().millisecondsSinceEpoch,
                              ),
                            )
                            .then((val) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text(
                                      "Priority has been created successfully",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                      }
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text(
                    widget.isUpdateMode ? "Update Priority" : "Create Priority",
                  ),
                ),
        ],
      ),
    );
  }
}
