#!/bin/bash
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
update-alternatives --set iptables `which iptables-nft`
update-alternatives --set ip6tables `which ip6tables-nft`
ip link delete $UPF2_URLLC_APN_IF_NAME 2>/dev/null
python3 /mnt/upf/tun_if.py --tun_ifname $UPF2_URLLC_APN_IF_NAME --tun_ifmode $UPF2_TUNTAP_MODE --ipv4_range $UE_IPV4_URLLC --ipv6_range 2001:230:fafe::/48 --no_nat_ipv4_addr $PCSCF_IP --no_nat_ipv6_addr 2001:230:eafe::1
UE_IPV4_URLLC_APN_GATEWAY_IP=$(python3 /mnt/upf/ip_utils.py --ip_range $UE_IPV4_URLLC)
cp /mnt/upf/upf2.yaml install/etc/open5gs/upf.yaml
sed -i 's|UPF2_IP|'$UPF2_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|SMF2_IP|'$SMF2_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|UE_IPV4_URLLC_APN_GATEWAY_IP|'$UE_IPV4_URLLC_APN_GATEWAY_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|UE_IPV4_URLLC_APN_SUBNET|'$UE_IPV4_URLLC'|g' install/etc/open5gs/upf.yaml
sed -i 's|UPF2_ADVERTISE_IP|'$UPF2_ADVERTISE_IP'|g' install/etc/open5gs/upf.yaml
sed -i 's|MAX_NUM_UE|'$MAX_NUM_UE'|g' install/etc/open5gs/upf.yaml
sed -i 's|UPF2_URLLC_APN_IF_NAME|'$UPF2_URLLC_APN_IF_NAME'|g' install/etc/open5gs/upf.yaml
cd install/bin
exec ./open5gs-upfd $@
