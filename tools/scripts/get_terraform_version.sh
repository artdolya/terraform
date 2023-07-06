#!/bin/bash
terraform --version -json | jq '{ version: .terraform_version }'