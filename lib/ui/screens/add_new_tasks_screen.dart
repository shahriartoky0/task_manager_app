import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/ui/widgets/bodyBackground.dart';
import 'package:task_manager_app/ui/widgets/profile_app_bar.dart';
import 'package:task_manager_app/ui/widgets/smack_message.dart';
import '../../Style/style.dart';
import '../../data/utility/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileAppBar(),
            Expanded(
              child: bodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              ' Add New Task',
                              style: headlineForm(colorDarkBlue),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: _titleTEController,
                              validator: (value) {
                                return isValidate(value, "Title");
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Title'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _descriptionTEController,
                              validator: (value) {
                                return isValidate(value, "Description");
                              },
                              decoration: const InputDecoration(
                                labelText: 'Description',
                              ),
                              maxLines: 8,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Visibility(
                                visible: _addNewTaskInProgress == false,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                  onPressed: addTheTask,
                                  style: formButtonStyle(),
                                  child:
                                      const Icon(Icons.arrow_circle_right_outlined),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  addTheTask ()async {
    if (_formKey.currentState!.validate()) {

      _addNewTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response =
      await NetworkCaller().postRequest(
          Urls.addNewTask,
          body: {
            "title":
            _titleTEController.text.trim(),
            "description":
            _descriptionTEController.text
                .trim(),
            "status": "New"
          });
      clearTextFields();
      _addNewTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        if (mounted) {
          showSnackMessage(context,
              "Task Added Successfully");
        }
      } else {
        if (mounted) {
          showSnackMessage(context,
              "Task Adding Failed !!! ");
        }
      }
    }
  }

  // form Validation function
  isValidate(String? value, String field) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please Enter the $field';
    }
    return null;
  }

  //clearing TextFields
  void clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
