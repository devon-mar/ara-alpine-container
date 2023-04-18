#!/bin/sh

set -e

ara-manage migrate
exec "${@}"
