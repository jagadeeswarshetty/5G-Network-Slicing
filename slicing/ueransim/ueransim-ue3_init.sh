#!/bin/bash
cp /mnt/ueransim/${COMPONENT_NAME}.yaml /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|MNC|'$MNC'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|MCC|'$MCC'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|UE3_KI|'$UE3_KI'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|UE3_OP|'$UE3_OP'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|UE3_AMF|'$UE3_AMF'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|UE3_IMEISV|'$UE3_IMEISV'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|UE3_IMEI|'$UE3_IMEI'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|UE3_IMSI|'$UE3_IMSI'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
sed -i 's|NR_GNB_IP|'$NR_GNB_IP'|g' /UERANSIM/config/${COMPONENT_NAME}.yaml
./nr-ue -c ../config/${COMPONENT_NAME}.yaml &
exec bash $@
