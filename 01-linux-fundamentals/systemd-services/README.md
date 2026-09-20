# Systemd Services

1.OBJETIVO
Simular o gerenciamento de uma aplicação no Linux utilizando o systemd, criando um serviço e praticando o controle, monitoramento e recuperação desse serviço.
O cenário foi criado para praticar:
- criar uma aplicação simples para ser executada como serviço;
- criar e configurar um arquivo `.service`;
- iniciar e controlar um serviço com `systemctl`;
- relacionar o serviço com o processo em execução;
- configurar reinicialização automática em caso de falha;
- configurar o serviço para iniciar junto com o sistema;
- utilizar os logs para investigar problemas;
- simular uma falha de configuração e recuperar o serviço com segurança.
###
2.AMBIENTE
Sistema: Ubuntu Server 24.04.5 LTS
Hostname: linux-valley-server
Virtualização: VirtualBox
Utilizador: server2

Caminho da aplicação de teste:
- /opt/linux-valley/app-systemd.py

Serviço criado:
- linux-valley-app.service

Arquivo da Unit:
/etc/systemd/system/linux-valley-app.service
###
3.IMPLEMENTAÇÃO
- Criação da aplicação de teste
Criei uma aplicação simples em Python para simular um programa rodando continuamente no servidor.
A aplicação mostra mensagens no terminal e permanece em execução em ciclo infinito.
O objetivo não era estudar Python, mas ter um processo real para trabalhar com o systemd, observar seu PID e testar situações de falha e recuperação.

- Criação do serviço
Depois de testar a aplicação manualmente, criei uma Unit personalizada do `systemd` chamada:
- linux-valley-app.service

A Unit foi criada dentro de:
- /etc/systemd/system/

A configuração foi dividida nas três partes principais:
- [Unit] — informações e dependências do serviço;
- [Service] — define como a aplicação será executada;
- [Install] — define como o serviço será relacionado à inicialização do sistema.

A configuração completa da Unit está no arquivo:
- linux-valley-app.service

4.GERENCIAMENTO DO SERVIÇO
Depois de criar a Unit, recarreguei as configurações do systemd e iniciei o serviço.
Utilizei:
- sudo systemctl daemon-reload
- sudo systemctl start linux-valley-app.service
- systemctl status linux-valley-app.service

O serviço ficou com o estado:
- Active: active (running)

Também podemos visualizar o PID do processo principal.
Na primeira execução, o processo recebeu o PID 1762

- Relacionando o serviço com o processo
Para entender a relação entre o systemd e da aplicação, olhei o processo através do:
- ps -fp 1762

O resultado mostrou que o processo estava sendo executado pelo usuário root e possuía o systemd como processo pai, através do PID 1.
Também foi possível visualizar o processo dentro do cgroup:
- /system.slice/linux-valley-app.service
Isso ajudou a entender que o systemd não é apenas responsável por iniciar o programa, mas também por acompanhar e controlar o processo.
###
5.TESTE DE REINICIALIZAÇÃO AUTOMÁTICA
Para testar a configuração:
- Restart=always

encerrei manualmente o processo que estava sendo executado.
Utilizei:
- sudo kill 1762

- Depois verifiquei novamente os processos e o status do serviço.
O processo antigo foi encerrado e o systemd iniciou automaticamente uma nova instância.
O novo processo recebeu o PID: 1781

- Também foi possível visualizar no log que o systemd havia agendado uma nova tentativa de inicialização.
Esse teste mostrou na prática como o Restart=always pode ajudar a manter uma aplicação em execução caso o processo seja encerrado inesperadamente.
###
6.INICIALIZAÇÃO AUTOMÁTICA
Depois de confirmar que o serviço estava funcionando, configurei para que ele fosse iniciado automaticamente junto com o sistema.
Utilizei:
- sudo systemctl enable linux-valley-app.service
- systemctl is-enabled --now linux-valley-app.service

O resultado foi:
- enabled

