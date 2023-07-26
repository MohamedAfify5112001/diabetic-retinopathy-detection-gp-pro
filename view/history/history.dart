import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:no_dr_detection_app/app/core/routes/navigation.dart';
import 'package:no_dr_detection_app/app/core/routes/routes.dart';
import 'package:no_dr_detection_app/app/core/styles/app_color.dart';
import 'package:no_dr_detection_app/model/history_data.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';
import 'package:no_dr_detection_app/view/edit_history/edit.dart';

import '../../app/core/constants/constants_app.dart';
import '../component/empty_space.dart';
import 'bloc/history_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(GetHistoryDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is SuccessDeleteHistory) {
          final snackBar = SnackBar(
              backgroundColor: Colors.green,
              content: ReusableText(
                text: 'History Item is deleted successfully....',
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: ReusableText(
                text: "Patients History",
                textStyle: Theme.of(context).textTheme.displayLarge!),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    historyItems: (state is SuccessDeleteHistory)
                        ? state.items
                        : BlocProvider.of<HistoryBloc>(context).historyItems,
                  ),
                ),
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: state is LoadingGetDataHistory
              ? Center(
                  child: SizedBox(
                      width: 210,
                      child: Lottie.asset("assets/json/loading.json")),
                )
              : (state is SuccessGetDataHistory)
                  ? SingleChildScrollView(
                      child: ExpansionPanelList.radio(
                        elevation: 0.0,
                        children: BlocProvider.of<HistoryBloc>(context)
                            .historyItems
                            .map((history) => patientDataWidget(history))
                            .toList(),
                      ),
                    )
                  : (state is SuccessDeleteHistory && state.items.isNotEmpty)
                      ? SingleChildScrollView(
                          child: ExpansionPanelList.radio(
                            elevation: 0.0,
                            children: state.items
                                .map((history) => patientDataWidget(history))
                                .toList(),
                          ),
                        )
                      : (state is! EmptyDataHistory &&
                              state is FailedGetDataHistory)
                          ? Center(
                              child: SizedBox(
                                  width: 210,
                                  child: Lottie.asset(
                                      "9531-oops-something-went-wrong.json")),
                            )
                          : (state is SuccessDeleteHistory &&
                                  state.items.isEmpty)
                              ? Center(
                                  child: SizedBox(
                                      width: 210,
                                      child: Lottie.asset(
                                          "assets/json/113070-empty-box-blue.json")),
                                )
                              : Center(
                                  child: SizedBox(
                                      width: 210,
                                      child: Lottie.asset(
                                          "assets/json/113070-empty-box-blue.json")),
                                ),
        );
      },
    );
  }

  ExpansionPanelRadio patientDataWidget(HistoryModel historyModel) {
    return ExpansionPanelRadio(
      canTapOnHeader: true,
      backgroundColor: Colors.grey[100],
      value: historyModel,
      headerBuilder: (BuildContext context, bool isExpansion) =>
          _buildNameListTile(historyModel, context),
      body: _buildPatientData(historyModel),
    );
  }

  Widget _buildPatientData(HistoryModel historyModel) => Builder(
        builder: (BuildContext context) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          color: AppColors.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image(image: NetworkImage(historyModel.image))),
              putVerticalSpace(10.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blackColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: ReusableText(
                    text: "Stage : ${historyModel.stage}",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: AppColors.blackColor)),
              ),
              putVerticalSpace(10.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blackColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: ReusableText(
                    text: "Age : ${historyModel.patientsAge}",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: AppColors.blackColor)),
              ),
              putVerticalSpace(10.0),
              historyModel.stage != 'No DR'
                  ? Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.blackColor, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: ReusableText(
                              text:
                                  "Duration : ${historyModel.treatmentDuration}",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                      color: AppColors.blackColor)),
                        ),
                        putVerticalSpace(10.0),
                      ],
                    )
                  : const SizedBox.shrink(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blackColor, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: ReusableText(
                    text: historyModel.stage != 'No DR'
                        ? "Treatment : ${historyModel.treatment}"
                        : "Comment : ${historyModel.treatment}",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: AppColors.blackColor)),
              ),
              if (historyModel.drugs!.isNotEmpty)
                Column(
                  children: [
                    putVerticalSpace(10.0),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.blackColor, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: ReusableText(
                          text: "Drugs : ${historyModel.drugs}",
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  color: AppColors.blackColor)),
                    ),
                  ],
                )
              else
                const SizedBox.shrink(),
              putVerticalSpace(10.0),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: ReusableText(
                    text: DateFormat.yMMMMd().format(DateTime.now()).toString(),
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0,
                            color: AppColors.blackColor)),
              ),
              putVerticalSpace(12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditScreen(historyModel: historyModel))),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.edit,
                          color: AppColors.blackColor,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                  putHorizontalSpace(10.0),
                  InkWell(
                    onTap: () => BlocProvider.of<HistoryBloc>(context)
                        .add(DeletingHistoryEvent(historyModel.uId)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.errorColor,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget _buildNameListTile(HistoryModel e, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
      child: ReusableText(
          text: e.patientName,
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16.0)),
    );
  }
}

