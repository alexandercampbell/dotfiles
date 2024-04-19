#!/usr/bin/env bb

; Use with:
;   setopt promptsubst
;   export PROMPT='$(zsh-prompt.clj $?)'

(require '[clojure.string :as str])
(require '[clojure.java.shell :as shell])

(def ansi-codes
  "Adapted from https://github.com/ams-clj/clansi"
  {:reset             0
   :bright            1
   :blink-slow        5
   :underline         4
   :underline-off     24
   :inverse           7
   :inverse-off       27
   :strikethrough     9
   :strikethrough-off 29
   :default           39
   :white             37
   :black             30
   :red               31
   :green             32
   :blue              34
   :yellow            33
   :magenta           35
   :cyan              36
   :bg-default        49
   :bg-white          47
   :bg-black          40
   :bg-red            41
   :bg-green          42
   :bg-blue           44
   :bg-yellow         43
   :bg-magenta        45
   :bg-cyan           46})

; Escape sequences must be wrapped in %{ %}. Otherwise, Zsh will not correctly
; compute the cursor position for wrapping.
; Ref: https://stackoverflow.com/a/2534676
(defn ansi
  [kw]
  (str "%{"
       \u001b
       \[
       (get ansi-codes kw)
       \m
       "%}"))

(defn ansi-wrap
  [code & elts]
  (str (ansi code)
       (apply str (filter some? elts))
       (ansi :reset)))

(def fmt-time
  (java.time.format.DateTimeFormatter/ofPattern "kk:mm:ss"))

(defn shout
  [cmd & args]
  (let [{:keys [exit out]} (apply shell/sh cmd args)]
    (when (and
            (zero? exit)
            (not (str/blank? out)))
      (str/trim out))))

(defn current-git-branch [] (shout "git" "branch" "--show-current"))
(defn current-git-hash [] (shout "git" "rev-parse" "--short" "HEAD"))

(def pwd (System/getenv "PWD"))
(def home (System/getenv "HOME"))
(def abbrev-pwd (str/replace-first pwd home "~"))

(def exit-code (first *command-line-args*))

(def prompt-components
  [(ansi-wrap :magenta
              (.format (java.time.LocalTime/now) fmt-time))

   (ansi-wrap :green
              (or (current-git-branch)
                  (current-git-hash)))

   (ansi-wrap :blue abbrev-pwd)

   (ansi-wrap (if (= exit-code "0") :green :red)
              exit-code)

   (ansi-wrap :yellow "λ ")])

(->> prompt-components
     (filter some?)
     (interpose " ")
     (apply str)
     print)
