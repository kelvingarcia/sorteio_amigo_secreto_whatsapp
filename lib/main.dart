import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/components/group_box.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Sorteio Amigo Secreto',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            trailing: Text(
              'Editar',
              style: TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
            largeTitle: Text('Amigo Secreto'),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: MyPrefilledSearch(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: BoxGroup(),
                );
              },
              childCount: 20,
            ),
          )
        ],
      ),
    );
  }
}

class MyPrefilledSearch extends StatefulWidget {
  const MyPrefilledSearch({Key? key}) : super(key: key);

  @override
  State<MyPrefilledSearch> createState() => _MyPrefilledSearchState();
}

class _MyPrefilledSearchState extends State<MyPrefilledSearch> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: 'Buscar');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: _textController,
      itemColor: CupertinoColors.placeholderText,
      backgroundColor: CupertinoColors.quaternaryLabel,
    );
  }
}
