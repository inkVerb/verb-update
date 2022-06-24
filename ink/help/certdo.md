# cert do

## This installs the inkCert SSL cert manager on the webserver
- This obtains Letsencrypt certs for domains installed on the server

## Usage
- `ink cert do -d domain.tld -c|s|w`
  - Don't run this too often or you could be temporarily suspended from obtaining certs
  - Choose a type of cert:
    - -m : "multiple" domains and subdomains in one parent domain cert
    - -s : "single" domain per cert
    - -w : "wildcard" cert for subdomains of the specified domain
  - Choose which domain
    - -d domain.tld
    - -a : Apply this to all verb.* domains hosted on the server

- `ink cert do -d inkisaverb.com -m`
  - Obtains a "multiple" domain cert for inkisaverb.com and all subdomains thereof
  - `sed` replaces Apache options in `/sites-available/inkisaverb.com.conf` and all .conf files for its subdomains