//TODO In Out
ExpansionPanelRadio _patientDataWidget(HistoryModel historyModel) {
  return ExpansionPanelRadio(
    canTapOnHeader: true,
    backgroundColor: Colors.grey[100],
    value: historyModel,
    headerBuilder: (BuildContext context, bool isExpansion) =>
        _buildNameListTile(historyModel, context),
    body: _buildPatientData(historyModel),
  );
}

Widget _buildPatientData(HistoryModel historyModel) => Builder(
      builder: (BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        color: AppColors.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image(image: NetworkImage(historyModel.image))),
            putVerticalSpace(10.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blackColor, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: ReusableText(
                  text: "Stage : ${historyModel.stage}",
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: AppColors.blackColor)),
            ),
            putVerticalSpace(10.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blackColor, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: ReusableText(
                  text: "Age : ${historyModel.patientsAge}",
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: AppColors.blackColor)),
            ),
            putVerticalSpace(10.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blackColor, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: ReusableText(
                  text: "Duration : ${historyModel.treatmentDuration}",
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: AppColors.blackColor)),
            ),
            putVerticalSpace(10.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blackColor, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(8.0),
              child: ReusableText(
                  text: "Treatment : ${historyModel.treatment}",
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: AppColors.blackColor)),
            ),
            if (historyModel.drugs!.isNotEmpty)
              Column(
                children: [
                  putVerticalSpace(10.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blackColor, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: ReusableText(
                        text: "Drugs : ${historyModel.drugs}",
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                color: AppColors.blackColor)),
                  ),
                ],
              )
            else
              const SizedBox.shrink(),
            putVerticalSpace(10.0),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: ReusableText(
                  text: DateFormat.yMMMMd().format(DateTime.now()).toString(),
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                      color: AppColors.blackColor)),
            ),
            putVerticalSpace(12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditScreen(historyModel: historyModel))),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.blackColor,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
                putHorizontalSpace(10.0),
                InkWell(
                  onTap: () => BlocProvider.of<HistoryBloc>(context)
                      .add(DeletingHistoryEvent(historyModel.uId)),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete,
                        color: AppColors.errorColor,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

Widget _buildNameListTile(HistoryModel e, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
    child: ReusableText(
        text: e.patientName,
        textStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w700, fontSize: 16.0)),
  );
}

class CustomSearchDelegate extends SearchDelegate {
  final List<HistoryModel> historyItems;

  CustomSearchDelegate({required this.historyItems});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<HistoryModel> searchedHistory = historyItems
        .where((history) =>
            history.patientName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is SuccessDeleteHistory) {
          searchedHistory = state.items;
        }

      },
      builder: (context, state) {
        return (searchedHistory.isNotEmpty)
            ? SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  elevation: 0.0,
                  children: searchedHistory
                      .map((history) => _patientDataWidget(history))
                      .toList(),
                ),
              )
            : Center(
                child: SizedBox(
                    width: 210,
                    child:
                        Lottie.asset("assets/json/113070-empty-box-blue.json")),
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
