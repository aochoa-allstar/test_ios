// ignore_for_file: unrelated_type_equality_checks, unused_element

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:location/location.dart';

import 'package:onax_app/src/controllers/pagesController.dart';

import 'package:onax_app/src/repositories/services/locationPermision.dart';
import 'package:onax_app/src/views/list_jsas_screen.dart';

import 'package:onax_app/src/views/manage_options_screen.dart';

import 'package:onax_app/src/views/JsasFormScreen.dart';
import 'package:onax_app/src/views/permissionsNotGrantedPage.dart';

import 'package:permission_handler/permission_handler.dart'
    as PermissionsHandler;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/checkNetwork.dart';
import '../utils/sharePrefs/accountPrefs.dart';
import 'fourth_screen.dart';
import 'home_screen.dart';

class PagesScreen extends StatefulWidget {
  PagesScreen({Key? key}) : super(key: key);

  @override
  State<PagesScreen> createState() => _PagesScreenState();
}

class _PagesScreenState extends State<PagesScreen> with WidgetsBindingObserver {
  PermissionStatus currentStatus = PermissionStatus.denied;
  final PermissionsHandler.Permission _permission =
      PermissionsHandler.Permission.location;
  bool _checkingPermission = false;
  //
  Map _source = {ConnectivityResult.none: false};
  late bool? statusLocation = false;
  late NetworkConnectivity? _networkConnectivity;

  @override
  void initState() {
    initLocation().then((val) {
      location.getLocation();
      setState(() {
        statusLocation = val;
      });
      initLocationStream();
    }).catchError((error) {
      print(error);
    });
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  void initLocationStream() async {
    startStreamLocation();
  }

  // check permissions when app is resumed
  // this is when permissions are changed in app settings outside of app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.paused) {
      // _checkingPermission = true;
      // _checkPermission(_permission).then((_) => _checkingPermission = false);
      // initCheckPermission().then((value) {});
      initLocation().then((val) {
        location.getLocation();
      }).catchError((error) {
        print(error);
        //Get.offNamed('/blockScreen');
      });
      // PermissionHandler()
      //     .checkPermissionStatus(PermissionGroup.locationWhenInUse)
      //     .then(_updateStatus);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PagesConroller pagesController = PagesConroller();
    /*if (statusLocation == false) {
      //return Get.offAllNamed('/');
      return PermissionsNotGrantedPage();
    } else {*/
    return GetBuilder<PagesConroller>(
        init: pagesController,
        builder: (_) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.blueAccent),
                // leading: IconButton(
                //   icon: Icon(Icons.menu,
                //       color: Colors.blueAccent), // set your color here
                //   onPressed: () {},
                // ),
                title: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // color: Colors.red,
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/img/splashLogo.png',
                            fit: BoxFit.contain,
                            scale: 1,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                backgroundColor: Colors.white,
                // leading: Container(
                //   // color: Colors.red,
                //   width: 50,
                //   height: 50,
                //   child: Image.asset(
                //     'assets/img/loginLogo.png',
                //     fit: BoxFit.cover,
                //     scale: 1,
                //   ),
                // ),
                // actions: [

                // ],
              ),
              body: _getPageView(context, _),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 13, 106, 183),
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.amber,
                currentIndex: _.selectedIndex,
                elevation: 10,
                type: BottomNavigationBarType.shifting,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: const Color.fromARGB(255, 13, 106, 183),
                      icon: Icon(
                        Icons.home,
                        size: _.selectedIndex == 0 ? 40.0 : 30.0,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      backgroundColor: const Color.fromARGB(255, 13, 106, 183),
                      icon: Icon(
                        FontAwesomeIcons.penToSquare,
                        size: _.selectedIndex == 1 ? 40.0 : 30.0,
                      ),
                      label: 'JSAs'),
                  BottomNavigationBarItem(
                      backgroundColor: const Color.fromARGB(255, 13, 106, 183),
                      icon: Icon(
                        FontAwesomeIcons.truck,
                        size: _.selectedIndex == 2 ? 40.0 : 30.0,
                      ),
                      label: 'Inspection'),
                  BottomNavigationBarItem(
                      backgroundColor: const Color.fromARGB(255, 13, 106, 183),
                      icon: Icon(
                        Icons.manage_accounts,
                        size: _.selectedIndex == 3 ? 40.0 : 30.0,
                      ),
                      label: ''),
                ],
                onTap: (index) {
                  //_.selectBtmItemMenu(index);
                  _.selectedIndex = index;
                  _.pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                  _.update();
                },
              ),
              drawer: drawerOptions(_),
            )
        //: PermissionsNotGrantedPage(),
        // ),
        );
    //}
  }

  //get the current page from the current index menu item selected
  _getPageView(BuildContext context, PagesConroller _) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _.pageController,
      onPageChanged: (index) {
        //_.selectBtmItemMenu(index);
      },
      children: [
        HomeScreen(),
        JsasToSignature(),
        //JsasFormScreen(),
        FourthScreen(),
        //ThirdScreen(),
        ManageOptionScreen(),
      ],
    );
  }

  Future<void> _checkPermission(
      PermissionsHandler.Permission permission) async {
    final status = await location.requestService(); //permission.request();
    if (!status) {
      //

    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.deniedForever) {
      print('Take the user to the settings page.');
      PermissionsHandler.openAppSettings();
      return;
    }
  }

  initCheckPermission() async {
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }
  }

  //DRAWER
  drawerOptions(PagesConroller _) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        ///
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              // color: Colors.red,
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/img/splashLogo.png',
                fit: BoxFit.contain,
                scale: 1,
              ),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: const Text('Tickets'),
            onTap: () {
              _.sendToViewTicketTosing();
            },
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('menu_add_destination'.tr),
            onTap: () {
              _.sendToViewToSaveDestiantion();
            },
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('menu_add_project'.tr),
            onTap: () {
              _.sendToViewToSaveProject();
            },
          ),
          // ListTile(
          //   title: const Text('Item 2'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
        ],
      ),
    );
  }
}
