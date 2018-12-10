info:
	@ less /vagrant/preset/why.txt

initial_setting: sys_update sys_configure

sys_update:
	sudo apt-get update
	sudo apt update
	sudo apt-get -y upgrade
	sudo apt -y upgrade

sys_configure:
	@ echo "--------------------------"
	@ echo "In next interface select Europe - Moscow"
	@ read -p "Enter Enter to enter %)" kittenTime;
	sudo dpkg-reconfigure tzdata
	sudo apt install -y ntp # synchronized time by internet 
	sudo service ntp restart
	sudo locale-gen ru_RU.UTF-8 # add Rusian
	@ echo "--------------------------"
	@ echo "In next interface (second screen) select ru_RU.UTF-8 as Default"
	@ read -p "Enter Enter to enter %)" kittenLang;
	sudo dpkg-reconfigure locales
	@ echo "--------------------------"
	@ echo "Exec 'logout' and 'vagrant ssh'. Check 'locale', Should not be 'C.UTF-8'"
	@ read -p "Ok? OK? Press Enter and do it!" istheend;

postgres_install:
	sudo apt-get -y install postgresql-10
	@ echo "--------------------------"
	@ echo "Enter password 'developer':"
	sudo -u postgres createuser --createdb --pwprompt developer
	@ echo "host all all all password" | sudo tee -a /etc/postgresql/10/main/pg_hba.conf
	@ echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/10/main/postgresql.conf
	sudo service postgresql restart
	@ #"Памятка про логин под суперюзером: sudo -u postgres psql"
