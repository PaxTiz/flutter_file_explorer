import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/file_explorer/file_explorer_grid.dart';
import './components/layout/app_bar.dart';
import './components/sidebar/sidebar.dart';
import './components/sidebar/sidebar_resizer.dart';
import './core/stores/directory_store.dart';
import './core/stores/sidebar_store.dart';
import 'core/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DirectoryStore()),
        ChangeNotifierProvider(create: (_) => SidebarStore()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SF Pro Text',
          primarySwatch: Colors.blue,
          backgroundColor: CupertinoColors.lightBackgroundGray,
          textTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ).apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          fontFamily: 'SF Pro Text',
          backgroundColor: dark0,
          textTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            errorStyle: TextStyle(color: red),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
        ),
        home: FileExplorer(),
      ),
    );
  }
}

class FileExplorer extends StatefulWidget {
  @override
  createState() => _FileExplorer();
}

class _FileExplorer extends State<FileExplorer> {
  double width = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(width: width),
          SidebarResizer(
            onResize: (w) => setState(() => width = w),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: dark1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  FileExplorerGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
