start supervisord:
  cmd.run:
    - name: /usr/bin/supervisord
    - env:
      - CONJUR_APPLIANCE_URL: "{{ salt['pillar.get']('conjur:appliance_url') }}"
      - CONJUR_AUTHN_LOGIN: "{{ salt['pillar.get']('conjur:identity:id') }}"
      - CONJUR_AUTHN_API_KEY: "{{ salt['pillar.get']('conjur:identity:api_key') }}"
      - CONJUR_AUTHN_URL: "{{ salt['pillar.get']('conjur:authn_url') }}"
      - CONJUR_CERT_FILE: /etc/conjur.pem