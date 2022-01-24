import 'package:flutter/cupertino.dart'; //ios  스타일
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; //스크롤
import 'package:provider/provider.dart';
//
import '../data/store.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Store1>().getData();
    // print(context.watch<Store1>().follower);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store1>().name)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (c,i) => Container(
                  child: Image.network(context.read<Store1>().profileImage[i]),
                ),
                childCount: context.read<Store1>().profileImage.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          )
        ],
      )
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.contacts),
        Text('팔로워 ${context.watch<Store1>().follower}명'),
        ElevatedButton(onPressed: (){
          context.read<Store1>().follow();
        }, child: Text('팔로우')),
      ],
    );
  }
}

