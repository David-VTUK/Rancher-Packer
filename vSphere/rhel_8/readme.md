#Rhel 8 clean template
This should build a usable Rancher Template

It does have the code for an internal proxy - just remove that configuration if its not needed.

Please edit the following:
* script.sh
* variables.json
* rhel7.json

Replace values for proxy (if needed), docker server repo if you have it local, domain names for subscription, and your local Red Hat Satellite Server if its on prem.

