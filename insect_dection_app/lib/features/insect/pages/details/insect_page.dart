// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insect_dection_app/core/core.dart';
import 'package:insect_dection_app/features/auth/auth.dart';
import 'package:insect_dection_app/features/insect/insect.dart';
import 'package:insect_dection_app/injection_container.dart';

class InsectPage extends StatefulWidget {
  const InsectPage({super.key});
  static MaterialPageRoute<InsectPage> route(
    BuildContext context, {
    UserBucketParams? userBucketParams,
    required String modelId,
  }) {
    final userParams = userBucketParams ??
        UserBucketParams.fromAuthUserInfo(
          BlocProvider.of<AuthBloc>(context).state.user,
        );
    return MaterialPageRoute<InsectPage>(
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<InsectDetailBloc>.call()
              ..add(
                LoadInsectDetailEvent(
                  modelId: modelId,
                  userBucketParams: userParams,
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
      listener: (_, state) {
        if (state.getDetailInsectProcess is Success &&
            state.getUserInsectBookmarkStateProcess is Initial) {
          _onLoadDetailCompleted();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: _AppbarTitle(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            _AppbarBookmarkButton(),
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
                  _ImageBox(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InsectName(),

                      /// Scientific Label
                      _ScientificLabelName(),

                      // TAXONOMIC UNIT
                      const SizedBox(height: 15),

                      /// Species
                      _TaxonomySpecies(),
                      const SizedBox(height: 15),

                      /// Genus
                      _TaxonomyGenus(),
                      const SizedBox(height: 15),

                      /// Famililia
                      _TaxonomyFamililia(),
                      const SizedBox(height: 15),

                      /// Ordo
                      _TaxonomyOrdo(),
                      const SizedBox(height: 15),

                      /// Classics - Phylum - Regnum
                      _TaxonomyOthers(),
                      const SizedBox(height: 15),

                      /// Origin
                      _InsectOrigin(),
                      const SizedBox(height: 15),

                      /// Harms
                      _Harms(),
                      const SizedBox(height: 15),

                      /// Harmed Object
                      _HarmedObject(),
                      const SizedBox(height: 15),

                      /// Identification Features
                      _InsectIdentificationFeatures(),
                      const SizedBox(height: 25),

                      /// Extended search
                      Padding(
                        padding: const EdgeInsets.only(left: 26, right: 26),
                        child: Text(
                          "Tìm kiếm mở rộng",
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      /// Insect in the same level of taxonomy
                      Padding(
                        padding: const EdgeInsets.only(left: 26, right: 26),
                        child: Text(
                          "Côn trùng cùng họ: ",
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
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

  void _onLoadDetailCompleted() {
    final userBucketParams = UserBucketParams.fromAuthUserInfo(
      BlocProvider.of<AuthBloc>(context).state.user,
    );
    final state = BlocProvider.of<InsectDetailBloc>(context).state;

    /// Load the bookmarked state
    BlocProvider.of<InsectDetailBloc>(context).add(
      LoadUserInsectBookmarkStateEvent(
        userBucketParams: userBucketParams,
        modelId: state.insect.modelId,
      ),
    );
  }
}

class _Harms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? state.insect.harms
            : "Loading...";
        return MyTextBoxInsect(
          label: "Tác hại",
          content: content,
        );
      },
    );
  }
}

class _HarmedObject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? state.insect.harmedObject
            : "Loading...";
        return MyTextBoxInsect(
          label: "Đối tượng ảnh hưởng",
          content: content,
        );
      },
    );
  }
}

class _InsectIdentificationFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? state.insect.identificationFeatures
            : "Loading...";
        return MyTextBoxInsect(
          label: "Đặc điểm nhận dạng",
          content: content,
        );
      },
    );
  }
}

class _InsectOrigin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? state.insect.origin
            : "Loading...";
        return MyTextBoxInsect(
          label: "Nguồn gốc",
          content: content,
        );
      },
    );
  }
}

