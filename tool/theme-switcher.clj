#!/usr/bin/env bb
(require '[clojure.string :as str])

(def home (System/getenv "HOME"))
(def chosen-theme :clean)
(def themes
  {:hacker  {:alacritty {:dark "alabaster_dark" :light "ayu_light"}
             :helix     {:dark "modus_vivendi" :light "emacs"}
             :zellij    {:dark "retro-wave" :light "pencil-light"}}
   :gruvbox {:alacritty {:dark "gruvbox_dark" :light "gruvbox_light"}
             :helix     {:dark "gruvbox_dark_hard" :light "gruvbox_light_hard"}
             :zellij    {:dark "gruvbox-dark" :light "gruvbox-light"}}
   :clean   {:alacritty {:dark "kanagawa_dragon" :light "atom_one_light"}
             :helix     {:dark "kanagawa" :light "modus_operandi"}
             :zellij    {:dark "kanagawa" :light "catppuccin-latte"}}})

(def program-configs
  ; NOTE: regexes are expected to have three groups. The middle group ($2)
  ; will be replaced with the new value.
  {:alacritty {:path  (str home "/.config/alacritty/alacritty.toml")
               :regex #"(alacritty-theme/themes/)([^\".]+)(.toml\")"}
   :helix     {:path  (str home "/.config/helix/config.toml")
               :regex #"(theme = \")([^\"]+)(\")"}
   :zellij    {:path  (str home "/.config/zellij/config.kdl")
               :regex #"(theme \")([^\"]+)(\")"}})

(def os-is-dark (= "1" (System/getenv "DARK_MODE")))

(defn replace-in-file
  [path pattern replacement]
  (spit path (str/replace-first (slurp path) pattern replacement)))

(defn update-program-config
  [program-id]
  (let [{:keys [path regex]} (get program-configs program-id)
        theme                (get themes chosen-theme)
        {:keys [dark light]} (get theme program-id)
        replacement          (str "$1" (if os-is-dark dark light) "$3")]
    (replace-in-file path regex replacement)))

(dorun (map update-program-config (keys program-configs)))
