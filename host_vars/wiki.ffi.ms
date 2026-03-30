xwiki:
  memory_xmx: "-Xmx4096m"
  enable_oidc: true

caddy:
  domains:
    - name: wiki.ffi.ms
      config: |
        encode gzip
        	reverse_proxy /* http://127.0.0.1:8080
    - name: wiki.ffmsl.de
      config: |
        encode gzip
        	reverse_proxy /* http://127.0.0.1:8080
