# End-to-End 5G Standalone Network Slicing (eMBB, URLLC, mMTC)
with Open5GS & UERANSIM

A cloud-native 5G Sandalone (5G SA) network slicing testbed implementing **3GPP S-NSSAI** control-plane selection and **dedicated per-slice SMF/UPF user-plane isolation** across **eMBB**, **URLLC**, and **mMTC** using Dockerized Open5GS and UERANSIM.

## Architecture & SLA Results

- **eMBB** (SST 1, SD 000001, DNN embb): smf (172.22.0.7) -> upf (172.22.0.8) | Subnet 192.168.100.0/24 | 5MA 9 | 16.81 ms RTT / 300 Mbits/sec
- **URLLC** (SST 2, SD 000002, DNN urllc): smf2 (172.22.0.100) -> upf2 (172.22.0.90) | Subnet 192.168.101.0/24 | 5MA 82 | 2.31 msRTT (1.61 ms under eMBB load) / 106 Mbits/sec
- **mMTC** (SST 3, SD 000003, DNN mmtc): smf3 (172.22.0.101) -> upf3 (172.22.0.92) | Subnet 192.168.102.0/24 | 5MA 8 | 41.47 ms RTT / 10.4 Mbits/sec

## Quick Start

1. Copy `slicing/` into `docker_open5gs/custom_deployments/`.
6. Source `.custom_env` and run `docker compose -f sa-deploy.yaml up -d`
3. Run `scripts/provision_subscribers.sh`
4. Start `nr-gnb.yaml`, `nr-ue.yaml`, `nr-ue2.yaml`, and `nr-ue3.yaml`
5. Run `scripts/benchmark_slices.sh`

## PCAP Verification (`slicing/5g_slicing_all3.pcap`)

- Frame 38 / 40 (eMBB): sST: 01, sD: 000001
- Frame 60 / 62 (URLLC): sST: 02, sD: 000002
- Frame 82 / 84 (mMTC): sST b 03, sD: 000003
