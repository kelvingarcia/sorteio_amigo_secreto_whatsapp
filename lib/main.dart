import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/screens/create_group.dart';
import 'components/group_box.dart';
import 'database/grupo_dao.dart';
import 'model/grupo.dart';

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
  GrupoDao _dao = GrupoDao();
  List<Grupo> _grupos = [];

  @override
  void initState() {
    _dao.findAll().then((value) {
      setState(() {
        _grupos = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            leading: GestureDetector(
              onTap: () {
                _dao.deleteAll();
                _dao.findAll().then((value) {
                  setState(() {
                    _grupos = value;
                  });
                });
              },
              child: const Text(
                'Editar',
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                ),
              ),
            ),
            trailing: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const CreateGroup(),
                    ),
                  );
                  _dao.findAll().then((value) {
                    setState(() {
                      _grupos = value;
                    });
                  });
                },
                child: const Icon(CupertinoIcons.add)),
            largeTitle: const Text('Amigo Secreto'),
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
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CreateGroup(
                            grupo: _grupos[index],
                          ),
                        ),
                      ).then((value) {
                        _dao.findAll().then((value) {
                          setState(() {
                            _grupos = value;
                          });
                        });
                      });
                    },
                    child: BoxGroup(
                      nomeGrupo: _grupos[index].nome,
                      quantidadePessoas: _grupos[index].participantes.length,
                    ),
                  ),
                );
              },
              childCount: _grupos.length,
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
    _textController = TextEditingController();
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
