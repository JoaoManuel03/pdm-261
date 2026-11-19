import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

// --- MODELO DE DADOS ---
class Aluno {
  final int id;
  final String nome;
  final String disciplina;
  final double media;
  final int faltas;

  const Aluno({
    required this.id,
    required this.nome,
    required this.disciplina,
    required this.media,
    required this.faltas,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'disciplina': disciplina,
      'media': media,
      'faltas': faltas,
    };
  }
}

// --- BANCO DE DADOS EM MEMÓRIA ---
final List<Aluno> alunos = [
  const Aluno(id: 1, nome: 'Ana Souza', disciplina: 'Programação', media: 8.5, faltas: 4),
  const Aluno(id: 2, nome: 'Bruno Lima', disciplina: 'Estrutura de Dados', media: 5.0, faltas: 10),
  const Aluno(id: 3, nome: 'Carla Mendes', disciplina: 'Banco de Dados', media: 7.5, faltas: 22),
  const Aluno(id: 4, nome: 'Diego Oliveira', disciplina: 'Redes', media: 4.5, faltas: 25),
];

// --- FUNÇÃO PRINCIPAL ---
void main() async {
  final pipeline = const Pipeline().addMiddleware(logRequests());
  
  final handler = pipeline.addHandler((Request request) {
    final caminho = request.url.path;

    // ROTA 1: http://localhost:8080/alunos (Retorna o JSON puro dos dados)
    if (caminho == 'alunos' && request.method == 'GET') {
      final alunosJson = alunos.map((aluno) => aluno.toJson()).toList();
      return Response(
        HttpStatus.ok,
        body: jsonEncode(alunosJson),
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }

    // ROTA 2: http://localhost:8080/ (Processa as condições e exibe o relatório formatado no navegador)
    if ((caminho == '' || caminho == '/') && request.method == 'GET') {
      final buffer = StringBuffer();
      buffer.writeln('--- Relatório de Alunos ---');
      
      for (var aluno in alunos) {
        String status;

        // Teste das condições (Mensagem Única)
        if (aluno.faltas > 20) {
          status = 'Reprovado por Faltas';
        } else if (aluno.media < 6.0) {
          status = 'Reprovado';
        } else {
          status = 'Aprovado';
        }

        buffer.writeln('Aluno: ${aluno.nome} | Disciplina: ${aluno.disciplina} | Média: ${aluno.media} | Faltas: ${aluno.faltas} -> Situação: $status');
      }

      return Response(
        HttpStatus.ok,
        body: buffer.toString(),
        headers: {HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8'},
      );
    }
    
    return Response.notFound('Rota não encontrada');
  });

  // O servidor intercepta conexões locais na porta 8080 de forma contínua
  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
  print(' Servidor HTTP ligado e aguardando conexões!');
  print(' Para ver o Relatório de Condições no navegador acesse: http://localhost:8080/');
  print(' Para ver os dados JSON brutos acesse: http://localhost:8080/alunos');
  print(' Para desligar o servidor, pressione CTRL + C neste terminal.');
}
