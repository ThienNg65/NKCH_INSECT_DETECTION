// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/injection_container.dart';

class InsectPage extends StatefulWidget {
  const InsectPage({super.key});
  static MaterialPageRoute<InsectPage> route(
    BuildContext context, {
    required String currentUserId,
    required String modelId,
  }) {
    return MaterialPageRoute<InsectPage>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<InsectDetailBloc>.call()
              ..add(
                LoadInsectDetailEvent(
                  modelId: modelId,
                  userBucketParams: UserBucketParams(uid: currentUserId),
                ),
              ),
          ),
        ],
        child: InsectPage(),
      ),
    );
  }

  @override
  State<InsectPage> createState() => _InsectPageState();
}

class _InsectPageState extends State<InsectPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InsectDetailBloc, InsectDetailState>(
      listener: (context, state) {
        
      },
      child: Scaffold(
        appBar: AppBar(
          title: _appbarTitle(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: _appbarBookmarkButton(),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.grey[800]),
        ),
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 5),

                  /// Insect Image Box
                  _imageBox(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _insectName(),

                      // Scientific Name
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 25.0),
                        child: Text(
                          "Scientific Name",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.only(left: 15, bottom: 15, top: 15),
                        margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(color: Colors.grey[500]),
                            ),

                            const SizedBox(height: 5),

                            /// This is temporary description
                            /// TODO: update specific UI for each feilds
                            _insectDescription(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _appbarBookmarkButton() {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      builder: (context, state) {
        return BookmarkButton(
          key: const Key('insectDetail_isBookmarkedInsect_bookmarkButton'),
          onTap: () => _toggleBookmarked(),
          isBookmarked: state.isBookmarked,
        );
      },
    );
  }

  Widget _insectDescription() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: BlocBuilder<InsectDetailBloc, InsectDetailState>(
        builder: (_, state) {
          return Text(
            key: const Key('insectDetail_insectDescription_textField'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            state.insect.toString(),
          );
        },
      ),
    );
  }

  Widget _insectName() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: BlocBuilder<InsectDetailBloc, InsectDetailState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 30.0, right: 25.0, bottom: 10.0),
            child: Text(
              key: const Key('insectDetail_insectName_textField'),
              state.insect.nomenclature.commonName!,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _imageBox() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: BlocBuilder<InsectDetailBloc, InsectDetailState>(
        builder: (context, state) {
          return Center(
            key: const Key('insectDetail_imageBox_imageNetwork'),
            //return default image from asset if null
            child: state.insect.photoUrl != null
                ? Image.network(
                    state.insect.photoUrl!,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    'assets/images/default-insect-image.png',
                  ),
          );
        },
      ),
    );
  }

  Widget _appbarTitle() {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      builder: (context, state) {
        return Text(
          key: const Key('insectDetail_insectName_appBarTextField'),
          state.insect.nomenclature.commonName ?? 'unknown',
          style: TextStyle(color: Colors.grey[800]),
        );
      },
    );
  }

  _toggleBookmarked() {
    final state = BlocProvider.of<InsectDetailBloc>(context).state;
    BlocProvider.of<InsectDetailBloc>(context).add(ToggleBookmarkedInsectEvent(
      insect: state.insect,
      isBookmarked: !state.isBookmarked,
    ));
  }
}
