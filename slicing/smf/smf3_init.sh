#!/bin/bash
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
UE_IPV4_MMTC_APN_GATEWAY_IP=$(python3 /mnt/smf/ip_utils.py --ip_range $UE_IPV4_MMTC)
cp /mnt/smf/smf3.yaml install/etc/open5gs/smf.yaml
sed -i 's|SMF3_IP|'$SMF3_IP'|g' install/etc/open5gs/smf.yaml
sed -i 's|SCP_IP|'$SCP_IP'|g' install/etc/open5gs/smf.yaml
sed -i 's|NRF_IP|'$NRF_IP'|g' install/etc/open5gs/smf.yaml
sed -i 's|UPF3_IP|'$UPF3_IP'|g' install/etc/open5gs/smf.yaml
sed -i 's|SMF_DNS1|'$SMF_DNS1'|g' install/etc/open5gs/smf.yaml
sed -i 's|SMF_DNS2|'$SMF_DNS2'|g' install/etc/open5gs/smf.yaml
sed -i 's|UE_IPV4_MMTC_APN_GATEWAY_IP|'$UE_IPV4_MMTC_APN_GATEWAY_IP'|g' install/etc/open5gs/smf.yaml
sed -i 's|UE_IPV4_MMTC_APN_SUBNET|'$UE_IPV4_MMTC'|g' install/etc/open5gs/smf.yaml
sed -i 's|PCSCF_IP|'$PCSCF_IP'|g' install/etc/open5gs/smf.yaml
sed -i 's|MAX_NUM_UE|'$MAX_NUM_UE'|g' install/etc/open5gs/smf.yaml
cd install/bin
exec ./open5gs-smfd $@
