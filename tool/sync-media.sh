#!/usr/bin/env bash

rsync \
	--recursive \
	--archive \
	--compress \
	--progress \
	--links \
	--fuzzy \
	--human-readable \
	--itemize-changes \
	--delete \
	--cvs-exclude \
	"192.168.1.252:/home/alexander/media" "$HOME"

