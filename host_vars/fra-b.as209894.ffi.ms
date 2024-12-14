---
hostname_short: "fra-b"

as_router_id: "45.154.111.177"

direct_interfaces:
  - "br-vms"

as_v4:
  cix_local_address: "185.1.74.58"
  router_prefsrc: "45.154.111.177"
  gre_tunnel_transfer_network: "100.127.12.0/22"
  ibgp_cix_address_dict:
    "ber-a":
      source: "10.254.0.12"
      address: "10.254.0.1"
    "ber-b":
      source: "10.254.0.12"
      address: "10.254.0.2"

  ibgp_direct_dict:
    "fra-a":
      source: "10.254.1.2"
      address: "10.254.1.1"

  ebgp_cix:
    "rs01":
      address: "185.1.74.1"
      as: "57555"
      password: "{{ passwords.bgp.fra_b.cix_rs }}"
    "rs02":
      address: "185.1.74.2"
      as: "57555"
      password: "{{ passwords.bgp.fra_b.cix_rs }}"

as_v6:
  cix_local_address: "2001:7f8:a5::20:9894:4"
  as_prefix_host_spec: "2a14:440:2000::/36"
  router_prefsrc: "2a14:440:2200::1"
  tunnel_source: "2a14:440:2200::1"
  gre_tunnel_transfer_network: "2a14:440:0:4::/64"
  ibgp_cix_address_dict:
    "ber-a":
      source: "fe80::12"
      address: "fe80::1"
      interface: "cix-xcon-ffi"
    "ber-b":
      source: "fe80::12"
      address: "fe80::2"
      interface: "cix-xcon-ffi"

  ibgp_direct_dict:
    "fra-a":
      source: "fe80::2"
      address: "fe80::1"
      interface: "ens1f0np0"

  ebgp_cix:
    "rs01":
      address: "2001:7f8:a5::5:7555:1"
      as: "57555"
      password: "{{ passwords.bgp.fra_b.cix_rs }}"
    "rs02":
      address: "2001:7f8:a5::5:7555:2"
      as: "57555"
      password: "{{ passwords.bgp.fra_b.cix_rs }}"
