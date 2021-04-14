# Installation and information for inkVerb's "Verber" web server
## verb-dev-update
DEV version numbers have an extra digit and never end in 0, skipping it. This reserves the final number of the stable channel for vital patches.
eg:
stable version: 1.04.00 (main release), 1.04.01 (vital update, no new features), 1.04.02 (vital update, no new features)
develp version: 1.04.19, (NEVER 1.04.20), 1.04.21, 1.04.22

IMPORTANT: As of v0.86.00, serfs are being integrated into the "yeo" tool in the inkverb/yeo repo. This will manage the serfs by providing validation, help, and making them somewhat "mistake-proof". This is a work in progress, but will make this software ready for early beta testing.

### Sales-pitch: skip if you're already convinced :-)
#### Verber is for DIY entrepreneurs and copywriters and/or web geeks with many small-business clients.
#### Verber's concept is to use a verb.ink, verb.blue, etc. subdomain namespace as the web server's FQDN and hostname.
This has a few advantages to the webmaster, saves money, and pays the bills.
1. The webmaster does not need to use a working production domain to control other blogs, online stores, web apps, etc.
	- Eg, to offer your client ownCloud, you don't need owncloud.copywritersdomain.tld or clientswordpress.tld/owncloud, which is annoying and insecure
	- yourname.verb.ink is the server, like other domain-hosting services, but with more coolness and brag-value
	- yourname.verb.ink is simple and works on business cards or is easy to hide if you don't want it known
	- Your production domain is then free from the limelight to do what it needs to.
	- Full-functioned, domain-specific, full-fledged email is still available (you won't use smtp.myevilhostingregistrar.biz for your email, yet you still have full inbox control)
2. The verb.ink namespace is cheaper than another domain, annually.
	- The webmaster can set up a separate, email-working server for each verb domain (verb.ink, verb.blue, etc.) and host domains at each
	- The only limit of a Verber server is that the main auto-installed web apps are limited to the verb tld (verb.red has business-related apps such as CRM, ERP, HRM, etc.; verb.blue has cloud apps such as ownCloud; verb.kiwi does media, such as Ampache; etc.)
3. Paying $10 per year for your verb.ink namespace helps to pay for Verber's development. It is your way to support the project.
4. Verber is integrated with verb.ink domains to manage any other domain with any web app you want.
	- You even have control over your own PHP settings!
	- You can create any subdomain for yourname.verb.ink and install whatever app you want, manually
	- You can have FTP access (via SSH and SFTP, not insecure FTP) to any verb.ink, verb.blue domain with clients like FileZilla.
	- Hosting multiple servers only costs the price of the server, one namespace for all verb.ink domains is the same $10 per year.
5. Verber is open source (you don't need to write the ™ even if we do.)
	- Plans are being considered for a find-replace mod script to make Verber non-dependent on verb.ink names, even to mod (and thus allow) updates. It would essentially change the backbone structure from "verb.ink" to "ink.yourdomain.tld", "verb.blue" to "blue.yourdomain.tld", etc. This would make Verber truly "open source", which is the goal. The only service lacked would be inkisaverb.com repos and DNS controls.
	- The entire server can theoretically be in your home
	- You can run the server on any Ubuntu-able VPS, then jump out an escape hatch and reduplicate the entire server elsewhere, right where it left off
	- With verb.ink namespaces integrated into the server, you can theoretically duplicate the Verber server on your home Ubuntu instance, then tell that computer that verb.ink domains belong to that computer, then you can retrive and use all your files locally without any Internet.
	- Verber is intended to be cloud-friendly yet easy to jump ship without penalty or loss.

## Installation:

1. DNS, domains, IP address, port, ssh
	i. Point nameservers to NS1.DIGITALOCEAN.COM NS2.DIGITALOCEAN.COM NS3.DIGITALOCEAN.COM
	ii. Set name subdomains for server IP: NAME.verb.ink NAME.verb.one NAME.verb.email NAME.verb.blue NAME.verb.vip NAME.verb.kiwi NAME.verb.red
	iii. Set the port and ssh logins (for digitalocean)
		- Create ssh keys, two ways:
			1. `ssh-keygen -t rsa -f ~/.ssh/SOME_NAME_YOU MAKE` (passphrase if you want to enter it every time)
			2. Use vrk: `ssh-craft-key SOME_NAME_YOU MAKE`
		- Set up your droplet with ssh keys, which you must)
		- Your-Droplet > Access > <Reset Root Password>, get it from your email...
		- `ssh root@DROPLETIPADDRESS` (do the password thing, answer 'yes' if asked about establishing authenticity of a host IP key fingerprint and if you're sure you want to continue)
		- `nano /etc/ssh/sshd_config` "Port 5555" (for example)
		- ssh-only setup, two ways:
			1. `nano /etc/ssh/sshd_config` "PermitRootLogin without-password" (only if you set up the ssh keys in digitalocean, which you should)
			2. Use vrk:
				a. `ssh-add-key [surfer (server nickname)] [SSH_keyname] [server-password]` (only if you did not add the ssh keys in digitalocean)
				b. `ssh-keyportserver [surfer (server nickname)] [server-password] [new-port (optional)]`

2. Copy or git the Verber/verb directories to /opt/verb
	`cd /opt`
	`git clone https://github.com/inkVerb/verb`

3. Run the scripts
	`cd /opt/verb/inst`
	i. `./make-verber-preserver`    # prepares the server, mainly for locale
		* Follow in-file instructions, has optional parameters, reboot
		* Choose "y" or "Yes" when prompted
		* Locale setup may ask for settings, defaults should be okay, US-English is usually the goal.
	ii. `./make-verber [ swap size in GB, ie: 2 ]`    # prepares directories, Apache configs, web apps, swap, "boss" users, etc. for installation, but no hostname or IP is defined yet.
		* Follow in-file instructions, requires parameters, reboot
		* Now the server is a standard out-of-box inkVerb, ready to setup, can be copied as-is
	iii. `./setupverb [ long list of settings, see instructions inside the file ]`    # sets hostnames, IP, inkVerb namespace, and other settings across the server and the site goes live
		* Follow in-file instructions, requires parameters
At this point you can install the mail server...
	`cd ~/verb/serfs`
	iv. `installemail` (unless skipping number 4)

4. Setup PostFixAdmin and RoundCube
	i. pfa.NAME.verb.email/setup.php
	ii. Login to pfa.NAME.verb.email
		* Add NAME.verb.ink domain (no other verb domains will work if ink is the main server)
		* Create at least one email inbox for RoundCube installation
	iii. rc.NAME.verb.email/installer
		* After, removed the "installer", run: postinstallrc
	iv. Finish check
		* Login at rc.NAME.verb.email

5. Finished. Smile and remember, Ink Is A Verb™. So, ink.

6. You may make an optional separate server for any or only one verb domain
	i. Point the/each verb domain to the IP address to host it
	ii. Run setupverb as above, with your preferred verb domain for the host/FQDN
	iii. Use verboff to turn off all verb domains NOT on the/each server
	iv. Use verbemail to define the verb domain for the email server to use
		* Any domain can be used, but only once.
		* This can be the host/FQDN, but doesn't not need to be.
	v. Run installrc and installpfa as normal
	vi. You can do this on up to seven separate servers, one for each verb domain, or any combination thereof

7. If you are customizing (not normal, VERY geek or special)
	i. This uses a "verb" site (normal, which you just installed)
	ii. This also depends on a separate "ink" repo server, configured via setupverb in configs/sitenameip
	iii. If you setup the "ink" repo server yourself, know that it depends on:
		* ANYDOMAIN.TLD/repo/YOURFILESHERE
		* "/repo" is necessary on your "ink" server
		* ANYDOMAIN.TLD is all you add in make-verber
		* You can also use SUB.ANYDOMAIN.TLD of course
		* the downloaded files are usually such as WEBAPP.current.zip
	iv. You can change the "verb" base to any domain using the files in inst/make-verb:
		1. setdomainverb YOURDOMAIN.NEW
		2. setupdomainverb
		* Then, the site will be permanently changed and even remain changed after updates

## Note on Updates
Note: Update version numbers reference the framework. Ongoing updates continue for the serfs, etc job scripts. Framework needs rated, sequential alteration, which is why "version" numbers apply to them. Any update will update job scripts, regardless of the current version number.

The "repo" update list at verb/configs/inklists/repoverlist is updated with each update. To customise this, refer to repolinks in the same directory for versions and hashes, and run setrepocust to have your changes stick.

## File Structure Basics (for geeks and Star Trek fans)
### Note that terms like "serf" and "donjon" and others use categories that are consistent with each other, but won't conflict with other programming categories, for both art and clarity.

I. All files are in the "verb" directory
	A. Verber uses a system of "bosses" (users) and "serfs" (bash scripts)
	B. Note basic directory (folder) structures (folder and directory are used interchangeably in Verber instructions)
		- verb is the install folder
		- Before being installed, verb only contains: INSTALL, serfs, and inst
		- First, the "Verber" server must be pre-made (make-verber-preserver), then made (make-verber).
		- Installing with "setupverb" will create the local/verb directory: configs
		- After installing with "setupverb", the inst directory can theoretically be deleted but it is not at all necessary
	C. The "configs" directory is simple and useful, created by setupverb, containing many things:
		- MySQL database info for web apps by name
		- Bash-friendly info: IP address, repo info, special inkVerb namespace, and other settings used by Serfs and can be included in other bash scripts
		- Important MySQL configs that allow Serfs and the MySQL Boss to work with databases quickly, plus the MySQL root password if you ever need it
		- php.ini "Breaker of Links, Ever Elusive Unburnt, Father of Dragons, and Protector of the Domain" is only a symlink to the convenient file: php-YOURNAME.ini in configs. Edit it there.
		- It is safely away from the "Boss" sudoer user(s), who can only access the "Serfs" directory.

II. "Serfs" (in the 'serfs' directory) are bash scripts that do the chores of the server, with no .sh extention
	A. They update, remove, install, create, etc.
	B. Every serf has instructions inside, many have variables and parameters
	C. "Bosses" are users (Linux, MySQL, etc.) who boss the serfs so you don't need to login as root
		1. They have home folders linked to verb, as needed
		2. They are intended as a security option but are not necessary
		3. Bosses are sudoers and superusers and may require "sudo" if serf instructions require
	D. Serfs are intended to be run by a boss, embedded in server-side scripts, such as PHP, Python, Perl, JS, etc. where Linux commands can be embedded for web interface GUI control.
	E. Some serfs deliver messages to help webmasters learn, but these are not necessarily intended to be displayed through a GUI server-side script
	F. Bosses and serfs are the power of Verber: Empower one-click installs.
		1. The most basic boss-serf chore is a MySQL boss creating databases when a serf installs a web app
		2. Serfs "install" web apps on the server without asking quesitons.
		3. The patron (you), then "setup" the web app after the serf "installs" it.
		4. Serfs will create your database, user, and password that you designate when you install a web app.
		5. The WordPress install serf enters the database info into the wp-config for you, so you don't even need it after you define it.
		6. Other web apps, on setup, may ask you for the MySQL database info you designated when you bossed the serf to install it.
		7. After installing an app, the serf should report a message with whatever instructions, databases and setup URL are necessary to finish setting-up the web app.
	G. "inkCert" is the inkVerb SSL Serf task
		1. At release of Verber, inkCert simply ran Letsencrypt cert scripts, so inkCert = Letsencrypt
		2. By telling Serfs to do "inkcert" tasks throughout Verber, when/if Letsencrypt changes, only a few "inkcert" definitions need to be changed
		3. Letsencrypt does change and Verber alpha was developed while Letsencrypt was in beta and had no apt-get install package, so it needs to be kept in a cage
		4. In later plans, inkVerb will become a Certificate Authority and offer free SSL certificates for all domains and subomains hosted on an inkVerb namespace Verber server
	H. Backing up and restoring apps - AUTOMATED!!
		1. Use "backup" and "backuprestore" with the "namespace" of the app
		2. An app's "namespace" usually is the "vapps" subdireactory and the install serf "installAPPNAMESPACE"
		3. Use backupemail, etc. for email server backups. Normal backup does NOT work with email or email related apps.
		4. There are several serfs that start with "backup..." and each has instructions
	I. App "namespace"
		1. Every app has a unified name by which it is referred to throughout the server
		2. Email apps are somewhat of an exception
		3. Apps namespace appears in config files, vaps/APP directories, install serfs, etc. They are NOT listed anywhere, you have to just notice them.
	J. Serfs names
		1. Sefs tend to have unified "surnames" at the front of each surf's name so they sort by: task - app - mod |or| app - task - mod
		2. Serfs are surnamed this way to keep larger groups organized, usually depending on which surname would be more common. This is used by yeo.
		3. Serfs only use az09 characters so that APIs and terminal power-users can input them easily, they are not intended for noob humans looking them up as if in a phonebook, though, they do cluster somewhat alphabetically to help humans.
		4. Instructions for serfs exist in each file. THEY ARE NOT NOOB-PROOF! You could destroy your server system if you use a serf incorrectly. Read each file's instructions carefully before using from the command prompt.
		   * Serfs do not and never will have error-check/help functions and they use sh wherever possible; this is to keep their load and size small. Few (usually inkcert) use functions or bash rather than sh because the alternative would have made the files much larger.
		     ** The only exception to error-checking Serfs relate to inkNet and inkCert, since those systems include many Serfs with complex hierarchies. Their checks can automatically run batch Serfs for unmet Serf dependencies and prerequesites.
		   * Serfs are intended to be API-friendly/simple to support a "noob-proof" human interface, such as a GUI.
		   * Roadmap Note: A new set of larger "yeomen" bash scripts may be created with error-check/help and functions, which would be intended for Unix command line production.
			* An example yeoman could be "ink-inkinstall" run by a sudoer: $ sudo ink-install appname (for standard settings) or $ sudo ink-install appname -d database -u databaseuser -p databasepassword
			* The yeomen could be written by any contributor and a GUI is a higher roadmap priority. Feel free to pull-request in the repo: verber/yeomen
		5. Some special serfs, such as postinstall- don't always keep namespace tradition because it's not important and we want to keep serf names on the short side
		6. Here are some serf surnames to watch for:
			- install		(everything... web apps, inkVerb services, etc)
			- activate		(similar to install, but for an inkVerb service ready to go)
			- backup		(for apps, etc)
			- fix			(web config settings, such as www, wildcard alias, and https redirects; also used by wpfix to change code settings)
			- postinstall		(sometimes necessary after installing)
			- point			(domain forwarding)
			- new, add, kill	(users and domains, 'add' builds on an existing service or infrastructure created by 'new' or 'install', such as ftp, inknet, or domains)
			- set			(set/adjust site-wide settings)
			- show			(displays info already setup, that may be needed for other settings)

		7. Serf surnames that do jobs unique to a single service or app often start with the app/service name rather than the task.
			- mysql			(MySQL)
			- wp			(WordPress)
			- inkcert		(inkVerb's SSL authority, 'le' indicates using Letsencrypt)
			- inknet		(inkVerb's SSH server-to-server login service, including Jailkit)

		8. Others that may not appear here are stand-alones

III. inst contains files only used at installation and updates and some important root-user records
	A. The term "preserver" (s pronounced 's' not 'z') is a two-part hybrid meaning:
		1. "pre-server" for early installation steps
		2. "preserve" because it is intended to work as a "canned", VPS-ready image, such as a DigitalOcean snapshot
	B. The ternm "name" has both a function and a concept
		1. The concept is a "namespace" at verb.ink, verb.blue, etc. domains.
		2. It is used in sed-based find-replace scripts that customise the entire server to use your verb.ink namespace
	C. setupverb resides here and is symlinked to serfs, but after run the symlink is removed.

IV. The "donjon" - assets or "native apps".
	A. This is where native apps are kept. They may be written in Python or any other language.
	B. These apps are essential for the work of some routine tasks
	C. A "donjon" was the only stone-fortified tower in pre/early medieval wodden forts before large castles were common. It kept food and vital resources, like a fortified siloh.

V. inklists is meant for lists and repoes
	A. It contains universal, non-verber-specific config files that get updated regularly with the updateverber serf, such as version info
	B. It may contain more files once certain apps are installed

VI. tools contains common files and special root Serfs and Knights needed for inkNet's intra-verber Clients logging in to do jobs on the Verber

VII. Special user services and folders
	A. Guru
		1. Guru users are often known as "ftpvips" created by newftpvip, sharing the srv/vip folder as "home", granting wide access to all other users' spaces
		2. Guru governs many other special users and folders for FTP, web control, directly managing files for "vipdomains" via the Serf adddomainvip or adddomainfiler
		3. Guru has a direct link into an boss user's home folder, along side serfs and possibly others
		4. Note the "vip" folder is in srv/vip, with a symlink to /var/www/vip
	B. Jailkit
		1. Jailkit is considered part of inkNet, with two Serfs: inknetinstalljailkit and inknetaddjailkituser (used by inknetadd Vrk/Verber serfs)
		2. Jailkit's Serfs can operate and create users that operate independently of inkNet, but it is only used by inkVerb for inkNet intra-verber communication
		3. Jailkit users have access to "tools", 
		4. Jailkit's jail is in the srv/vip/ folder, giving Filevips access to all Jailkit users, as well as the boss
	C. VSFTP
		1. VSFTP creates "files", "filevips", and "ftpusers". See: newftpfiler, newftpvip, and newftpuser for details
		2. A "domainfiler" is a VSFTP user with access to a hosted domain's folder
		3. The "_filecabinet" is a global folder shared by "ftpfilers", but not available to ftpusers
		4. VSFTP's main directory is srv/vip, with some subdirectories for users
	D. Fossil
		1. Fossil can create a user specific to a fossil via the Serf: newfossiluser
		2. Fossil users are not a real user on the system, but uses a Serf to be created.
		3. Fossil's folder is in srv/vip
	E. Bosses
		1. Bosses are sudoers, but also have special folders via the "verb/boss" box
		2. The "boss box" includes vip, tools, serfs, and Inker knights (if Inker is installed)
		3. Bosses do not have direct access to config files in their home folders
		4. The "boss box" is at local/verb/boss, but boss home folders are in home/

VIII. Server names
	A. The hostname of your server will be the main TLD
		1. For a normal, stand-alone, this means it will be: ink.YOURNAME.verb.ink
		2. For secondary installs, it will be such as blue.YOURNAME.verb.blue, etc.
		3. If you change to a non-inkVerb server, it could be such as: ink.YOURDOMAIN.com
	B. Custom server v inkVerb server
		1. An inkVerb Verber server (using such as YOURNAME.verb.ink for $10 a year):
			- Offers to use the inkVerb repo for file installs, saving you additional server space (can't use with custom servers)
		2. A custom server (changes all verb.ink, verb.blue, etc to ink.YOURDOMAIN.com, blue.YOURDOMAIN.com, etc):
			- Cannot connect to the inkVerb repo, so you must follow the instructions to host your own.
			- Still uses the same file structure for inkVerb apps in the www/html directory
			- Retains nearly all other capabilities on the actual server

IX. Other notes
	A. Exit codes from bash scripts
		1. Scripts are ordered to minimize damage if exited from an error. WordPress, for example, will finish the basic install requirements before attempting a plugin download.
		2. Note: All bash scropts have a "set -e" declaration, so included scripts that exit other than 0 will abort the entire process. Here are some codes:
		- 0 - non-fatal exit
		- 1 - used by Linux
		- 2 - used by Linux
		- 3 - aborted by user at prompt (changed mind, didn't type 'yes', etc.)
		- 4 - failed attempt, such as a file not downloaded or login credentials rejected, thus cannot proceed
		- 5 - unmet credentials (ie variables for a bash script are incomplete or incorrect)
		- 6 - catostrophic error (something is wrong that shouldn't be possible, such as a script is messed up or something was changed manually-incorrectly, this error status is only for circumstances that creat a problem that didn't exist before, errors that notice a pre-existing problem should exit 0)
		- 7 - already installed dilemma ('already installed' reports 7 only if it would cause a problem to continue, this is a mass abort exit status to avoid conflict. A benign 'already installed' will exit 0)
		- 8 - unmet dependency (the basic 'do your homework' message: something else should have been done first, but can't be complete automatically)
	B. If statements, checks, and inclusions
		1. Scripts are organized to keep file size small and to standardize system-wide jobs, not to be fool-proof for lazy programming or new users.
		2. Many "if" checks and "usage" messages could be included in serfs, but are not because the user should more or less know what he is doing. Such errors will be in yoemen for easier command line use and a GUI.
		3. The main purpose of "if" checks is for complex situations or to provide contingency alternatives for factors outside of the Verber, such as failing to download a webapp for installation.
		4. Generally, failed "plugins" won't break an entire script; failing to download the core webapp will exit 44 and the webapp won't be installed at all.
		

