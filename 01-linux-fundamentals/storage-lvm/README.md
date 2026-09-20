# Laboratório de Gestão de Armazenamento com LVM

1.OBJETIVO
Simular a criação de um disco flexível usando LVM em um servidor Ubuntu, para resolver o problema de falta de espaço de uma aplicação.
O que pratiquei neste laboratório:
- adicionar um disco novo na máquina virtual;
- preparar o disco para ser usado pelo LVM (Physical Volume);
- juntar o espaço num grupo (Volume Group);
- criar e aumentar o espaço do disco da aplicação (Logical Volume);
- atualizar o tamanho com o comando pvresize;
- formatar e ligar o disco (ponto de montagem) sem precisar de desligar o servidor.
###
2.AMBIENTE
Sistema: Ubuntu Server 24.04.5 LTS
Hostname: linux-valley-server
Disco usado: /sdb
Nome do Grupo (VG): vg-dados
Nome do Disco da Aplicação (LV): lv-app
Pasta onde foi ligado: /mnt/app-data
###
3.IMPLEMENTACAO
Como colocar o disco na máquina virtual (para quem quiser testar):
- ir para as configurações da VMs (por exemplo, no VirtualBox) e adicionar um novo disco rígido.
- reiniciar a VMs para que o Ubuntu reconheça o novo disco como /sdb.

Preparar o disco (Physical Volume):
Avisei o sistema para preparar o disco novo para o LVM:
- sudo pvcreate /dev/sdb

Criar o Grupo de Discos (Volume Group):
Juntei o espaço do disco num "armazém" central:
- sudo vgcreate vg-dados /dev/sdb

Criar o Disco da Aplicação (Logical Volume):
Criei um espaço de 2GB dentro desse grupo para a aplicação usar:
- sudo lvcreate -n lv-app -L 2G vg-dados

Formatar o disco:
Preparei o disco com o sistema de arquivo para poder começar a guardar dados:
- sudo mkfs.ext4 /dev/vg-dados/lv-app

Ligar o disco à pasta (Montagem):
Criei a pasta de destino e liguei o nosso disco LVM a ela:
- sudo mkdir -p /mnt/app-data
- sudo mount /dev/vg-dados/lv-app /mnt/app-data

Simular o aumento de espaço (Produção):
Para simular que aumentamos o disco no painel e precisavamos de usar esse novo espaço sem desligar nada:
Atualizei o tamanho do disco físico no LVM:
- sudo pvresize /dev/sdb
Aumentei o espaço do disco lógico em mais 1GB de uma vez só:
- sudo lvextend -L +1G -r /dev/vg-dados/lv-app

Confirmação final:
Usei o comando abaixo para ver se o espaço subiu para 3GB sem apagar nada:
- df -h /mnt/app-data

4.RESULTADO
- o disco /sdb ficou ligado ao LVM com sucesso.
- o grupo vg-dados ficou pronto a usar.
- o disco lv-app foi criado, formatado e ligado a /mnt/app-data.
- fiz testes a encher o disco com um script para ver o espaço a ser gasto.
- consegui aumentar o espaço com o servidor a trabalhar, sem perder nenhum dado.

5. CONCLUSAO
Este laboratório ajudou a entender como funciona a gestao de discos no Linux de forma flexível, permitindo aumentar o espaço de um sistema em produção sem precisar de o desligar.
