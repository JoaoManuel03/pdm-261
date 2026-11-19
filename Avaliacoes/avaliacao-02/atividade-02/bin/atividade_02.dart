import 'dart:convert' show JsonEncoder;
// 14-agregacao.dart  
// Agregação e Composição

class Dependente {
  late String _nome;

  Dependente(String nome) {
    _nome = nome;
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    _nome = nome;
    _dependentes = dependentes;
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }
}





void main() {
  // 1. Criar varios objetos Dependentes
  var dep1 = Dependente("Pedro Silva");
  var dep2 = Dependente("Maria Silva");
  var dep3 = Dependente("Lucas Souza");
  var dep4 = Dependente("Enzo Lima");
  var dep5 = Dependente("Valentina Lima");
  var dep6 = Dependente("Beatriz Costa");

  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos funcionarios
  var func1 = Funcionario("João Silva", [dep1, dep2]);
  var func2 = Funcionario("Ana Souza", [dep3]);
  var func3 = Funcionario("Carlos Oliveira", []); // Sem dependentes
  var func4 = Funcionario("Roberto Lima", [dep4, dep5]); // Dois dependentes
  var func5 = Funcionario("Juliana Costa", [dep6]); // Um dependente
  var func6 = Funcionario("Fernando Alves", []); // Sem dependentes

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> listaFuncionarios = [
    func1, 
    func2, 
    func3, 
    func4, 
    func5, 
    func6
  ];

  // 5. Criar um objeto Equipe Projeto chamando o metodo construtor
  var equipe = EquipeProjeto("Plataforma de E-Commerce", listaFuncionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto.
  Map<String, dynamic> equipeJson = {
    "nomeProjeto": equipe._nomeProjeto,
    "funcionarios": equipe._funcionarios.map((f) => {
      "nome": f._nome,
      "dependentes": f._dependentes.map((d) => {
        "nome": d._nome
      }).toList()
    }).toList()
  };

  String jsonFormatado = JsonEncoder.withIndent('  ').convert(equipeJson);
  print(jsonFormatado);
}
