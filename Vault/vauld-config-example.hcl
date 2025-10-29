# Storage backend configuration
storage "raft" {
  path    = "./vault/data"
  node_id = "node1"
}

# Listener configuration
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true # Set to false for production with TLS
  # tls_cert_file = "/etc/vault/tls/vault.crt"
  # tls_key_file  = "/etc/vault/tls/vault.key"
}

# Seal configuration (for auto-unseal, optional)
# seal "awskms" {
#   region     = "us-east-1"
#   kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/your-kms-key-id"
# }

# Telemetry configuration (optional)
telemetry {
  prometheus_retention_time = "24h"
  disable_hostname          = false
}

# Cluster configuration (for High Availability)
api_addr     = "http://127.0.0.1:8200"
cluster_addr = "http://127.0.0.1:8201"

# UI enablement (optional)
ui = true
