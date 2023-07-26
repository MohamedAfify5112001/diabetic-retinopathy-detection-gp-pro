import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:no_dr_detection_app/app/core/extension/dr_extension.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/model/history_data.dart';
import 'package:no_dr_detection_app/view/component/empty_space.dart';
import 'package:no_dr_detection_app/view/component/text_form_field_comp.dart';

import '../../app/core/behaviours/get_label.dart';
import '../../model/dr_model.dart';
import '../check_your_self_screen/bloc/checking_your_self_bloc.dart';
import '../component/button_comp.dart';
import '../component/image_comp.dart';
import '../component/text_comp.dart';
import '../history/bloc/history_bloc.dart';

class DiabeticDetailsScreen extends StatefulWidget {
  const DiabeticDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DiabeticDetailsScreen> createState() => _DiabeticDetailsScreenState();
}

class _DiabeticDetailsScreenState extends State<DiabeticDetailsScreen> {
  final namePatientController = TextEditingController();
  final agePatientController = TextEditingController();
  final durationTreatmentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? value;
  String? valueDrug;

  @override
  void deactivate() {
    BlocProvider.of<CheckingYourSelfBloc>(context).add(RemoveDRImageEvent());
    BlocProvider.of<CheckingYourSelfBloc>(context).add(RemovePredictionEvent());
    namePatientController.dispose();
    durationTreatmentController.dispose();
    agePatientController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckingYourSelfBloc, CheckingYourSelfState>(
      builder: (context, state) {
        final prediction =
            BlocProvider.of<CheckingYourSelfBloc>(context).predictModel;
        final String label = getLabel((prediction[0]["label"] as String));
        return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false, //new line
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: AppColors.blackColor,
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20.0,
                    ),
                    color: AppColors.whiteColor,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  floating: true,
                  expandedHeight: 240.0,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(
                        horizontal: 70.0, vertical: 14.0),
                    background: Image.file(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      File(BlocProvider.of<CheckingYourSelfBloc>(context)
                          .pickedFile!
                          .path!),
                    ),
                    title: ReusableText(
                      text: label,
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(
                              color: AppColors.whiteColor, fontSize: 24.0),
                    ),
                  ),
                ),
                (label != "Prolific")
                    ? SliverFillRemaining(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ReusableText(
                                text: "Description",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 20.0),
                              ),
                              putVerticalSpace(8.0),
                              ReusableText(
                                text: label.typeDr.desc,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              putVerticalSpace(18.0),
                              ReusableText(
                                text: (label == 'No DR')
                                    ? "Comments"
                                    : "Treatment Options",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 20.0),
                              ),
                              putVerticalSpace(8.0),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    putVerticalSpace(10.0),
                                itemBuilder: (context, index) =>
                                    _getTreatmentItem(
                                        index, label.typeDr.treatments[index]),
                                itemCount: label.typeDr.treatments.length,
                              ),
                              putVerticalSpace(22.0),
                              SizedBox(
                                width: double.infinity,
                                child: ReusableButton(
                                  onPressed: () {
                                    openDialog();
                                  },
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  text: "Record Data",
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ReusableText(
                                text: "Description",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 20.0),
                              ),
                              putVerticalSpace(8.0),
                              ReusableText(
                                text: label.typeDr.desc,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              putVerticalSpace(18.0),
                              ReusableText(
                                text: "Treatment Options",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 20.0),
                              ),
                              putVerticalSpace(8.0),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    putVerticalSpace(10.0),
                                itemBuilder: (context, index) =>
                                    _getTreatmentItem(
                                        index, label.typeDr.treatments[index]),
                                itemCount: label.typeDr.treatments.length,
                              ),
                              _getItemsDrugs(drugsProlific
                                  .where((element) => element.name != "none")
                                  .toList()),
                              putVerticalSpace(22.0),
                              SizedBox(
                                width: double.infinity,
                                child: ReusableButton(
                                  onPressed: () {
                                    openDialog();
                                  },
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  text: "Record Data",
                                ),
                              )
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  Future openDialog() {
    final prediction =
        BlocProvider.of<CheckingYourSelfBloc>(context).predictModel;
    final String label = getLabel((prediction[0]["label"] as String));
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => AlertDialog(
          backgroundColor: AppColors.whiteColor,
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReusableTextFormField(
                    hintText: "Patient Name",
                    obscureText: false,
                    prefixIcon: Icons.person_outline,
                    controller: namePatientController,
                    keyboardType: TextInputType.text),
                putVerticalSpace(12.0),
                ReusableTextFormField(
                    hintText: "Patient Age",
                    prefixIcon: Icons.numbers,
                    obscureText: false,
                    controller: agePatientController,
                    keyboardType: TextInputType.text),
                putVerticalSpace(12.0),
                Container(
                  width: 300,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 13.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: AppColors.lightGrayColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: DropdownButton<String>(
                    hint: Row(
                      children: [
                        const Icon(Icons.medical_information_outlined),
                        putHorizontalSpace(14.0),
                        ReusableText(
                          text: (label == 'No DR') ? "Comments" : "Treatment",
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 14.0,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    iconSize: 24.0,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.blackColor,
                    ),
                    isExpanded: true,
                    items: label.typeDr.treatments
                        .map(getDropdownMenuItem)
                        .toList(),
                    value: value,
                    onChanged: (value) => setState(() => this.value = value),
                  ),
                ),
                (label != 'No DR')
                    ? Column(
                        children: [
                          putVerticalSpace(12.0),
                          ReusableTextFormField(
                              hintText: "Treatment Duration",
                              obscureText: false,
                              prefixIcon: Icons.timer_outlined,
                              controller: durationTreatmentController,
                              keyboardType: TextInputType.text),
                        ],
                      )
                    : const SizedBox.shrink(),
                (label == 'Prolific')
                    ? Column(
                        children: [
                          putVerticalSpace(12.0),
                          Container(
                            width: 300,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.lightGrayColor,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: DropdownButton<String>(
                              hint: Row(
                                children: [
                                  const Icon(Icons.medication_outlined),
                                  putHorizontalSpace(14.0),
                                  ReusableText(
                                    text: "Drugs",
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 14.0,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              iconSize: 24.0,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.blackColor,
                              ),
                              isExpanded: true,
                              items: drugsProlific
                                  .map((drug) => drug.name)
                                  .toList()
                                  .map(getDropdownMenuItem)
                                  .toList(),
                              value: valueDrug,
                              onChanged: (value) =>
                                  setState(() => valueDrug = value),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                putVerticalSpace(15.0),
                BlocConsumer<HistoryBloc, HistoryState>(
                  listener: (context, state) async {
                    if (state is SuccessSavingDataHistory) {
                      await Future.delayed(const Duration(seconds: 1),
                          () => Navigator.of(context).pop());
                      if (!mounted) return;
                      BlocProvider.of<HistoryBloc>(context)
                          .add(ReturnHistoryRecordButtonEvent());
                    }
                    if (state is SuccessUploadImageHistory) {
                      if (!mounted) return;
                      BlocProvider.of<HistoryBloc>(context)
                          .add(SavedHistoryData(
                        historyModel: HistoryModel(
                          uId: '',
                          patientName: namePatientController.text.trim(),
                          image: BlocProvider.of<HistoryBloc>(context).urlImage,
                          timeOfConsultation: DateFormat.yMMMMd()
                              .format(DateTime.now())
                              .toString(),
                          patientsAge:
                              int.parse(agePatientController.text.trim()),
                          stage: label,
                          treatment: value!,
                          treatmentDuration: (label != 'No DR')
                              ? durationTreatmentController.text.trim()
                              : "",
                          drugs: label == "Prolific" ? valueDrug : null,
                        ),
                      ));
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: 200,
                      child: (state is LoadingSavingDataHistory)
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.primaryColor),
                            )
                          : (state is SuccessSavingDataHistory)
                              ? Center(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.done,
                                        size: 24,
                                        color: AppColors.success,
                                      ),
                                      putHorizontalSpace(6.0),
                                      ReusableText(
                                        text: "Data is Recorded",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 16.0,
                                                color: AppColors.success),
                                      ),
                                    ],
                                  ),
                                )
                              : (state is ReturnInitialStateHistory)
                                  ? ReusableButton(
                                      text: "Save",
                                      onPressed: () async {
                                        BlocProvider.of<HistoryBloc>(context)
                                            .add(UploadImageHistoryData(
                                                platformFile: BlocProvider.of<
                                                            CheckingYourSelfBloc>(
                                                        context)
                                                    .pickedFile!));
                                      },
                                    )
                                  : ReusableButton(
                                      text: "Save",
                                      onPressed: () async {
                                        BlocProvider.of<HistoryBloc>(context)
                                            .add(UploadImageHistoryData(
                                                platformFile: BlocProvider.of<
                                                            CheckingYourSelfBloc>(
                                                        context)
                                                    .pickedFile!));
                                      },
                                    ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> getDropdownMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: ReusableText(
        text: item,
        textStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: 16.0, color: AppColors.blackColor),
      ));

  Widget _getItemsDrugs(List<DrugProlificDr> drugs) {
    return Builder(
      builder: (context) => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => _getDrugs(drugs[index]),
          separatorBuilder: (context, index) => putVerticalSpace(10.0),
          itemCount: 2),
    );
  }

  Widget _getDrugs(DrugProlificDr drugProlificDr) {
    return Card(
      elevation: 2.0,
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AssetImageComponent(
            path: drugProlificDr.image,
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: ReusableText(
              text: drugProlificDr.name,
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
            child: ReusableText(
              text: drugProlificDr.price,
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTreatmentItem(int index, String treatment) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blackColor, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ReusableText(
          text: "${index + 1}. $treatment",
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
