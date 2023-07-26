import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/app/core/styles/text_weight.dart';
import 'package:no_dr_detection_app/view/component/empty_space.dart';
import 'package:no_dr_detection_app/view/component/text_comp.dart';

import '../../app/caching/cache_helper.dart';
import '../../app/core/constants/constants_app.dart';
import '../../app/core/routes/navigation.dart';
import '../../app/core/styles/app_color.dart';
import '../component/pie_charts_for_dr_stages.dart';
import '../component/pie_charts_for_gender.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    final uId = CacheHelper.getValue(key: AppConstants.MYUID);
    BlocProvider.of<HomeBloc>(context).add(GetSpecificUserEvent(uId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                height: 400,
                width: double.infinity,
                color: AppColors.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    putVerticalSpace(50.0),
                    Row(
                      children: [
                        putHorizontalSpace(20.0),
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            color: AppColors.whiteColor,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                    putVerticalSpace(110.0),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ReusableText(
                            text: "Eye Care",
                            textStyle: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: FontsSizesManager.s26,
                                  letterSpacing: 1.8,
                                ),
                          ),
                          putVerticalSpace(8.0),
                          ReusableText(
                            text: "Diabetic Retinopathy Detection",
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: FontsSizesManager.s16,
                                  letterSpacing: 1.4,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            putVerticalSpace(14.0),
            FadeInLeft(
              child: const ChartDrStages(),
            ),
            FadeInLeft(
              child: const ChartDrAmongGender(),
            ),
          ],
        ),
      ),
    );
  }
}

class GDPData {
  final String content;
  final int gdp;

  GDPData({required this.content, required this.gdp});
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeaderWidget(),
          NavigationListTile(),
        ],
      ),
    );
  }
}

class NavigationListTile extends StatelessWidget {
  const NavigationListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTileWidget(
          onTap: () {
            Navigator.of(context).pop();
            AppNavigator.pushNamedNavigator(AppConstants.checkPath, context);
          },
          leading: const Icon(Icons.check_circle),
          title: ReusableText(
            text: "Check Your Patient",
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        ListTileWidget(
          onTap: () {
            Navigator.of(context).pop();
            AppNavigator.pushNamedNavigator(AppConstants.historyPath, context);
          },
          leading: const Icon(Icons.history),
          title: ReusableText(
            text: "History",
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        putVerticalSpace(10.0),
        Divider(
          color: AppColors.grayColor,
          height: 10,
        ),
        putVerticalSpace(10.0),
        ListTileWidget(
          onTap: () async {
            await CacheHelper.removeValue(key: AppConstants.MYUID)
                .then((value) {
              AppNavigator.pushNamedAndRemoveUntilNavigator(
                  AppConstants.loginPath, context);
            }).then((value) => FirebaseAuth.instance.signOut());
          },
          leading: const Icon(Icons.logout_outlined),
          title: ReusableText(
            text: "Log out",
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final homeBloc = BlocProvider.of<HomeBloc>(context).userModel;
        return DrawerHeader(
          padding: const EdgeInsets.all(0),
          child: Container(
            color: AppColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(homeBloc!.image!),
                  ),
                  ReusableText(
                    text: "${homeBloc.firstName} ${homeBloc.lastName}",
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.whiteColor, fontSize: 18.0),
                  ),
                  ReusableText(
                    text: homeBloc.email,
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.whiteColor, fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget title;
  final Widget leading;

  const ListTileWidget(
      {super.key,
      required this.onTap,
      required this.title,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      onTap: onTap,
      leading: leading,
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final path = Path();
    path.lineTo(0, height);
    path.quadraticBezierTo(width * 0.5, height - 100, width, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
