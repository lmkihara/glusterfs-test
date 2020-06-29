#Teste GlusterFS

Esse é apenas um teste utilizando glusterfs como servidor de arquivos.
Esta configurado para 3 replicas, utilizando zfs.

Para poder utiliza-lo é necessário do virtualbox e vagrant instalados.

Escute o arquivo start.sh, ele ira realizar uma checkagem se tem todos os pacotes instalados, assim ele ira executar o arquivo Vagrantfile e provisionar as instancias com o arquivo bash script "gluster-install.sh".

Após inicializado execute o comando "vagrant ssh srv-gluster-01" e ir na pasta /mnt onde esta montado o disco do gluster.

Inclua alguns arquivos e veja nos outros servidores ele sendo replicado.