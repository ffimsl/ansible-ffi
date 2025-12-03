xwiki:
  memory_xmx: "-Xmx4096m"

caddy:
  domains:
    - name: wiki-neu.ffi.ms
      config: |
        encode gzip
        	reverse_proxy /* http://127.0.0.1:8080
    - name: wiki.ffi.ms
      config: |
        encode gzip
        	reverse_proxy /* http://127.0.0.1:8080
    - name: wiki.infrastruktur.ms
      config: |
        encode gzip
        	reverse_proxy /* http://127.0.0.1:8080
