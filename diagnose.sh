#!/bin/bash

# Configurações
SERVER_URL="http://<IP_DO_SERVIDOR>/api/metrics"  # Substitua pelo IP do servidor
UNIT_ID="TESTE"  # Identificador da unidade
IPERF_SERVER_IP="<IP_DO_SERVIDOR_IPERF>"  # IP do servidor iperf
TEST_DURATION=60  # Duração do teste de tráfego (1 minuto)
BANDWIDTH="10M"  # Largura de banda para o teste (10 Mbps)
PING_SERVER_IP="<IP_DO_SERVIDOR_PING>"  # IP do servidor para teste de ping

# Função para executar o teste de tráfego com iperf3
run_iperf_test() {
    echo "Executando teste de tráfego com iperf3..."
    iperf3 -c $IPERF_SERVER_IP -t $TEST_DURATION -b $BANDWIDTH -J > iperf_result.json
    if [ $? -eq 0 ]; then
        echo "Teste de tráfego concluído."
    else
        echo "Erro no iperf3."
        exit 1
    fi
}

# Função para executar o teste de ping
run_ping_test() {
    echo "Executando teste de ping..."
    ping_result=$(ping -c 10 $PING_SERVER_IP)
    if [ $? -eq 0 ]; then
        # Extrai latência média
        latency=$(echo "$ping_result" | tail -n 1 | awk -F '/' '{print $5}')
        # Extrai packet loss
        packet_loss=$(echo "$ping_result" | grep "packet loss" | awk '{print $6}' | tr -d '%')
        echo "Teste de ping concluído."
    else
        echo "Erro no ping."
        exit 1
    fi
}

# Função para enviar métricas para o servidor
send_metrics() {
    echo "Enviando métricas para o servidor..."
    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    metrics=$(cat <<EOF
{
    "unit_id": "$UNIT_ID",
    "timestamp": "$timestamp",
    "bandwidth": "$BANDWIDTH",
    "latency_ms": "$latency",
    "packet_loss_percent": "$packet_loss",
    "iperf_result": $(cat iperf_result.json)
}
EOF
)
    # Envia métricas via POST
    curl -X POST -H "Content-Type: application/json" -d "$metrics" $SERVER_URL
    if [ $? -eq 0 ]; then
        echo "Métricas enviadas com sucesso."
    else
        echo "Falha ao enviar métricas."
    fi
}

# Executa os testes
run_iperf_test
run_ping_test
send_metrics