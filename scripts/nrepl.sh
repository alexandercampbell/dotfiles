#!/usr/bin/env zsh

clj -Sdeps '{:deps {cider/cider-nrepl {:mvn/version "0.25.1"} }}' \
	-m nrepl.cmdline --middleware "[cider.nrepl/cider-middleware]"

