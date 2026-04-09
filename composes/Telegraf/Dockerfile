FROM telegraf

# Adicionar repositórios principais do Debian Buster
RUN echo "deb http://deb.debian.org/debian/ buster main contrib non-free" > /etc/apt/sources.list.d/debian.list && \
    echo "deb http://deb.debian.org/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list.d/debian.list && \
    echo "deb http://security.debian.org/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list.d/debian.list

# Atualizar pacotes e instalar snmp e snmp-mibs-downloader
RUN apt-get update && \
    apt-get install -y snmp snmp-mibs-downloader curl

# Definindo o diretório para os MIBs
ENV MIB_DIR="/usr/share/snmp/mibs"

# Habilitar o download automático de MIBs
RUN echo "mibs +ALL" >> /etc/snmp/snmp.conf

# Copiar a configuração do Telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf

# Expor as portas que o Telegraf irá usar
EXPOSE 57100
EXPOSE 57500

# Definindo o entrypoint do container para o script
CMD ["telegraf", "--config", "/etc/telegraf/telegraf.conf"]