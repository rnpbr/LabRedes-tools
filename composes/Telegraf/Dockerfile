FROM telegraf:1.38

RUN apt-get update && \
    apt-get install -y apt-utils && \
    # Habilitar repositório non-free e instalar os pacotes necessários para SNMP e download de MIBs
    echo "deb http://deb.debian.org/debian bookworm main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian bookworm-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian-security bookworm-security main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y snmp snmp-mibs-downloader curl && \
    rm -rf /var/lib/apt/lists/*

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