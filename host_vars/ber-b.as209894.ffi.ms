---
hostname_short: "ber-b"

as_router_id: "45.154.111.145"

direct_interfaces:
  - "br-vms"

as_v4:
  cix_local_address: "185.1.74.57"
  router_prefsrc: "45.154.111.145"
  gre_tunnel_transfer_network: "100.127.4.0/22"
  ibgp_cix_address_dict:
    "fra-a":
      source: "10.254.0.2"
      address: "10.254.0.11"
    "fra-b":
      source: "10.254.0.2"
      address: "10.254.0.12"

  ibgp_direct_dict:
    "ber-a":
      source: "10.254.2.2"
      address: "10.254.2.1"

  ebgp_cix:
    "rs01":
      address: "185.1.74.1"
      as: "57555"
      password: "{{ passwords.bgp.ber_b.cix_rs }}"
    "rs02":
      address: "185.1.74.2"
      as: "57555"
      password: "{{ passwords.bgp.ber_b.cix_rs }}"

as_v6:
  cix_local_address: "2001:7f8:a5::20:9894:3"
  as_prefix_host_spec: "2a14:440:1000::/36"
  router_prefsrc: "2a14:440:1200::1"
  tunnel_source: "2a14:440:1200::1"
  gre_tunnel_transfer_network: "2a14:440:0:2::/64"
  ibgp_cix_address_dict:
    "fra-a":
      source: "fe80::2"
      address: "fe80::11"
      interface: "cix-xcon-ffi"
    "fra-b":
      source: "fe80::2"
      address: "fe80::12"
      interface: "cix-xcon-ffi"

  ibgp_direct_dict:
    "ber-a":
      source: "fe80::2"
      address: "fe80::1"
      interface: "eno1"

  ebgp_cix:
    "rs01":
      address: "2001:7f8:a5::5:7555:1"
      as: "57555"
      password: "{{ passwords.bgp.ber_b.cix_rs }}"
    "rs02":
      address: "2001:7f8:a5::5:7555:2"
      as: "57555"
      password: "{{ passwords.bgp.ber_b.cix_rs }}"
