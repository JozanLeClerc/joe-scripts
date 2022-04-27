#!/bin/csh

set p = `pwd`
cd /
git --git-dir=/usr/local/git/jozan/jozanofastora-conf.git --work-tree=/ $*
cd $p
