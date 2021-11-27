class Participante {
  final int id;
  String mongoId;
  final String nome;
  final String numero;
  String pessoaSorteada;
  List<String> exclusoes;
  bool enviado;

  Participante(this.id, this.mongoId, this.nome, this.numero,
      this.pessoaSorteada, this.exclusoes, this.enviado);

  @override
  String toString() {
    return '{mongoId: $mongoId, nome: $nome, numero: $numero, pessoaSorteada: $pessoaSorteada, exclusoes: $exclusoes, enviado: $enviado }';
  }
}
