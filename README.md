# Script de Monitoramento de Rede

Este script é responsável por **coletar métricas de rede** em unidades remotas, simulando tráfego e medindo desempenho. Ele envia os dados coletados para um servidor central, onde são processados e armazenados.

---

## **Função Principal**

O script realiza as seguintes tarefas:

1. **Gera tráfego de rede** simulado para testar a capacidade da rede.
2. **Coleta métricas** como largura de banda, latência e perda de pacotes.
3. **Envia os dados** para um servidor central via API.

---

## **Configuração**

Antes de executar o script, é necessário definir as variáveis de configuração. Abaixo estão as variáveis que devem ser ajustadas:

### **Variáveis do Script**

| Variável          | Descrição                                                     | Exemplo                    |
| ----------------- | ------------------------------------------------------------- | -------------------------- |
| `SERVER_URL`      | URL do servidor central que recebe as métricas.               | `http://192.168.1.100/api` |
| `UNIT_ID`         | Identificador único da unidade (ex.: nome da unidade ou ID).  | `SP-001`                   |
| `IPERF_SERVER_IP` | IP do servidor iperf3 que recebe o tráfego simulado.          | `192.168.1.100`            |
| `PING_SERVER_IP`  | IP do servidor usado para medir latência e perda de pacotes.  | `192.168.1.100`            |
| `TEST_DURATION`   | Duração do teste de tráfego (em segundos).                    | `60`                       |
| `BANDWIDTH`       | Largura de banda do tráfego simulado (ex.: 10M para 10 Mbps). | `10M`                      |

---

## **Como Executar**

1. Defina as variáveis no script conforme as instruções acima.
2. Torne o script executável:
   ```bash
   chmod +x network_monitor.sh
   ```
3. Execute o script:
   ```bash
   ./network_monitor.sh
   ```

---

## **Agendamento**

Para executar o script automaticamente a cada 5 minutos, use o cron:

1. Abra o crontab para edição:
   ```bash
   crontab -e
   ```
2. Adicione a linha abaixo:
   ```bash
   */5 * * * * /caminho/para/network_monitor.sh
   ```
   Substitua `/caminho/para/network_monitor.sh` pelo caminho completo do script.

---

## **Dependências**

Certifique-se de que as seguintes ferramentas estão instaladas no sistema:

- **iperf3**: Para gerar tráfego de rede.
- **curl**: Para enviar dados ao servidor.
- **ping**: Para medir latência e perda de pacotes.

---

## **Contribuição**

Se encontrar problemas ou tiver sugestões de melhorias, sinta-se à vontade para abrir uma issue ou enviar um pull request.

---

## **Licença**

Este projeto está licenciado sob a MIT License.

---

## **Como Usar**

1. Salve o conteúdo acima em um arquivo chamado `README.md`.
2. Coloque o arquivo no mesmo diretório do script.
3. Atualize as informações conforme necessário (ex.: URL do servidor, exemplos de variáveis).
