import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  late TextEditingController _textController;
  List<Contact> contactList = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Criar grupo'),
      ),
      child: Container(
        color: CupertinoColors.inactiveGray,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(SizeUtils.fromWidth(context, 0.05)),
                child: SizedBox(
                  height: SizeUtils.fromHeight(context, 0.05),
                  child: CupertinoTextField(
                    controller: _textController,
                    placeholderStyle: const TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                    placeholder: 'Nome do grupo',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(SizeUtils.fromWidth(context, 0.05)),
                child: SizedBox(
                  width: double.maxFinite,
                  child: CupertinoButton(
                    color: CupertinoColors.white,
                    onPressed: () async {
                      final PermissionStatus permissionStatus =
                          await _getPermission();
                      if (permissionStatus == PermissionStatus.granted) {
                        debugPrint('granted');
                        List<Contact> contacts =
                            await ContactsService.getContacts();
                        setState(() {
                          contactList = contacts;
                        });
                      }
                    },
                    child: const Text(
                      'Importar contatos',
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: contactList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Center(
                          child:
                              Text(contactList[index].displayName.toString())),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<PermissionStatus> _getPermission() async {
    debugPrint('Entrou no getPermission');
    final PermissionStatus permission = await Permission.contacts.status;
    debugPrint(permission.toString());
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }
}
