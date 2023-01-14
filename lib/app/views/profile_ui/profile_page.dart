import 'dart:convert';

import 'package:app_port_cap/app/models/index.dart';
import 'package:app_port_cap/app/resources/resources.dart';
import 'package:app_port_cap/app/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final UserModel userData;
  final datastore = GetStorage();

  @override
  void initState() {
    var result = datastore.read('user');
    // print(result);
    dynamic jsonData = jsonDecode(result);
    userData = UserModel.fromMap(jsonData);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TTCCorpColors.Gray,
        appBar: buildAppBar(context, userData.name),
        body: _buildLayoutSection(context),
      ),
    );
  }

  Widget _buildLayoutSection(
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                userData.uid.toString(),
                style: const TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: TTCCorpColors.White),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                userData.devID.toString(),
                style: const TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: TTCCorpColors.White),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 8.0),
                Container(
                  // margin: EdgeInsets.all(20),
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  child: AvatarWidget(
                    useLetterAvatar: true,
                    dimension: 160,
                    userName: userData.name,
                    firstName: userData.firstName,
                    lastName: userData.lastName,
                  ),
                ),

                // LogoGraphicHeader(
                //   avatar: userData.photoUrl,
                // ),
                const SizedBox(height: 16.0),
                Text(
                  userData.name.toString(),
                  style:
                      const TextStyle(color: TTCCorpColors.Black, fontSize: 24),
                ),
                Text(
                  '${userData.firstName.toString()}   ${userData.lastName.toString()}',
                  style:
                      const TextStyle(color: TTCCorpColors.Black, fontSize: 24),
                ),
                const SizedBox(height: 30.0),
              ],
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.emailFormField'.tr,
              style: const TextStyle(color: TTCCorpColors.Black, fontSize: 16),
            ),
            Text(
              userData.email.toString(),
              style: const TextStyle(color: TTCCorpColors.Black, fontSize: 16),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.cnFormField'.tr,
              style: const TextStyle(color: TTCCorpColors.Black, fontSize: 16),
            ),
            Text(
              userData.cn.toString(),
              style: const TextStyle(color: TTCCorpColors.Black, fontSize: 16),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.postFormField'.tr,
              style: const TextStyle(color: TTCCorpColors.Black, fontSize: 16),
            ),
            Text(
              userData.post.toString(),
              style: const TextStyle(color: TTCCorpColors.Black, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
