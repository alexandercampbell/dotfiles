;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(clojure
     emacs-lisp
     haskell
     markdown
     rust
     elm
     yaml

     helm
     auto-completion
     better-defaults
     spell-checking
     syntax-checking
     git
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
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
   dotspacemacs-default-font '("Iosevka" :size 12 :weight normal :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-loading-progress-bar nil
   dotspacemacs-fullscreen-use-non-native t
   dotspacemacs-line-numbers t
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init () "Useful for variables that need to be set before packages are loaded.")

(defun exec-buffer ()
  (interactive)
  (when (eq major-mode 'haskell-mode)
    (shell-command "stack run")))

(defun dotspacemacs/user-config ()
  "Runs after packages are loaded."
  (setq create-lockfiles nil)
  (setq vc-follow-symlinks t)
  (setq rust-format-on-save t)
  (setq haskell-stylish-on-save t)
  (setq haskell-mode-stylish-haskell-path "brittany")

  (setq-default tab-width 8)
  (setq-default standard-indent 8)
  (setq-default indent-tabs-mode t)
  (setq-default fill-column 80)
  (spacemacs/toggle-fill-column-indicator-on)
  (spacemacs/toggle-vi-tilde-fringe-off)

  (define-key evil-normal-state-map (kbd "SPC w v") 'split-window-right-and-focus)
  (define-key evil-normal-state-map (kbd "SPC w s") 'split-window-below-and-focus)
  (define-key evil-normal-state-map (kbd "q") 'delete-window)
  (define-key evil-normal-state-map (kbd "w") 'save-buffer)
  (define-key evil-normal-state-map (kbd "RET") 'exec-buffer))

