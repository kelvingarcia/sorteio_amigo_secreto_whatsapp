class Participante {
  final int id;
  final String mongoId;
  final String nome;
  final String numero;
  String pessoaSorteada;

  Participante(
      this.id, this.mongoId, this.nome, this.numero, this.pessoaSorteada);
}
