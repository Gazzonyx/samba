#!/bin/sh

. "${TEST_SCRIPTS_DIR}/unit.sh"

define_test "3 nodes, node 0 missing NATGW capability, all stopped"

setup_natgw <<EOF
192.168.20.41
192.168.20.42
192.168.20.43
EOF

required_result 2 <<EOF
-1 0.0.0.0
Number of nodes:3
pnn:0 192.168.20.41    STOPPED|INACTIVE
pnn:1 192.168.20.42    STOPPED|INACTIVE (THIS NODE)
pnn:2 192.168.20.43    STOPPED|INACTIVE
EOF

simple_test <<EOF
NODEMAP
0       192.168.20.41   0x20	-CTDB_CAP_NATGW
1       192.168.20.42   0x20    CURRENT RECMASTER -CTDB_CAP_NATGW
2       192.168.20.43   0x20	-CTDB_CAP_NATGW

VNNMAP
654321
0
1
2

IFACES
:Name:LinkStatus:References:
:eth2:1:2:
:eth1:1:4:
EOF
