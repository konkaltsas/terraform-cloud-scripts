#!/bin/bash

terraform apply -auto-approve -target module.infra && \
terraform apply -auto-approve -target module.infra -target module.adc 
terraform apply -auto-approve -target module.infra -target module.adc -target module.lb
terraform apply -auto-approve