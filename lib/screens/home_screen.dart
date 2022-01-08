import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmm_task/bloc/firestore_database_bloc/firestore_bloc.dart';
import 'package:jmm_task/bloc/firestore_database_bloc/firestore_event.dart';
import 'package:jmm_task/bloc/firestore_database_bloc/firestore_state.dart';
import 'package:jmm_task/bloc/picture_bloc/post_bloc.dart';
import 'package:jmm_task/bloc/picture_bloc/post_event.dart';
import 'package:jmm_task/bloc/picture_bloc/post_state.dart';
import 'package:jmm_task/components/alert.dart';
import 'package:jmm_task/components/home_header.dart';
import 'package:jmm_task/components/placeholder.dart';
import 'package:jmm_task/components/search_textfield.dart';
import 'package:jmm_task/contstants/color_config.dart';
import 'package:jmm_task/model/card_detail_model.dart';
import 'package:jmm_task/model/picture_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostBloc _bloc = PostBloc(InitialPictureState());
  final FireStoreBLoc fireStoreBLoc = FireStoreBLoc(InitialFirestoreState());
  List<PostModel> pictures = [];
  List<CardDetail> cardsDetails = [];

  @override
  void initState() {
    _bloc.add(GetAllPicturesEvent());
    fireStoreBLoc.add(FetchedDocumentDataFromFirestoreevent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            child: HomeHeader(),
            preferredSize: Size(size.width, 110),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _buildBottomNavBar(size),
          body: BlocConsumer(
              bloc: _bloc,
              builder: (context, state) {
                if (state is LoadingPictureState) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                    ),
                  );
                }
                if (state is FetcedPictureState) {
                  pictures = state.allPost;
                  return SingleChildScrollView(
                    child: _buildBody(
                      size,
                    ),
                  );
                }
                if (state is FailurPictureState) {
                  Alerts.showMessage(
                    context,
                    state.errorMessage!,
                  );
                }
                return SizedBox();
              },
              listener: (context, state) {
                print('state is $state');
              })),
    );
  }

  Padding _buildBody(
    Size size,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.04),
      child: Column(
        children: [
          const SearchTextfield(),
          verticalGap(size),
          _buildStory(size),
          verticalGap(size),
          _buildPostCards(size),
        ],
      ),
    );
  }

  SizedBox verticalGap(Size size) {
    return SizedBox(
      height: size.height * 0.02,
    );
  }

  _buildPostCards(
    Size size,
  ) {
    return GridView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      primary: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: size.width * 0.8,
        mainAxisExtent: size.height * 0.33,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (BuildContext ctx, index) => InkWell(
        onTap: () => print(index),
        child: _buildCard(
          size,
          pictures[index],
          index,
        ),
      ),
    );
  }

  Container _buildCard(Size size, PostModel pictures, int index) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.01),
      margin: const EdgeInsets.all(8),
      decoration: _cardDecoration(size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(size.width * 0.05),
              child: CustomPlaceHolder(imageUrl: pictures.downloadUrl!)),
          SizedBox(
            height: size.height * 0.01,
          ),
          BlocConsumer(
              bloc: fireStoreBLoc,
              builder: (context, state) {
                if (state is FetchedFirestoreDocumentstate) {
                  print('state details == ${state.cardDetail}');
                  cardsDetails = state.cardDetail;
                  return cardDetail(size, index);
                }
                return SizedBox();
              },
              listener: (context, state) {
                if (state is FailureFirestoreDocumentstate) {
                  Alerts.showMessage(context, state.error);
                }
              })
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(Size size) {
    return BoxDecoration(
        border: Border.all(color: Colors.pink.shade100),
        color: ColorConfig.kstoryBorder,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(size.width * 0.05));
  }

  Column cardDetail(Size size, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${cardsDetails[index].country}',
              style: const TextStyle(
                  fontSize: 14,
                  color: ColorConfig.kPrimaryColor2,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '${cardsDetails[index].city}',
              style: const TextStyle(
                fontSize: 7,
                color: ColorConfig.kPrimaryColor2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          '${cardsDetails[index].description}',
          overflow: TextOverflow.clip,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 7,
            overflow: TextOverflow.clip,
            color: ColorConfig.kPrimaryColor2,
          ),
        ),
      ],
    );
  }

  Container _buildStory(Size size) {
    return Container(
      height: size.height * 0.12,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildStoryCard(index),
      ),
    );
  }

  Padding _buildStoryCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: 48.0,
        backgroundColor: Colors.pink[200],
        child: CircleAvatar(
            backgroundColor: ColorConfig.kstoryBorder,
            radius: 45.0,
            child: CircleAvatar(
              radius: 40.0,
              child: ClipOval(
                child:
                    CustomPlaceHolder(imageUrl: pictures[index].downloadUrl!),
              ),
            )),
      ),
    );
  }

  Container _buildBottomNavBar(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          right: size.height * 0.02,
          left: size.height * 0.02,
          bottom: size.width * 0.02),
      height: size.height * 0.07,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.1),
        border: Border.all(color: ColorConfig.kfocusBorder, width: 2),
        gradient: const LinearGradient(
            stops: [0.2, 0.9],
            colors: [ColorConfig.kPrimaryColor, ColorConfig.kPrimaryColor2]),
      ),
      child: _buildNavBarItems(size),
    );
  }

  Row _buildNavBarItems(Size size) {
    return Row(
      children: [
        _item(size, Icons.home, () {}),
        Spacer(),
        _item(size, Icons.favorite, () {}),
        Spacer(),
        _item(size, Icons.person, () {}),
      ],
    );
  }

  InkWell _item(Size size, IconData icon, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: size.height * 0.05,
        color: Colors.white,
      ),
    );
  }
}

/// Oval bottom clipper to clip widget in oval shape at the bottom side
