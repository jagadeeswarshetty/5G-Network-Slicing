# End-to-End 5G Standalone Network Slicing (eMBB, URLLC, mMTC)

A reproducible 5G Standalone (5G SA) network slicing testbed built with **Open5GS** and **UERANSIM** on Docker, implementing **3GPP S-NSSAI** slice selection (`NSSF` + `AMF`) and **dedicated per-slice SMF/UPF user planes** with enforced Linux `tc netem` QoS policies.

## 1. Slice Architecture

| Slice Type | S-NSSAI (`SST` / `SD`) | DNN | SMF -> UPF Containers | UE IP Subnet | 5QI / ARP | Enforced QoS SLA |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **eMBB** | `SST 1` / `000001` | `embb` | `smf` (`172.22.0.7`) -> `upf` (`172.22.0.8`) | `192.168.100.0/24` | `5QI 9` / ARP `8` | 500 Mbps, 15 ms delay |
| **URLLC** | `SST 2` / `000002` | `urllc` | `smf2` (`172.22.0.100`) -> `upf2` (`172.22.0.90`) | `192.168.101.0/24` | `5QI 82` / ARP `1` | 100 Mbps, 1 ms delay, 0% loss |
| **mMTC** | `SST 3` / `000003` | `mmtc` | `smf3` (`172.22.0.101`) -> `upf3` (`172.22.0.92`) | `192.168.102.0/24` | `5QI 8` / ARP `9` | 5 Mbps, 40 ms delay |

## 2. Step-by-Step Deployment

### Step 1: Clone & Build Images
```bash
git clone [https://github.com/jagadeeswarshetty/5G-Network-Slicing.git](https://github.com/jagadeeswarshetty/5G-Network-Slicing.git)
cd 5G-Network-Slicing
docker build -t docker_open5gs ./base
docker build -t docker_ueransim ./slicing/ueransim
```

### Step 2: Start the 3-Slice 5G Core
```bash
cd slicing
set -a && source .custom_env && set +a
docker compose -f sa-deploy.yaml up -d
```

### Step 3: Provision Slice Subscribers
```bash
bash ../scripts/provision_subscribers.sh
```

### Step 4: Start gNB and Slice UEs
```bash
set -a && source .custom_env && set +a
docker compose -f nr-gnb.yaml up -d
sleep 3
docker compose -f nr-ue.yaml -f nr-ue2.yaml -f nr-ue3.yaml up -d
```

## 3. Verified Testing & QoS Commands

```bash
docker exec nr_ue ip -br a show uesimtun0
docker exec nr_ue2 ip -br a show uesimtun0
docker exec nr_ue3 ip -br a show uesimtun0
docker exec nr_ue ping -I uesimtun0 -c 5 192.168.100.1
docker exec nr_ue2 ping -I uesimtun0 -c 5 192.168.101.1
docker exec nr_ue3 ping -I uesimtun0 -c 5 192.168.102.1
```

## 4. Benchmark Results

| Slice | Idle RTT | RTT Under eMBB Load | Throughput | Loss |
| :--- | :--- | :--- | :--- | :--- |
| eMBB (SST 1) | 16.81 ms | Saturating link | 300 Mbps | 0% |
| URLLC (SST 2) | 2.31 ms | 1.61 ms | 106 Mbps | 0% |
| mMTC (SST 3) | 41.47 ms | - | 10.4 Mbps | 0% |
