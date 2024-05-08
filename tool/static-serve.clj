#!/usr/bin/env bb

; Taken from https://github.com/babashka/http-server#babashka
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {org.babashka/http-server {:mvn/version "0.1.12"}}})
(require '[babashka.http-server :as http-server])

; babashka http server takes the first `:port` specified in args, so append
; a default port to the end of the argument list.
(apply http-server/-main (concat *command-line-args* [:port 1030]))
