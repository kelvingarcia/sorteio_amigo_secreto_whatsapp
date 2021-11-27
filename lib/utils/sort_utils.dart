import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';

class SortUtils {
  static List<Participante> sortPeople(List<Participante> participantes) {
    List<Participante> shuffledList = List.from(participantes);
    int i = 0;
    int tentativas = 1;
    while (i < 10) {
      shuffledList.shuffle();
      bool passedExclusion = _testExclusions(shuffledList);
      if (passedExclusion) {
        i++;
      } else {
        tentativas = i + 1;
        i = 10;
      }
    }
    debugPrint('tentativas: ' + tentativas.toString());
    return shuffledList;
  }

  static bool _testExclusions(List<Participante> shuffledList) {
    for (int i = 0; i < shuffledList.length - 1; i++) {
      if (shuffledList[i].exclusoes.contains(shuffledList[i + 1].nome)) {
        return true;
      }
      shuffledList[i].pessoaSorteada = shuffledList[i + 1].nome;
    }
    if (shuffledList[shuffledList.length - 1]
        .exclusoes
        .contains(shuffledList[0].nome)) {
      return true;
    }
    shuffledList[shuffledList.length - 1].pessoaSorteada = shuffledList[0].nome;
    return false;
  }
}
