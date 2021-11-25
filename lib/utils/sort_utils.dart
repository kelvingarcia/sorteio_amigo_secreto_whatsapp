import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';

class SortUtils {
  static List<Participante> sortPeople(List<Participante> participantes) {
    List<Participante> shuffledList = List.from(participantes);
    shuffledList.shuffle();
    for (int i = 0; i < shuffledList.length - 1; i++) {
      shuffledList[i].pessoaSorteada = shuffledList[i + 1].nome;
    }
    shuffledList[shuffledList.length - 1].pessoaSorteada = shuffledList[0].nome;
    return shuffledList;
  }
}
