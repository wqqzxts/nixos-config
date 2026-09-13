#!/bin/sh
if eww active-windows | grep -q "ewwbar"; then
  eww close-all
else
  ewwbar
fi
