# DNS Cache - BIND9

1.OBJETIVO
Neste laboratorio configurei um servidor DNS recursivo com cache utilizando o BIND9.
O objetivo foi entender como funciona a resolucao recursiva de nomes, o encaminhamento de consultas para servidores DNS externos e o armazenamento temporario de respostas em cache.
Tambem realizei testes para comparar o tempo de resposta entre consultas consecutivas e compreender como o cache reduz a necessidade de novas consultas externas.
###

2.AMBIENTE
- Ubuntu Server 24.04.5 LTS
- BIND9
- VirtualBox
- Servidor DNS Master: 192.168.1.3
- Servidor DNS Cache: 192.168.1.4
- Servidor DNS Slave: 192.168.1.35
- Cliente: 192.168.1.6
- Rede: 192.168.1.0/24
- Encaminhador DNS externo: 8.8.8.8
###

3.CONFIGURACAO DO CACHE DNS
O servidor foi configurado para realizar consultas DNS recursivas e encaminhar consultas externas para servidores DNS definidos na configuracao do BIND9.
O funcionamento do laboratorio envolve tres componentes principais:
- Cliente: envia consultas DNS para o servidor de cache.
- Servidor DNS Cache: verifica se possui uma resposta valida armazenada. Caso contrario, encaminha a consulta para obter a resposta.
- Servidor DNS Autoritativo: fornece respostas autoritativas para as zonas pelas quais e responsavel.

O BIND9 armazena temporariamente as respostas recebidas, respeitando o TTL (Time To Live) dos registros DNS.

Arquivos de configuracao utilizados:
- named.conf.options
- named.conf.local
###

4.FUNCIONAMENTO DO CACHE
O laboratorio permitiu observar o comportamento do servidor DNS durante duas consultas consecutivas.
Na primeira consulta, o cliente enviou uma requisicao ao servidor de cache. Como a resposta ainda nao estava armazenada, o servidor realizou uma consulta ao servidor autoritativo e retornou o resultado ao cliente.
Na segunda consulta, o servidor de cache ja possuia a resposta armazenada e conseguiu responder diretamente, sem precisar consultar novamente o servidor autoritativo.
O servidor de cache tambem conseguiu resolver nomes pertencentes a zona interna configurada no laboratorio.
Esse comportamento demonstrou a diferenca entre uma consulta que precisa obter uma resposta externa e outra que pode utilizar uma resposta ja armazenada.
###

5.VALIDACAO
A configuracao do BIND9 pode ser verificada com:
- sudo named-checkconf

Para verificar o estado do servico:
- sudo systemctl status bind9

Esses comandos ajudam a identificar erros de configuracao e verificar se o servico esta funcionando corretamente.
###

6.TESTES DNS
Durante o laboratorio, foram realizadas consultas DNS para verificar a comunicacao entre o cliente, o servidor de cache e o servidor autoritativo.
O fluxo de consultas observado foi:
- O cliente enviou uma consulta ao servidor DNS Cache.
- O servidor de cache encaminhou a consulta quando nao possuia uma resposta armazenada.
- O servidor autoritativo respondeu com os registros da zona pela qual e responsavel.
- O servidor de cache retornou a resposta ao cliente e armazenou os dados conforme o TTL.
- Em uma nova consulta, o servidor de cache respondeu utilizando a informacao armazenada.

As consultas tambem demonstraram que o servidor de cache consegue resolver nomes internos, alem de realizar consultas para dominios externos.
###

7.ANALISE DO TEMPO DE RESPOSTA
Foram realizadas consultas consecutivas para observar a diferenca no tempo de resposta.
Na primeira consulta, o tempo registrado foi de aproximadamente 42 ms. Na consulta seguinte, o tempo caiu para aproximadamente 0 ms.
Em outro teste, o tempo de resposta passou de aproximadamente 61 ms para 1 ms.
Esses resultados demonstraram como o cache pode reduzir o tempo necessario para responder consultas repetidas.
O TTL tambem foi observado durante os testes, apresentando valores menores na segunda consulta, comportamento esperado quando uma resposta armazenada continua valida.
Os tempos registrados correspondem ao ambiente de laboratorio e podem variar conforme a rede, o estado do cache e o destino consultado.
###

8.RESULTADO
Ao final deste laboratorio, configurei e testei um servidor DNS recursivo com cache utilizando o BIND9.
Foi possivel compreender:
- O funcionamento de um resolvedor DNS recursivo.
- O encaminhamento de consultas para servidores DNS externos.
- A comunicacao entre o servidor de cache e o servidor autoritativo.
- O armazenamento temporario de respostas DNS.
- A utilizacao do TTL para controlar a validade das respostas armazenadas.
- A resolucao de nomes internos pelo servidor de cache.
- A reducao do tempo de resposta em consultas consecutivas.

O laboratorio demonstrou como o cache DNS melhora a eficiencia da resolucao de nomes, reduzindo consultas repetidas aos servidores autoritativos e diminuindo o tempo de resposta para consultas que podem ser atendidas localmente.
