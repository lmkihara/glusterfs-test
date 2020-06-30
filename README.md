# Teste GlusterFS

Este repositório tem apenas o fim de estudo sobre o glusterFS.
As ferramentas que utilizei para criar o ambiente foi o Vagrant c/ VirtualBox, como box o ubuntu/18.04

Para utilizar, basta executar o arquivo start.sh

```console
# ./start.sh
```

Ele ira verificar se você possuí os pacotes necessários para iniciar o ambiente (apenas para distros Debian like).

As instâncias já estão provisionadas por um arquivo bash script, onde ele vai instalar o zfs + gluster e montar o cluster com 3 replicas, e depois montar no diretório /mnt.

Os briks criados ficam em /gluster-file/vol0, isso em todas as máquinas.
