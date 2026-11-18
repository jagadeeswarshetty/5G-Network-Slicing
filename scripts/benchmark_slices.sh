#!/bin/bash
set -e

echo "=== 1. Verifying Slice IP Allocation ==="
docker exec nr_ue ip -br a show uesimtun0
docker exec nr_ue2 ip -br a show uesimtun0
docker exec nr_ue3 ip -br a show uesimtun0

echo -e "\n=== 2. Measuring Slice RTT Latency ==="
docker exec nr_ue ping -I uesimtun0 -c 5 192.168.100.1
docker exec nr_ue2 ping -I uesimtun0 -c 5 192.168.101.1
docker exec nr_ue3 ping -I uesimtun0 -c 5 192.168.102.1

echo -e "\n=== 3. Measuring Cross-Slice Isolation (URLLC RTT under eMBB Load) ==="
docker exec -d nr_ue iperf3 -c 192.168.100.1 -B 192.168.100.2 -t 10 2>/dev/null || true
sleep 1
docker exec nr_ue2 ping -I uesimtun0 -i 0.1 -c 20 192.168.101.1
