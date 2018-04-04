;;; third-part packages archivesss 
(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))

(package-initialize)

;;; interacitve completion tooling
(use-package ivy :ensure t :config (ivy-mode))
(use-package counsel :ensure t :config (counsel-mode))
(use-package swiper :ensure t :bind ("C-s" . swiper))
(use-package avy :ensure t)

;;; editing tools
(use-package paredit :ensure t
  :config (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

(use-package expand-region :ensure t
  :bind ("C-=" . er/expand-region))

(use-package multiple-cursors :ensure t
  :bind (("C-<" . mc/mark-previous-like-this)
	 ("C->" . mc/mark-next-like-this)))

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode))

;;; Git Porcelain
(use-package magit :ensure t
  :bind ("C-x g" . magit-status))

;;; IDE features
(use-package yasnippet :ensure t
  :config (yas-global-mode))

(use-package projectile :ensure t
  :config (projectile-global-mode))

;;; built-in features
(use-package dired-x)

(use-package saveplace 
  :config
  (save-place-mode))

(use-package flyspell
  :config
  (when (eq system-type 'windows-nt)
    (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/"))
  (setq ispell-program-name "asepll"
	ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

;;; customized preferrences
(global-set-key (kbd "C-c <f12>") 'customize-save-variable)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;; keybindings
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "M-/") 'hippie-expand)
