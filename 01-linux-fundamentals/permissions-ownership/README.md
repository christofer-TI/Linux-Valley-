### Permissions & Ownership ###

1.OBJETIVO
Simular a configuracao de um diretorio de infraestrutura em um Ubuntu Server que sera compartilhado por uma equipe.

O cenario foi criado para praticar:
- criacao de usuarios e grupos;
- permissoes Linux;
- SGID em diretorio;
- colaboracao entre usuarios;
- restricao de acesso a usuarios externos;
- criar uma excecao usando ALC.
###
2.AMBIENTE
Sistema: Ubuntu Server 24.04.5 LTS
Hostname: linux-valley-server
Usuarios:
- server2
- luiz-infra
- christofer-infra
Grupo:
- infra
Diretorio:
- /srv/infra
###
3.IMPLEMENTACAO
# Criacao do grupo:
Foi criado o grupo /infra, utilizado para conrolar o acesso ao diretorio compartilhado.

sudo goupadd infra

# Criacao dos usuarios:
Foram criados os usuarios que participarao da equipe de infraestrutura.

sudo useradd luiz-infra 
sudo useradd christofer-infra

# Durante a implementacao observei se eu tivesse utilizado a opcao -m poderia ter adiantado e otimizado meu tempo na linha de comando, pois tive que configurar senha e diretorio pessol depois.

# Adicao dos usuarios ao grupo:
Os usuarios foram adicionados ao grupo infra.

sudo usermod -aG infra luiz-infra
sudo usermod -aG infra christofer-infra

# Criacao e configuracao do diretorio:
Foi criado o diretorio que sera utilizado pela equipe.

sudo mkdir /srv/infra

O grupo do diretorio foi definido.

sudo chown root:infra /srv/infra

As permissoes foram configuradas com SGID para permitir a colaboracao entre a equipe do grupo infra.

sudo chmod 2770 /srv/infra

# Testes de acesso
Apos a configuracao as exigencias citadas funcionaram 100%, porem, incluimos que um usuario de fora do grupo infra teria que ter acesso a um arquivo.

# Configuracao da ACL
Foi criada uma regra de ACL para permitir uma excecao de acesso a um usuario especifico.

sudo setfact "programa precisa ser instalado antes do uso"

A configuracao foi verificada com:

getfact /srv/infra

# Teste de ACL 
O usuario que nao tinha acesso foi testado novamente e apos a aplicacao da ACL, foi permitido conforme a regra definida

# Validade final 
Foram verificadas as permissoes do diretorio, o SGID e as regras de ACL e os testes confirmaram o funcionamento das permissoes, conforme o objetivo
###

4.RESULTADO
- grupo infra criado.
- usuarios configurados e associados ao grupo.
- /srv/infra configurado o grupo infra.
- permissoes 2770 aplicadas.
- SGID configurado para herenca do grupo.
- usuarios fo grupo conseguiram acessar o diretorio.
- usuario externo teve acesso bloqueado.
- ACL utilizada para criar uma excecao de acesso.
- usuario com ACL conseguiu acessar o diretorio.
###

5.CONCLUSAO
O laboratorio permitiu praticar o gerenciamneto de usuarios, grupos, permissoes Linux, propriedade de arquivos, SGID e ACL. Os testes mostraram a diferenca entre o acesso de usuarios pertencentes ao grupo, usuarios externos e usuarios com uma regra de ACL criada.
