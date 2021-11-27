import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';

class Exceptions extends StatefulWidget {
  final List<Contact> contactList;
  final Participante? participante;

  const Exceptions({
    Key? key,
    this.contactList = const [],
    this.participante,
  }) : super(key: key);

  @override
  _ExceptionsState createState() => _ExceptionsState();
}

class _ExceptionsState extends State<Exceptions> {
  late TextEditingController _textController;
  List<Contact> _contactSubList = [];
  final List<bool> _boolList = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _contactSubList = widget.contactList;
    _contactSubList.forEach((element) {
      _boolList.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Exceções'),
      ),
      child: SafeArea(
        child: Container(
          height: SizeUtils.fromHeight(context, 1),
          color: CupertinoColors.inactiveGray,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    controller: _textController,
                    itemColor: CupertinoColors.placeholderText,
                    backgroundColor: CupertinoColors.white,
                    onChanged: (text) {
                      setState(() {
                        if (text != '' && !text.startsWith(' ')) {
                          _contactSubList = widget.contactList
                              .where((element) => element.displayName!
                                  .toLowerCase()
                                  .startsWith(text.toLowerCase()))
                              .toList();
                        } else {
                          _contactSubList = widget.contactList;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: _contactSubList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MergeSemantics(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _contactSubList[index].displayName!,
                            ),
                            CupertinoSwitch(
                              value: _boolList[index],
                              onChanged: (bool value) {
                                if (value) {
                                  widget.participante!.exclusoes
                                      .add(_contactSubList[index].displayName!);
                                } else {
                                  widget.participante!.exclusoes.removeWhere(
                                      (element) =>
                                          element ==
                                          _contactSubList[index].displayName!);
                                }
                                debugPrint(
                                    widget.participante!.exclusoes.toString());
                                setState(() {
                                  _boolList[index] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
