#!/usr/bin/env bb

(require '[clojure.string :as str])
(require '[clojure.set :as set])

(some->> ; Print sorted list of lines in common between provided files.
  (seq *command-line-args*)
  (map #(->> % slurp str/split-lines (into (sorted-set))))
  (apply set/intersection)
  (map println)
  dorun)
