---
hostname_short: "fra-a"

as_router_id: "45.154.111.161"

direct_interfaces:
  - "br-vms"

as_v4:
  cix_local_address: "185.1.74.43"
  router_prefsrc: "45.154.111.161"
  gre_tunnel_transfer_network: "100.127.8.0/22"
  ibgp_cix_address_dict:
    "ber-a":
      source: "10.254.0.11"
      address: "10.254.0.1"
    "ber-b":
      source: "10.254.0.11"
      address: "10.254.0.2"

  ibgp_direct_dict:
    "fra-b":
      source: "10.254.1.1"
      address: "10.254.1.2"

  ebgp_cix:
    "rs01":
      address: "185.1.74.1"
      as: "57555"
      password: "{{ passwords.bgp.fra_a.cix_rs }}"
    "rs02":
      address: "185.1.74.2"
      as: "57555"
      password: "{{ passwords.bgp.fra_a.cix_rs }}"

as_v6:
  cix_local_address: "2001:7f8:a5::20:9894:1"
  as_prefix_host_spec: "2a14:440:2000::/36"
  router_prefsrc: "2a14:440:2100::1"
  tunnel_source: "2a14:440:2100::1"
  gre_tunnel_transfer_network: "2a14:440:0:3::/64"
  ibgp_cix_address_dict:
    "ber-a":
      source: "fe80::11"
      address: "fe80::1"
      interface: "cix-xcon-ffi"
    "ber-b":
      source: "fe80::11"
      address: "fe80::2"
      interface: "cix-xcon-ffi"

  ibgp_direct_dict:
    "fra-b":
      source: "fe80::1"
      address: "fe80::2"
      interface: "ens1f0np0"

  ebgp_cix:
    "rs01":
      address: "2001:7f8:a5::5:7555:1"
      as: "57555"
      password: "{{ passwords.bgp.fra_a.cix_rs }}"
    "rs02":
      address: "2001:7f8:a5::5:7555:2"
      as: "57555"
      password: "{{ passwords.bgp.fra_a.cix_rs }}"
