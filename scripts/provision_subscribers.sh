#!/bin/bash
set -e

docker exec -i mongo mongosh open5gs --eval '
db.subscribers.deleteMany({ imsi: { $in: ["001011224567895", "001011224567896", "001011224567897"] } });

db.subscribers.insertMany([
  {
    imsi: "001011224567895",
    subscribed_rau_tau_timer: 12,
    network_access_mode: 0,
    subscriber_status: 0,
    access_restriction_data: 32,
    slice: [{
      sst: 1, sd: "000001", default_indicator: true,
      session: [{
        name: "embb", type: 3, pcc_rule: [],
        ambr: { uplink: { value: 500, unit: 2 }, downlink: { value: 1, unit: 3 } },
        qos: { index: 9, arp: { priority_level: 8, pre_emption_capability: 1, pre_emption_vulnerability: 1 } }
      }]
    }],
    ambr: { uplink: { value: 500, unit: 2 }, downlink: { value: 1, unit: 3 } },
    security: { k: "8baf473f2f8fd09487cccbd7097c6862", amf: "8000", op: "11111111111111111111111111111111", opc: null },
    schema_version: 1, __v: 0
  },
  {
    imsi: "001011224567896",
    subscribed_rau_tau_timer: 12,
    network_access_mode: 0,
    subscriber_status: 0,
    access_restriction_data: 32,
    slice: [{
      sst: 2, sd: "000002", default_indicator: true,
      session: [{
        name: "urllc", type: 3, pcc_rule: [],
        ambr: { uplink: { value: 100, unit: 2 }, downlink: { value: 100, unit: 2 } },
        qos: { index: 82, arp: { priority_level: 1, pre_emption_capability: 1, pre_emption_vulnerability: 2 } }
      }]
    }],
    ambr: { uplink: { value: 100, unit: 2 }, downlink: { value: 100, unit: 2 } },
    security: { k: "8baf473f2f8fd09487cccbd7097c6862", amf: "8000", op: "11111111111111111111111111111111", opc: null },
    schema_version: 1, __v: 0
  },
  {
    imsi: "001011224567897",
    subscribed_rau_tau_timer: 12,
    network_access_mode: 0,
    subscriber_status: 0,
    access_restriction_data: 32,
    slice: [{
      sst: 3, sd: "000003", default_indicator: true,
      session: [{
        name: "mmtc", type: 3, pcc_rule: [],
        ambr: { uplink: { value: 10, unit: 2 }, downlink: { value: 10, unit: 2 } },
        qos: { index: 8, arp: { priority_level: 9, pre_emption_capability: 2, pre_emption_vulnerability: 1 } }
      }]
    }],
    ambr: { uplink: { value: 10, unit: 2 }, downlink: { value: 10, unit: 2 } },
    security: { k: "8baf473f2f8fd09487cccbd7097c6862", amf: "8000", op: "11111111111111111111111111111111", opc: null },
    schema_version: 1, __v: 0
  }
]);
'
echo "Provisioned eMBB, URLLC, and mMTC subscribers."
