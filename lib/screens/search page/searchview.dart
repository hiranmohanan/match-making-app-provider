import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:match_making_test/shared/colors.dart';
import 'package:match_making_test/shared/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/profile_filter_provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileFilterProvider>(context, listen: true);
    final TextStyle _textstylename = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      color: Colors.blue,
    );
    final TextStyle _textstyleage = TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: Colors.blue,
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              vSizedBox3,
              Card(
                color: KConstantColors.dimWhite,
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: CachedNetworkImage(
                  imageUrl: provider.selecedprofile!.profilePic,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const FlutterLogo(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              vSizedBox1,
              Card(
                color: KConstantColors.dimWhite,
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Table(
                    textDirection: TextDirection.ltr,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(0.5),
                      2: FlexColumnWidth(3),
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          'Name',
                          style: _textstyleage,
                        ),
                        tableSpacer(textstyleage: _textstyleage),
                        Text(
                          '${provider.selecedprofile!.fname!} ${provider.selecedprofile!.lname!}',
                          style: _textstylename,
                        ),
                      ]),
                      provider.selecedprofile!.age == null
                          ? const TableRow(children: [
                              SizedBox.shrink(),
                              SizedBox.shrink(),
                              SizedBox.shrink()
                            ])
                          : TableRow(children: [
                              Text(
                                'Age',
                                style: _textstyleage,
                              ),
                              tableSpacer(textstyleage: _textstyleage),
                              Text(
                                provider.selecedprofile!.age.toString(),
                                style: _textstylename,
                              ),
                            ]),
                      provider.selecedprofile!.weight == "null"
                          ? const TableRow(children: [
                              SizedBox.shrink(),
                              SizedBox.shrink(),
                              SizedBox.shrink()
                            ])
                          : TableRow(
                              children: [
                                Text(
                                  'Height',
                                  style: _textstyleage,
                                ),
                                tableSpacer(textstyleage: _textstyleage),
                                Text(
                                  provider.selecedprofile!.height!,
                                  style: _textstylename,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class tableSpacer extends StatelessWidget {
  const tableSpacer({
    super.key,
    required TextStyle textstyleage,
  }) : _textstyleage = textstyleage;

  final TextStyle _textstyleage;

  @override
  Widget build(BuildContext context) {
    return Text(
      ':',
      style: _textstyleage,
    );
  }
}
