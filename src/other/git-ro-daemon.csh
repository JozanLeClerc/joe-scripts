#!/bin/csh

exec git daemon --reuseaddr --base-path=/usr/local/git /usr/local/git &
