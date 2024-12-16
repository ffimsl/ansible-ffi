uffd:
  # Mail-Einstellungen
  mail_server: "{{ passwords.uffd.mail_server }}"
  mail_port: "{{ passwords.uffd.mail_port }}"
  mail_username: "{{ passwords.uffd.mail_username }}"
  mail_password: "{{ passwords.uffd.mail_password }}"
  mail_use_starttls: True
  mail_from_address: "{{ passwords.uffd.mail_from_address }}"

  # Service-Einstellungen
  secret_key: "{{ passwords.uffd.secret_key }}"
  mfa_rp_name: 'FFI SSO Service'
  footer_links:
    - url: 'https://freifunk-muensterland.de/impressum/'
      title: 'Impressum'
    - url: 'https://freifunk-muensterland.de/datenschutzerklaerung/'
      title: 'Datenschutzerklärung'
  login_banner: ''
  branding_logo_url: '/static/empty.png'
  site_title: 'FFI SSO Service'
  organisation_name: "{{ orga.name }}"
  organisation_contact: "{{ orga.email }}"
  welcome_text: 'Wilkommen Hier könnte ihre Werbung stehen.'

  # MySQL Datenbank
  db_name: "{{ passwords.uffd.db_name }}"
  db_user: "{{ passwords.uffd.db_user }}"
  db_password: "{{ passwords.uffd.db_password }}"

  # UFFD-Admin-Einstellungen
  admin_user: "{{ passwords.uffd.admin_user }}"
  admin_password: "{{ passwords.uffd.admin_password }}"
  admin_email: "{{ passwords.uffd.admin_email }}"
  admin_displayname: "{{ passwords.uffd.admin_displayname }}"
