#!/bin/bash
n1=$(apt list --upgradable | wc -l)
n2=1
echo $[n1 - n2]