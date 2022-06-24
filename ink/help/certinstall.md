# cert install

## This installs the inkCert SSL cert manager on the webserver
- This uses Letsencrypt as the cert authority
- This installs via `pacman`
- This creates `/etc/inkcert`
  - And adds a symlink `/etc/inkcert/le` -> `/etc/letsencryt`
  - And manages Letsencrypt certs through that symlink
  - If that symlink is broken, this will not be able to manage SSL certs

## Usage
- `ink cert install`
  - Only run this once
