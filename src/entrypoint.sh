#!/bin/bash

set -m
/run/miscellaneous/restore_config.sh

$@ &

fg