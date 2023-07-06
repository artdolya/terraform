#!/bin/bash
 TZ=UTC jq -n 'now | {current: strftime("%Y-%m-%dT%H:%M:%SZ")}'