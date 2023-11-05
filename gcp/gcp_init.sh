#!/bin/bash

#CLI Installation on linux : https://cloud.google.com/sdk/docs/install-sdk
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-453.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-453.0.0-linux-x86_64.tar.gz
#

#Enable or disable Accessibility Feature : https://cloud.google.com/sdk/docs/enabling-accessibility-features
gcloud config set accessibility/screen_reader true

gcloud init # will initialize the configuration of gcloud
gcloud init --skip-diagnostics # skip diagnostics next time
gcloud --help #see cloud platform services you can interact with
gcloud topic --help #learn about advanced features
gcloud cheat sheet #see a roster of go-to glcloud commands


gcloud compute ssh --zone "us-central1-c" "vm-bastion-us-central1" --project "friendly-magpie-403914"


#Create SSH Key : https://cloud.google.com/compute/docs/connect/create-ssh-keys#linux-and-macos
ssh-keygen -t rsa -f ~/.ssh/KEY_FILENAME -C USERNAME -b 2048
#