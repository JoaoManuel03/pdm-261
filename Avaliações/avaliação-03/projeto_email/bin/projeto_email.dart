import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  // Configuração das credenciais do Gmail
  final String username = 'joaomanueldiaslopes03@gmail.com'; 
  final String appPassword = 'xxxx.xxxx.xxxx.xxxx'; // Use a Senha de App de 16 caracteres do Google

  // Configuração do servidor SMTP do Gmail
  final smtpServer = gmail(username, appPassword);

  // Criação da mensagem de e-mail
  final message = Message()
    ..from = Address(username, 'João Lopes')
    ..recipients.add('dias.lopes62@aluno.ifce.edu.br') // E-mail de destino
    ..subject = 'Evidência de Envio - Projeto Dart'
    ..text = 'Olá!\n\nEste e-mail foi transmitido com sucesso através de um programa escrito em Dart.'
    ..html = '<h3>Envio de E-mail via Dart</h3><p>Este e-mail foi transmitido com sucesso usando o pacote <b>mailer</b>.</p>';

  try {
    print('Enviando e-mail...');
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado com sucesso! Relatório: ${sendReport.toString()}');
  } on MailerException catch (e) {
    print('Erro ao enviar e-mail: ${e.toString()}');
    for (var p in e.problems) {
      print('Problema identificado: ${p.code}: ${p.msg}');
    }
  }
}