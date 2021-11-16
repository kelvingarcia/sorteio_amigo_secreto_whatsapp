import 'participante.dart';

class Grupo {
  final int id;
  final String nome;
  final List<Participante> participantes;

  Grupo(this.id, this.nome, this.participantes);
}