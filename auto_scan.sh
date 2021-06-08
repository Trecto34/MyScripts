#!/usr/bin/env bash
#============================================#
#  Simple script for automated WEB scanning  #
#  using nmap and ffuf                       #
#                                            #
#  Github:      htpps//github.com/Trecto34   #
#  Author:      Trecto                       #
#============================================#
#  tested on zsh 5.8                         #
#============================================#
#  Version 1.0.0                             #
#============================================#
#  v1.0.0                                    #
#     -The basic script                      #
#                                            #
#============================================#

HELP="
        [  HELP  ]

        -h  -  Show this help message
        -t  -  The target or domain for scanning
        -v  -  Version
        -o  -  The directory for outputs

        [  USAGE  ]

        ./auto_scan.sh -t 'google.com' -o '/tmp/'
"
while getopts h:t:o: flag; do
  case "${flag}" in
    h) echo "$HELP" && exit 0 ;;
    t) ip=${OPTARG}           ;;
    o) otp=${OPTARG}          ;;
  esac
done

[ "$ip" = "" ] && echo "You need especify a target" && exit 1
[ "$otp" = "" ] && echo "You need especify a output path" && exit 2

echo "
#========================================================#
Target:      "$ip"
Nmap Output: "$otp"/nmapscan.txt
Ffuf Output: "$otp"/ffuf.html
#========================================================#
"

nmap -sS -Pn -A -T5 "$ip" -o "$otp/nmapscan.txt"
ffuf -u http://$ip/FUZZ -w /usr/share/dirb/wordlists/common.txt -o $otp/ffuf.html -of html