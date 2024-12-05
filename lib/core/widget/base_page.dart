import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_drawer.dart';

class BasePage extends StatefulWidget {
  final String? title;
  final Widget content;
  final bool isScrollable;
  final bool isCentered;
  final bool hasPadding;
  final bool hasMenu;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;


  const BasePage({
    super.key,
    this.title,
    required this.content,
    this.isScrollable = true,
    this.isCentered = false,
    this.hasMenu = true,
    this.hasPadding = true, this.appBar, this.floatingActionButton, this.bottomNavigationBar,
  });

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lighterGray,
      key: _scaffoldKey,
      bottomNavigationBar: widget.bottomNavigationBar != null ? Padding(
        padding: const EdgeInsets.all(10.0),
        child: widget.bottomNavigationBar,
      ) : null ,
      appBar: widget.appBar ?? AppBar(
        backgroundColor: AppColors.lighterGray,
        leading: widget.hasMenu ? IconButton(
          icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              colorFilter: const ColorFilter.mode(Color(0xff555555), BlendMode.srcIn),
              semanticsLabel: 'menu'
          ),
          onPressed: () {
            // Open the drawer or execute custom logic here
            _scaffoldKey.currentState?.openDrawer();
          },
        ) : null,
        title: Text(widget.title ?? '', style: AppStyles.headline,),
        centerTitle: true,
      ),
      drawer: widget.hasMenu ? const CustomDrawer() : null,
      body: widget.hasPadding ? Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.hasPadding ? 10 : 0),
        child: widget.isCentered ?
        Center(child: widget.isScrollable ? SingleChildScrollView(child: widget.content) : widget.content)
            :
        widget.isScrollable ? SingleChildScrollView(child: widget.content) : widget.content,
      ) : widget.content,

    );
  }
}
