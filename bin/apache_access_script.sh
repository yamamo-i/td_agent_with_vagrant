#!/bin/bash

while true
  do
    date
    eval "curl http://127.0.0.1:8000"
    sleep $1
  done;
