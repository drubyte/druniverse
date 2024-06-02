#!/bin/bash
current=$(df -h --output=used /dev/sda2 | tail -n 1 | tr -d '[:space:]')
current=${current::-1}
avail=$(df -h --output=size /dev/sda2 | tail -n 1 | tr -d '[:space:]')
echo "$current/$avail"
