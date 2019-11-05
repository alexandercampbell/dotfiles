;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(emacs-lisp
     clojure
     helm
     auto-completion
     better-defaults
     git
     markdown
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking
     )))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-light spacemacs-dark)
   dotspacemacs-default-font '("Iosevka" :size 13 :weight normal :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-use-non-native t
   dotspacemacs-line-numbers t
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init () "Useful for variables that need to be set before packages are loaded.")

(defun dotspacemacs/user-config ()
  "Runs after packages are loaded."
  (setq create-lockfiles nil)
  (setq vc-follow-symlinks t)

  ; For some reason I have to do this. Don't know why. I get an error when
  ; solarized-gruvbox-dark appears in dotspacemacs-themes.
  ;(load-file "$HOME/dotfiles/vendor/solarized-gruvbox-dark-theme.el")

  (define-key evil-normal-state-map (kbd "q") 'delete-window)
  (define-key evil-normal-state-map (kbd "w") 'save-buffer))

