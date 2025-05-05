;; Manage packages
;; Initialize package sources
(require 'package)

(setq package-archives '(
    ("melpa" . "https://melpa.org/packages/")
    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
    ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(setq inhibit-startup-message t)

(use-package evil
  :diminish
  :init
  ;; use ctrl-h + v to view what each option does
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)  ;; not turning on evil for other modes
  (setq evil-want-C-u-scroll t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  ;; enable redo with C-r
  (evil-set-undo-system 'undo-redo)
  ;; make :q/:wq kill the buffer, and not Emacs
  (global-set-key [remap evil-quit] 'kill-buffer-and-window)
)
;; Sane evil config for a lot of modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Key-mapping utility
(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer my-leader-def
     :states '(normal visual motion emacs insert)
     :prefix "SPC")
  (general-create-definer my-local-leader-def
    :states '(normal visual motion emacs)
    :prefix ",")
  ;; finders (projectile and counsel)
  (my-leader-def
    :states '(normal visual)
    :keymaps 'override
    "f"  '(:ignore t :wk "Find")
    "ff" '(projectile-find-file :wk "Find file (project)")
    "fg" '(counsel-projectile-rg :wk "Ripgrep (project)")
    "fw" '(projectile-switch-project :wk "Switch project")
    "fb" '(counsel-ibuffer :wk "Find buffer")
    "fc" '(counsel-grep :wk "Grep")
    "fo" '(counsel-minibuffer-history :wk "Find prev")
    "f;" '(counsel-M-x :wk "Find command")
  )
  ;; buffer navigation
  (general-nmap
    :states '(normal)
    :keymaps 'override
    "]d" 'flymake-goto-next-error
    "[d" 'flymake-goto-prev-error
    "]c" 'diff-hl-next-hunk
    "[c" 'diff-hl-previous-hunk
  )
  ;; zooming
  (global-set-key (kbd "C-=") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)
)

;; Ivy
(use-package ivy
  :diminish  ;; hide the minor mode from mode line
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
;; Provide useful descriptions in ivy minibuffers
(use-package ivy-rich
  :after counsel
  :diminish
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :diminish
  :bind (
     ("M-x" . counsel-M-x)
     ("C-x b" . counsel-ibuffer)
     ("C-x C-f" . counsel-find-file)
     :map minibuffer-local-map
     ("C-r" . 'counsel-minibuffer-history)
  )
  :config
  (counsel-mode 1)
  ;; don't start searches with ^ to allow fuzzy search
  (setq ivy-initial-inputs-alist nil))

;; Better help
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


;; Project management
(use-package projectile
  :config (projectile-mode)
  :init
  (setq projectile-project-search-path '(("~/dev/" . 3)))
  (setq projectile-switch-project-action 'projectile-dired)
)

(use-package counsel-projectile
  :diminish
  :config (counsel-projectile-mode))

;; Which-key
(use-package which-key
  :defer 0
  :diminish ;; which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; autocompletion
(use-package company
  :diminish
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map ("<tab>" . company-complete-common-or-cycle))
        ;; use this if you want tab for cycling
        ;; (:map company-active-map ("<tab>" . company-complete-common-or-cycle))
        ;; use this if you want tab for completion
        ;; (:map company-active-map ("<tab>" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :diminish
  :hook (company-mode . company-box-mode))

;; Bracket coloring for Lisp
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Logging key events
(use-package command-log-mode
  :commands command-log-mode)

;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Note: this is for the non-gnu version of org-mode.
(defun my-org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  ;; stop emacs from automatically 
  (electric-indent-mode -1)
  (setq evil-auto-indent nil)
  ;; modify default ellipsis marker (...)
  (setq org-ellipsis " ▾")
  ;; hide emphasis markers
  (setq org-hide-emphasis-markers t)
  ;; syntax highlighting in org src blocks
  (setq org-src-fontify-natively t)
  ;; highlight inline LaTeX
  (setq org-highlight-latex-and-related '(native))
  ;; automatically change bullet type when indenting
  ;; Ex: indenting a + makes the bullet a *.
  (setq org-list-demote-modify-bullet
        '(("+" . "-") ("-" . "+") ("+" . "-")))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
)
;; fonts
(dolist (face '((org-level-1 . 2)
                (org-level-2 . 1.6)
                (org-level-3 . 1.3)
                (org-level-4 . 1.2)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.05)
                (org-level-8 . 1.05)))
)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("bash" . "src bash"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(use-package org-contrib
  :hook (org-mode . my-org-mode-setup)
  :config
  (require 'ox-md nil t)
)

(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)

  ;; Load the theme of your choice.
  ;; (load-theme 'modus-operandi)
  ;; (load-theme 'modus-operandi-deuteranopia)
  (load-theme 'modus-operandi-tritanopia)
)

;; More custom config
;; Theme
;; (load-theme 'tango t)

;; Sane defaults
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(menu-bar-mode -1)          ; Disable the menu bar
(blink-cursor-mode -1)      ; Disable cursor blinking
(setq visible-bell 1)       ; Disable bell
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Backup files
(setq make-backup-files nil) ; stop creating ~ files
;; Recovery files
(setq auto-save-default nil) ; stop creating #...# files

;; Note: To get all fonts on the system, go to the *scratch* buffer and type
;; `(font-family-list` then <C-j> at the end of the line, then enter on the ...
;; at the end of the result.
(set-face-attribute 'default nil :font "JetBrainsMono NF" :height 110)
(set-face-attribute 'variable-pitch nil :font "Roboto" :height 132)
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono NF" :height 110)

;; Line numbers
;; Load the built-in line-number mode
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Shell
(setq explicit-shell-file-name "C:\\Program Files\\Powershell\\7\\pwsh.exe")
(setq shell-file-name "powershell")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1594eb8fc081be254c7df7b2a37e9808f79c94863366da6d34bbe735519a30f5" default))
 '(package-selected-packages
   '(modus-themes org-contrib doom-modeline company-box company command-log-mode rainbow-delimiters which-key counsel-projectile projectile helpful counsel ivy-rich ivy general evil-collection evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
