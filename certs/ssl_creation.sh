#!/bin/bash

# Root CA
openssl genrsa -out root-ca.key 2048
openssl req -x509 -new -nodes -key root-ca.key -sha256 -days 1825 -out root-ca.pem -subj "/CN=local.es"

# node certificates
nodes=(node1 node2 node3)
for node in "${nodes[@]}"; do
  # Private Key
  openssl genrsa -out "$node-pkcs12.key" 2048
  openssl pkcs8 -v1 "PBE-SHA1-3DES" -in "$node-pkcs12.key" -topk8 -out "$node.key" -nocrypt

  # CSR
  openssl req -new -key "$node.key" -out "$node.csr" -subj "/CN=local.es"

  # Certificate (.pem)
  openssl x509 -req -in "$node.csr" -CA root-ca.pem -CAkey root-ca.key -CAcreateserial \
-out "$node.pem" -sha256 -extfile local.es.ext
done

# Change permissions to read/write only by user
chmod 644 *.key
chmod 644 *.pem

# Clean up
rm root-ca.srl
for node in "${nodes[@]}"; do
  rm "$node-pkcs12.key"
  rm "$node.csr"
done