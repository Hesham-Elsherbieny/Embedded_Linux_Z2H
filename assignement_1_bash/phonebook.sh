
#!/bin/bash 

clear


if [ ! -d /etc/phonebook ]
then
	cd /etc
	sudo mkdir phonebook
	cd /etc/phonebook
	sudo touch phonebookDB.txt
fi
cd /etc
sudo chmod -R 777 /etc/phonebook;
cd phonebook

if [[ $# -eq 0 ]]
then
	echo "You Should add one of the following options:-"
	echo "-i :  to Insert new contact name and number"
	echo "-v :  to View all saved contacts details"
	echo "-s :  to Search by contact name"
	echo "-e :  to Delete all records"
	echo "-d :  to Delete only one contact name"
else 
	while [ -n "$1" ];
	 do
		case "$1" in
		-i)
			clear
			echo "Enter Contact Name:"
			read name
			echo "Enter Contact Phone Number:"
			read number
			echo -e "$name\t$number">>phonebookDB.txt
			echo "Contact Added Successfully";;
		-v)
			clear
			echo "All Saved Contacts"
			echo "---------------------"
			echo -e "ContactName\tNumber"
			echo "_______________________"
			cat phonebookDB.txt;;
		-s)
			clear
			echo "Enter Contact Name You Want to Search for : "
			read search
			clear
			if ! grep -i "$search" phonebookDB.txt
			then
			echo " Contact Not Found"
			fi ;;
		-e)
			clear
			> phonebookDB.txt
			echo "All Contacts Deleted Successfully...";;
			
		-d)
			echo "Enter Contact Name You Want to Delete : "
			read delete
			count=$(grep -i -c "$delete" phonebookDB.txt)
			if [ $count -ge 2 ]
			then
			echo " Multiple Entries Found with name you Entered, please Write full specific Name..."
			else
			sed -i "/$delete/Id" phonebookDB.txt
			echo "Contact Deleted Successfully..."
			fi;;
		*)
			echo "INVALID OPTION !!!";;
		esac
		
		shift

	done
fi
