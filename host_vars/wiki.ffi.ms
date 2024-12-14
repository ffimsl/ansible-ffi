xwiki: true

caddy:
  domains:
    - name: wiki-neu.ffi.ms
      config: |
        encode gzip
        	reverse_proxy /* http://127.0.0.1:8080