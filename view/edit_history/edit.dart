import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:no_dr_detection_app/view/component/button_comp.dart';
import 'package:no_dr_detection_app/view/edit_history/bloc/edit_bloc.dart';
import 'package:no_dr_detection_app/view/history/bloc/history_bloc.dart';

import '../../app/core/styles/app_color.dart';
import '../../model/history_data.dart';
import '../component/empty_space.dart';
import '../component/text_comp.dart';
import '../component/text_form_field_comp.dart';

class EditScreen extends StatefulWidget {
  final HistoryModel historyModel;

  const EditScreen({Key? key, required this.historyModel}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final stageController = TextEditingController();
  final durationController = TextEditingController();
  final ageController = TextEditingController();
  final treatmentController = TextEditingController();
  final drugsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    stageController.text = widget.historyModel.stage;
    durationController.text = widget.historyModel.treatmentDuration;
    ageController.text = widget.historyModel.patientsAge.toString();
    treatmentController.text = widget.historyModel.treatment;
    drugsController.text = widget.historyModel.drugs!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
            text: "Edit Patient History",
            textStyle: Theme.of(context).textTheme.displayLarge!),
      ),
      body: BlocConsumer<EditBloc, EditState>(
        listener: (context, state) {
          if (state is SuccessEditingImageUploading) {
            BlocProvider.of<EditBloc>(context).add(EditPatientRecordEvent(
                historyModel: HistoryModel(
                    uId: widget.historyModel.uId,
                    image: BlocProvider.of<EditBloc>(context).urlImage ??
                        widget.historyModel.image,
                    stage: stageController.text.trim(),
                    patientName: widget.historyModel.patientName,
                    treatment: treatmentController.text.trim(),
                    treatmentDuration: durationController.text.trim(),
                    timeOfConsultation:
                        DateFormat.yMMMMd().format(DateTime.now()).toString(),
                    patientsAge: int.parse(ageController.text.trim()),
                    drugs: widget.historyModel.drugs)));
          }
          if (state is SuccessUpdatePatientRecord) {
            BlocProvider.of<HistoryBloc>(context).add(GetHistoryDataEvent());
            BlocProvider.of<EditBloc>(context).add(RemoveEditImageEvent());
            final snackBar = SnackBar(
                backgroundColor: Colors.green,
                content: ReusableText(
                  text: 'History Record is edited successfully.. ',
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => BlocProvider.of<EditBloc>(context)
                        .add(SelectEditImageEvent()),
                    child:
                        (BlocProvider.of<EditBloc>(context).pickedFile != null)
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 14.0),
                                child: Image.file(
                                  File(BlocProvider.of<EditBloc>(context)
                                      .pickedFile!
                                      .path!),
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.historyModel.image)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ReusableTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Stage";
                            }
                            return null;
                          },
                          controller: stageController,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.add_chart,
                          hintText: "Stage",
                          obscureText: false,
                        ),
                        putVerticalSpace(12.0),
                        (widget.historyModel.stage != 'No DR')
                            ? Column(
                                children: [
                                  ReusableTextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Duration";
                                      }
                                      return null;
                                    },
                                    controller: durationController,
                                    keyboardType: TextInputType.text,
                                    prefixIcon: Icons.date_range,
                                    hintText: "Duration",
                                    obscureText: false,
                                  ),
                                  putVerticalSpace(12.0),
                                ],
                              )
                            : const SizedBox.shrink(),
                        ReusableTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Age";
                            }
                            return null;
                          },
                          controller: ageController,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.person_outline,
                          hintText: "Age",
                          obscureText: false,
                        ),
                        putVerticalSpace(12.0),
                        ReusableTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Treatment";
                            }
                            return null;
                          },
                          controller: treatmentController,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icons.medical_information_outlined,
                          hintText: "Treatment",
                          obscureText: false,
                        ),
                        widget.historyModel.stage == "Prolific"
                            ? Column(
                                children: [
                                  putVerticalSpace(12.0),
                                  ReusableTextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Drugs";
                                      }
                                      return null;
                                    },
                                    controller: drugsController,
                                    keyboardType: TextInputType.text,
                                    prefixIcon:
                                        Icons.medical_information_outlined,
                                    hintText: "Drugs",
                                    obscureText: false,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        putVerticalSpace(25.0),
                        (state is LoadingUpdatePatientRecord)
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: ReusableButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (BlocProvider.of<EditBloc>(context)
                                              .pickedFile !=
                                          null) {
                                        BlocProvider.of<EditBloc>(context).add(
                                            UploadingEditImageAndGetURLEvent());
                                      } else {
                                        BlocProvider.of<EditBloc>(context).add(EditPatientRecordEvent(
                                            historyModel: HistoryModel(
                                                uId: widget.historyModel.uId,
                                                image: BlocProvider.of<EditBloc>(context)
                                                        .urlImage ??
                                                    widget.historyModel.image,
                                                stage:
                                                    stageController.text.trim(),
                                                patientName: widget
                                                    .historyModel.patientName,
                                                treatment: treatmentController
                                                    .text
                                                    .trim(),
                                                treatmentDuration:
                                                    durationController.text
                                                        .trim(),
                                                timeOfConsultation:
                                                    DateFormat.yMMMMd()
                                                        .format(DateTime.now())
                                                        .toString(),
                                                patientsAge: int.parse(
                                                    ageController.text.trim()),
                                                drugs: drugsController.text.trim())));
                                      }
                                    }
                                  },
                                  text: "Edit",
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
