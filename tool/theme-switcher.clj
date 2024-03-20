#!/usr/bin/env bb
(require '[clojure.string :as str])

(def home (System/getenv "HOME"))
(def os-dark (-> (System/getenv "DARK_MODE") (= "1")))

(defn replace-in-file
  [path pattern replacement]
  (let [original (slurp path)
        updated  (str/replace-first original pattern replacement)]
    (spit path updated)))

(def program-configs
  ; NOTE: regexes are expected to have three groups. The middle group ($2)
  ; will be replaced with the new value.
  {:alacritty {:path  (str home "/.config/alacritty/alacritty.toml")
               :regex #"(alacritty-theme/themes/)([^\".]+)(.toml\")"
               :dark  "github_dark_dimmed"
               :light "ashes_light"}
   :helix     {:path  (str home "/.config/helix/config.toml")
               :regex #"(theme = \")([^\"]+)(\")"
               :dark  "modus_vivendi"
               :light "modus_operandi_tinted"}
   :zellij    {:path  (str home "/.config/zellij/config.kdl")
               :regex #"(theme \")([^\"]+)(\")"
               :dark  "terafox"
               :light "dayfox"}})

(defn update-program-config
  [program-config]
  (let [{:keys [path regex dark light]} program-config
        replacement                     (str "$1" (if os-dark dark light) "$3")]
    (replace-in-file path regex replacement)))

(->> program-configs vals (map update-program-config) dorun)