class _TaxonomyOthers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: BlocBuilder<InsectDetailBloc, InsectDetailState>(
        builder: (context, state) {
          final classical = state.getDetailInsectProcess is Success
              ? (state.insect.taxonomy.classical ?? "Unknow")
              : "Loading...";
          final phylum = state.getDetailInsectProcess is Success
              ? (state.insect.taxonomy.phylum ?? "Unknow")
              : "Loading...";
          final regnum = state.getDetailInsectProcess is Success
              ? (state.insect.taxonomy.regnum ?? "Unknow")
              : "Loading...";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  /// Label
                  Text(
                    "Lớp - ",
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  ),

                  Text(
                    "Ngành - ",
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  ),

                  Text(
                    "Giới",
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              /// Content
              Row(
                children: [
                  Text(
                    "$classical - ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[900]),
                  ),
                  Text(
                    "$phylum - ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[900]),
                  ),
                  Text(
                    "$regnum ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[900]),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TaxonomyOrdo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? (state.insect.taxonomy.order ?? "Unknow")
            : "Loading...";
        return MyTextBoxInsect(label: "Bộ", content: content);
      },
    );
  }
}

class _TaxonomyFamililia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? (state.insect.taxonomy.family ?? "Unknow")
            : "Loading...";
        return MyTextBoxInsect(label: "Họ", content: content);
      },
    );
  }
}

class _TaxonomyGenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? (state.insect.taxonomy.genus ?? "Unknow")
            : "Loading...";
        return MyTextBoxInsect(label: "Giống / Chi", content: content);
      },
    );
  }
}

class _TaxonomySpecies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        final content = state.getDetailInsectProcess is Success
            ? (state.insect.taxonomy.species ?? "Unknow")
            : "Loading...";
        return MyTextBoxInsect(label: "Loài", content: content);
      },
    );
  }
}

class _ScientificLabelName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 25.0),
      child: Text(
        key: const Key('insectDetail_insectScientificName_textField'),
        "Scientific Name",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class _InsectName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 25.0, left: 30.0, right: 25.0, bottom: 10.0),
      child: BlocBuilder<InsectDetailBloc, InsectDetailState>(
        buildWhen: (previous, current) =>
            previous.getDetailInsectProcess != current.getDetailInsectProcess,
        builder: (context, state) {
          final content = state.getDetailInsectProcess is Success
              ? (state.insect.nomenclature.commonName)
              : "Loading...";

          return Text(
            key: const Key('insectDetail_insectName_textField'),
            content,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}

class _ImageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BlocBuilder<InsectDetailBloc, InsectDetailState>(
          buildWhen: (previous, current) =>
              previous.getDetailInsectProcess != current.getDetailInsectProcess,
          builder: (context, state) {
            if (state.getDetailInsectProcess is Success) {
              final insect = state.insect;
              return insect.photoUrl.isNotEmpty
                  ? Image.network(
                      width: 350,
                      height: 230,
                      key: Key(
                          'insectDetail_imageBox_imageNetwork_img${int.parse(insect.modelId)}'),
                      state.insect.photoUrl,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      width: 350,
                      height: 230,
                      'assets/images/insects_img/img${int.parse(insect.modelId) + 1}.jpg',
                    );
            } else {
              return LoadingWigget();
            }
          },
        ),
      ),
    );
  }
}

class _AppbarBookmarkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      builder: (context, state) {
        if (state.getUserInsectBookmarkStateProcess is Success) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: BookmarkButton(
              key: const Key('insectDetail_isBookmarkedInsect_bookmarkButton'),
              onTap: () {
                final currentUser =
                    BlocProvider.of<AuthBloc>(context).state.user;
                final state = BlocProvider.of<InsectDetailBloc>(context).state;
                BlocProvider.of<InsectDetailBloc>(context).add(
                  ToggleBookmarkedInsectEvent(
                    userBucketParams: UserBucketParams(
                      uid: currentUser.uid,
                    ),
                    insect: state.insect,
                    isBookmarked: state.isBookmarked,
                  ),
                );
              },
              isBookmarked: state.isBookmarked,
            ),
          );
        } else {
          return LoadingWigget();
        }
      },
    );
  }
}

class _AppbarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsectDetailBloc, InsectDetailState>(
      buildWhen: (previous, current) =>
          previous.getDetailInsectProcess != current.getDetailInsectProcess,
      builder: (context, state) {
        if (state.getDetailInsectProcess == Success()) {
          return Text(
            key: const Key('insectDetail_insectName_appBarTextField'),
            state.insect.nomenclature.commonName,
            style: TextStyle(color: Colors.grey[800]),
          );
        } else {
          return Center(child: Text("Loading..."));
        }
      },
    );
  }
}
