{% import_yaml "/root/app-identity.yml" as info %}
conjur:
  - appliance_url: {{ info.appliance_url }}
  - authn_url: {{ info.appliance_url }}/authn
  - account: {{ info.account }}
  - certificate: |
{{ info.certificate | indent(6, True) }}
  - identity:
    - host_id: {{ info.id }}
    - api_key: {{ info.api_key }}