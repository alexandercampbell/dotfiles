#!/usr/bin/env bb

; Use with
;
;   setopt promptsubst
;   export PROMPT='$(zsh-prompt.clj $?)'
;

(require '[clojure.string :as str])
(require '[clojure.java.shell :as shell])

(def ansi-codes
  ; Adapted from https://github.com/ams-clj/clansi
  {:reset             "[0m"
   :bright            "[1m"
   :blink-slow        "[5m"
   :underline         "[4m"
   :underline-off     "[24m"
   :inverse           "[7m"
   :inverse-off       "[27m"
   :strikethrough     "[9m"
   :strikethrough-off "[29m"
   :default           "[39m"
   :white             "[37m"
   :black             "[30m"
   :red               "[31m"
   :green             "[32m"
   :blue              "[34m"
   :yellow            "[33m"
   :magenta           "[35m"
   :cyan              "[36m"
   :bg-default        "[49m"
   :bg-white          "[47m"
   :bg-black          "[40m"
   :bg-red            "[41m"
   :bg-green          "[42m"
   :bg-blue           "[44m"
   :bg-yellow         "[43m"
   :bg-magenta        "[45m"
   :bg-cyan           "[46m"})

(defn ansi
  [kw]
  ; Escape sequences must be wrapped in %{ %}. Otherwise, Zsh will not
  ; correctly compute the cursor position for wrapping. Ref:
  ; https://stackoverflow.com/a/2534676
  (str "%{" \u001b (get ansi-codes kw) "%}"))

(def time-formatter (.ofPattern java.time.format.DateTimeFormatter "kk:mm:ss"))
(def time-str (-> java.time.LocalTime .now (.format time-formatter)))

(def current-git-branch
  (let [{exit :exit out :out} (shell/sh "git" "branch" "--show-current")]
    (when (zero? exit) (str/trim out))))

(def pwd (System/getenv "PWD"))
(def home (System/getenv "HOME"))
(def abbrev-pwd (str/replace-first pwd home "~"))

(def exit-code (first *command-line-args*))

(def prompt-components
  [(ansi :magenta) time-str " "
   (when current-git-branch (str (ansi :green) current-git-branch " "))
   (ansi :blue) abbrev-pwd " "
   (some-> exit-code (= "0") (if :green :red) (ansi) (str exit-code))
   (ansi :reset) " λ "])

(->> prompt-components (filter some?) (apply str) print)
