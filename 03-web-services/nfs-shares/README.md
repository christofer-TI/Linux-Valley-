### NFS - Network File System

## Objetivo
Esse laboratorio teve como objetivo configurar um servidor NFS no Ubuntu Server para compartilhar diretorios pela nossa rede local, assim permitindo que outra maquina acesse e manipule arquivos remotamente.
A atividade foi realizada para entender como funciona o compartilhamento de arquivos em um ambiente Linux e como essa funcao pode ser utilizado em uma infraestrutura de rede.

## Ambiente utilizado

Maquina     Endereco IP     Funcao
NFS Server  192.168.1.6     Servidor de arquivos
Cliente     192.168.1.3     Acesso ao compartilhamento

Diretorio compartilhado: /srv/nfs/compartilhado
Ponto de montagem no cliente: /mnt/nfs/compartilhado
Versao do protocolo: NFS4.2

## Configuracao do servidor 
No servidor foi instalado o pacote responsavel pelo NFS.
Apos a instalacao foi criado o diretorio que seria disponibilizado na rede:

sudo mkdir -p /srv/nfs/compartilhado

Em seguida foi configurado o arquivo /etc/exportfs, responsavel por definir quais diretorios serao compartilhados e quais maquinas poderao acessa-los.

Configuracao utilizada:

/srv/nfs/compartilhado 192.168.1.3(rw,sync,no_subtree_check)

## Configuracao do cliente
Na maquina cliente foi instalado o pacote necessario para acessar o compartilhamento NFS.
Foi criado o diretorio que recebia a montagem:

sudo mkdir -p /mnt/nfs/compartilhado

A montagem foi realizada utilizadno o endereco IP do servidor:

sudo mount -t nfs4 192.168.1.6:/srv/nfs/compartilhado /mnt/nfs/compartilhado

## Montagem automatica 
Para manter o compartilhamento disponivel apos reiniciar a maquina, foi adiconado uma entrada no arquivo /etc/fstab:

192.168.1.6:/srv/nfs/compartilhado /mnt/nfs/compartilhado nfs defaults,_netdev,nofail 0 0 

As opcoes_netdev e nofail forma utilizada para levar em conta a depdndencia da rede e evitar que a indisponiblidade do servidor impeca a inicializacao do cliente.

## Testes realizados 
1. Verificacao da exportacao

No servidor:
sudo exportfs -v

O resultado confirmou que o diretorio estava exportando para o endereco IP do cliente.

2. Verificacao fa montagem

No cliente:
findmnt /mnt/nfs/compartilhado

FOi identificada a montagem do NFS.

## Teste de leitura e escrita
Foi criado um arquivo no cliente:

touch /mnt/nfs/compartilhado/teste-cliente.txt

Depois foram adicionados conteudos dentro do arquivo criado e posteriormente foi consultado e visto no servidor.
O resultado confirmou que as alteracoes realizadas pelo cliente estavam constando no diretorio compartilhado do servidor.

## Teste apos reinicializacao
Apos reiniciar as maquinas, o cliente conseguiu acessar novamente o compartilhamento e consultar os arquivos que havia la.
Esse teste confirmou a montagem automatica configurada no /etc/fstab.

## Conclusao
Com esse laboratorio consegui entender na pratica como funciona o NFS e como disponibilizar diretorios de um servidor Linuc para outras maquinsa na rede.
Tambem pratiquei a configuracao de permissoes de exportacao, montagem dew sistemas de arquivos remotos e montagem automatica para inicializacao.
O lab ajudou a entender como o compartilhamento de arquivos pode ser utilizado em ambientes de infra linux.
