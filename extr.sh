#!/bin/bash

git clone https://github.com/bkerler/oppo_ozip_decrypt ozipex
cd ozipex
wget http://downloads.oppo.com.s3.amazonaws.com/firmware/CPH1909/CPH1909EX_11_OTA_0360_all_JfNVvuqQWDjk.ozip
python ozipdecrypt.py *ozip
ls
rm -rf .git
cd out
git init
git add . -f
git commit -m "ranchu-Oppo-A5S" -s -q
git checkout -b CPH1909-23042020
git push -f https://Thagoo:${GH_TOKEN}@github.com/Thagoo/dump_oppo_A5S_ranchu

