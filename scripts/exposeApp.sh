#!/bin/bash
set -e
sudo kubectl port-forward svc/iot-playground -n dev 1337:1337 --address 0.0.0.0