Também verifiquei a relação do serviço com o:
- multi-user.target
###
7.TESTE APÓS REINICIAR O SERVIDOR
Para confirmar se a configuração realmente funcionava após uma reinicialização, reiniciei a máquina:
- sudo reboot

Depois de conectar novamente ao servidor, consultei o serviço:
- systemctl status linux-valley-app.service

O resultado mostrou novamente:
- Active: active (running)

O serviço havia iniciado automaticamente e recebeu um novo PID: 598
Confirmei que o serviço não dependia mais de uma inicialização manual após o servidor ser reiniciado
###
8.SIMULAÇÃO DE UMA FALHA
Depois de testar o funcionamento, simulei uma situação que poderia acontecer durante a alteração de configuração em um servidor.
Alterei o caminho definido no ExecStart para apontar para um arquivo que não existia:
- /opt/linux-valley/app-systemd-erro.py

Depois recarreguei a configuração do systemd e tentei reiniciar o serviço.
O serviço passou para o estado:
- Active: failed

O systemd tentou iniciar o serviço algumas vezes por causa do:
- Restart=always

Mas como o arquivo informado no ExecStart não existia, as tentativas continuaram falhando
###
9.INVESTIGAÇÃO DO ERRO
Para descobrir o motivo da falha, primeiro consultei o estado do serviço:
- systemctl status linux-valley-app.service

Depois consultei os logs específicos da Unit:
- journalctl -u linux-valley-app.service -n 20 --no-pager

Nos logs encontrei o erro:
- python3: can't open file '/opt/linux-valley/app-systemd-erro.py': [Errno 2] No such file or directory

Com isso foi possível identificar que o problema não estava no systemd em si.
O problema era o caminho incorreto definido no ExecSart.

Confirmei que o arquivo correto existia:
- ls -l /opt/linux-valley/app-systemd.py
###
10.CORREÇÃO DO PROBLEMA
Depois de identificar a causa, corrigi o ExecStart para apontar novamente para:
- /opt/linux-valley/app-systemd.py

Em seguida, recarreguei a configuração do systemd e iniciei novamente o serviço.
- sudo systemctl daemon-reload
- systemctl start linux-valley-app.service
- systemctl status linux-valley-app.service

Depois da correção, o serviço voltou para:
- Active: active (running)

O novo processo recebeu o PID:1299
Também foi possível visualizar novamente as mensagens da aplicação no journal.
###
11.RESULTADO
- criamos uma aplicação simples para ser executada como um serviço;
- criamos uma Unit personalizada utilizando o systemd;
- aprendemos a controlar o serviço através do systemctl;
- relacionamos o serviço com o processo e seu PID;
- testamos a reinicialização automática utilizando Restart=always;
- configuramos a inicialização automática durante o boot;
- reiniciamos o servidor e confirmamos que o serviço voltou automaticamente;
- simulamos uma falha alterando o caminho do ExecStart;
- utilizamos o systemctl status e o journalctl para investigar o problema;
- identificamos o erro através da mensagem registrada no journal;
- corrigimos a configuração e recuperamos o serviço.
###
12.CONCLUSAO
Este laboratorio foi importante para entender melhor como o systemd funciona e como ele controla os serviços no Linux.
Na pratica, consegui ver que nao basta apenas iniciar um programa. Tambem e importante saber como o servico foi configurado, qual processo esta rodando, qual e o seu PID, se ele inicia junto com o sistema e como descobrir o motivo quando alguma coisa da errado.
A parte da falha tambem foi importante, porque conseguimos simular um problema que pode acontecer durante uma alteracao em um servidor. Um caminho errado na configuracao foi suficiente para impedir o serviço de iniciar.
O principal aprendizado foi entender que, quando um serviço apresenta problema, temosque investigar antes de sair alterando ou apagando coisas. Primeiro verificamos o status, depois os logs, encontramos a causa, corrigimos a configuração e testamos novamente para confirmar que o servico voltou a funcionar.


























