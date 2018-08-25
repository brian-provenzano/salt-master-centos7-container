#!/usr/bin/python36
'''
Gets, compares and approves the local minion key for the master (rather than blind approve via -A)
'''
import subprocess, json

master_hostname = str.strip(subprocess.run("hostname",stdout=subprocess.PIPE).stdout.decode())
saltmaster_response = json.loads(str.strip(subprocess.run(["salt-key", "-f", master_hostname, "--out", "json"], stdout=subprocess.PIPE).stdout.decode()))
master_reported_minionkey = saltmaster_response["minions_pre"].get(master_hostname)
saltmasterminion_response = json.loads(str.strip(subprocess.run(["salt-call", "key.finger", "--local", "--out", "json"], stdout=subprocess.PIPE).stdout.decode()))
minion_reported_minionkey = saltmasterminion_response.get("local")
if master_reported_minionkey == minion_reported_minionkey:
    print(subprocess.run(["salt-key", "-y", "-a", master_hostname], stdout=subprocess.PIPE).stdout.decode())
else:
    print("Keys did not match (local minion and master key)!!!!  SOMETHING IS WRONG!  LIKE REALLY WRONG DUDE!")