# Terraform

# It is NOT required to use this TF as long as you have 2 Ubuntu 18.04 VMs to point ansible at.  This is just a helper project.

## Issues!!!

I don't know if TF or AWS is the issue but I had many issues getting LS VMs to deploy.  I got the same error 90 times out of 95 :(

> Some names are already in use

To remedy this, I have a prefix and suffix.

If you get the same error, I was able to comment out the IPs and it would work sometimes.

I think this is an API issue with AWS LS but Google has 0 usefule results.

## Running TF

Install terraform.  I used version `Terraform v0.13.0`

```
mv backend.tf-example backend.tf
```

Set the backend config details to point to your AWS S3 bucket.

```
terraform init
terraform plan
terraform apply
```

This will create two instances, set permanent public IPs.


## Firewalls!!!
The firewall policy is NOT production ready/secure.

This will open SSH to the world on BOTH instances!!!

This will open UDP:1194 to the WORLD on the VPN server!!!


My advice is that you restrict SSH to your workstation's public IP.  Optionally you can restrict UDP:1194 to known networks.

This is done with a `local-exec` provisioner, you can adjust the command to add source IP ranges as you see fit.