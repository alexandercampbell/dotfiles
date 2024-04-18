#!/usr/bin/env bb

; Taken from https://github.com/babashka/http-server#babashka
(require '[babashka.deps :as deps])
(deps/add-deps '{:deps {org.babashka/http-server {:mvn/version "0.1.12"}}})
(require '[babashka.http-server :as http-server])
(apply http-server/-main *command-line-args*)
