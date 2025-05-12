
#!/bin/bash

# This script collects Solana metrics and exposes them for Prometheus

# Function to get Solana network stats
collect_solana_metrics() {
  # Example metrics collection points
  SOLANA_VERSION=$(solana --version | cut -d " " -f 2)
  BALANCE=$(solana balance | cut -d " " -f 1)
  VALIDATORS=$(solana validators | grep -c "Identity")
  CLUSTER_SLOT=$(solana slot)
  
  # Write metrics to a file that will be exposed to Prometheus
  cat > /app/metrics.txt << EOF
# HELP solana_balance Current SOL balance
# TYPE solana_balance gauge
solana_balance ${BALANCE}

# HELP solana_validators_count Number of validators in the network
# TYPE solana_validators_count gauge
solana_validators_count ${VALIDATORS}

# HELP solana_current_slot Current slot in the Solana blockchain
# TYPE solana_current_slot counter
solana_current_slot ${CLUSTER_SLOT}

# HELP solana_client_info Information about Solana client
# TYPE solana_client_info gauge
solana_client_info{version="${SOLANA_VERSION}"} 1
EOF
}

# Create a simple HTTP server to expose metrics
create_metrics_server() {
  while true; do
    collect_solana_metrics
    echo "Metrics updated at $(date)"
    sleep 60
  done &
  
  # Start a simple HTTP server on port 8080
  python3 -m http.server 8080 --directory /app &
  
  # Keep the script running
  wait
}

create_metrics_server
