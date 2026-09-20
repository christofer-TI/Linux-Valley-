### process management ###

1.OBJETIVO
Simular a criacao de um scrirpt para gastar recursos do sistema, assim praticar o uso de ferramentas de diagnostico para achar o processo, inveetigar a sua origem e entedner os riscos de apagar um arquivo direto sem antes analisar o impacto disso.

O cenario foi criado para praticar:
- criar um script que gera consumo de CPU e memoria;
- usar e interpretar a ferramenta htop para acahr o problema;
- rastrear quem iniciou o processo;
- verificar se o arquivo e seguro ou critico para o sistema;
- resolver o problema ocm seguranca sem quebrar o servidor,
###
2.AMBIENTE 
Sitema: Ubuntu Server 24.04.5 TLS
Hostname: linux-valley-server
Utilizador:
- server2
    caminho do script de teste:
    /opt/linux-valley/worker/worker.sh
###
3.IMPLEMENTACAO
Criacao do script de teste:
criei um script com a ideia de simular um uso grande de recursos para praticar a inventigacao:
- funcionalides que incluimos;
- Variaveis e logs: Configuramos o nome da aplicacao e um ficheiro de registo (/var/log/linux-valley-worker.log) para guardar o historico de cada tarefa executada.
- Processamento de tarefas (CPU): Colocamos um ciclo matematico pesado (contas a multiplicar de 1 ate 8 milhoes) a correr em background (&) para forcar o processador (CPU) a trabalhar no maximo.
- Consumo de Memoria RAM: Usamos o comando dd para criar um ficheiro temporario de 120 Megas dentro da memoria RAM (/dev/shm), simulando um programa a gastar muita memoria. Em seguida, o script limpa e apaga esse ficheiro para repetir o ciclo.
- Ciclo infinito (while true): Colocamos o worker a correr num ciclo sem fim para garantir que ele continuava a gerar carga de forma repetida.
###
4.INVESTIGACAO DO PROBLEMA
O servidor comecou a ficar lento. Para descobrir o que estava gerando e problema utilizamos primeiro o comando;

uptime - comando que nos da o load average, que sinaliza se a pressao sobre CPU ou I/O.
constou 100,7%CPU

Assim abrimos o htop - ferramenta do terminal que nos da uma visao ampla dos processos acontecendo em tempo real.
como usei e interpretei a sadia do htop:
- olhar para as varras coloridasd no topo (CPU%MEM) para ver qual nucleo ou recurso estava no maximo.
- na lista de processos, procuramos pelos nome sque apareciam mais vezes ou que consumiam mais percentagem (%CPU%MEM)
- identifiquei carias linhas com /bin/bash /opt/linux-valley/worker/worker.sh consumindo muito recursos na mesma sessao de terminal.

Com o causador achado, precisamos comecar uma investigacao para entender o que ele e e o que afeta;
- investigamos os agendamentos
verifiquei se existia alguma tarefa automatizada com crontab a rodar o script sozinho, mas nao foi encontrado nada

crontab -l 
sudo grep -l :worker.sh" /etc/cron* /etc/crontab

Rastrear a origem do processo:
- como nao era um processo automatizado, usei a arvore de processos para descobrir de onde ele veio:

ps -ef --forest | grep worker.sh

O resultado mostrou que o processo foi iniciado manualmente numa sessao de terminal (pts/0), ou seja, alguem executou varias vezes seguidas sem controlo.

Analisamos o impacto (kill direto)
- antes de simplesmente excluir o processo ou o arquivo, fomos veridicar se ele er aum arquivo importante para o sistema. Descobri que ele estava em uma pasta de teste (/opt) e pertencia a um usuario comum, o que garantiu que nao era algo critico para o sistema.

kill -9 PID/numero do processo

Solucao e limpeza
Fechamos os processos que estavam presos em loop e validamos que a maquian voltou ao normal:

uptime 
###
4.RESULTADO
- criamos um script para gerar consumo de recursos e testar a investigacao.
- aprendemos a usar o htop e a interpretar as barras de recursos e as colunas de processos para achar o culpado.
- descartamos a hipotese de ser um erro do agendamento automatico do sistema.
- descobrimos atraves da arvore de processos que ele foi aberto manualmente no terminal.
- entendemos a importancia de verificar se o arquivo e critico antes de fazer qualquer exclusao.
- limpamos os processos e o servidor recuperou a performance normal.

5.CONCLUSAO
Este laboratorio foi muito util para aprender a investigar problemas de lentidao no Linux passo a passo. Vimos que saber usar o htop ajuda muito a localizar o foco do problema, e que nunca devemos apagar coisas sem antes pesquisar o que sao e quem as criou, evitando assim estragar o servidor.   
