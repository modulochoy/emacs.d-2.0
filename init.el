(require 'package)
(package-initialize)

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(when (not package-archive-contents)
    (package-refresh-contents))

(setq auto-mode-alist
      (cons '("\\.as$" . c-mode)
	    auto-mode-alist))

(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (if (eq 'shell-mode major-mode)
	  (comint-dynamic-complete)
	(dabbrev-expand arg))
    (indent-according-to-mode)))

(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))

(add-hook 'c-mode-hook'my-tab-fix)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
;; java/c/c++
(setq c-basic-offset 2)
;; web development
(setq coffee-tab-width 2) ; coffeescript
(setq javascript-indent-level 2) ; javascript-mode
(setq js-indent-level 2) ; js-mode
(setq js2-basic-offset 2) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
(setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
(setq web-mode-css-indent-offset 2) ; web-mode, css in html file
(setq web-mode-code-indent-offset 2) ; web-mode, js code in html file
(setq css-indent-offset 2) ; css-mode

;;(add-to-list 'auto-mode-alist '("\\.es6\\'" . js-mode))
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
     (add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
     (global-set-key "\C-cl" 'org-store-link)
     (global-set-key "\C-ca" 'org-agenda)
     (global-set-key "\C-cb" 'org-iswitchb)

(setq org-todo-keywords
			'((sequence "TODO(t)" "|" "DONE(d)")
				(sequence "FIXME(f)" "|" "FIXED(x)")
				(sequence "Q:(q)" "|" "A:(a)")
				(sequence "NOTE")
				))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "M-p") 'outline-up-heading)
            (local-set-key (kbd "M-[") 'org-backward-heading-same-level)
            (local-set-key (kbd "M-]") 'org-forward-heading-same-level)))


(add-hook 'comint-mode-hook
 (lambda ()
   (define-key comint-mode-map (kbd "M-p") 'comint-previous-matching-input-from-input)))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'batch-mode "batch-mode.el" nil t)
(add-to-list 'auto-mode-alist '("\\.bat$" . batch-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(setq js2-highlight-level 3)

(add-hook 'eshell-mode-hook (lambda ()
			      (custom-color-shell-theme)))

(cua-mode 1)

(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-gnome2)
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-buffer-local")
(require 'color-theme-buffer-local)

(add-hook 'org-mode-hook (lambda ()
			    (custom-color-org-theme)))

(add-hook 'java-mode-hook (lambda ()
			    (custom-color-code-theme)))

;; Set Linum-Mode on
(global-linum-mode 1)
;; Linum-Mode and add space after the number
(setq linum-format "%d ")

(global-set-key (kbd "C-c n") 'comment-region)
(global-set-key (kbd "C-c m") 'uncomment-region)

(show-paren-mode 1) ; turn on paren match highlighting
(setq show-paren-style 'expression) ; highlight entire bracket expression

;; android-mode
(add-to-list 'load-path "~/.emacs.d/lisp/android-mode")
(require 'android-mode)
(setq android-mode-sdk-dir "~/dev/adt/sdk")

(add-to-list 'load-path "~/.emacs.d/lisp/scss-mode")
;;(require 'scss-mode)
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(add-to-list 'auto-mode-alist '("\\.handlebars\\'" . html-mode))

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'javascript-mode-hook 'javascript-custom-setup)
(defun javascript-custom-setup ()
  (moz-minor-mode 1))

(custom-set-variables
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil)
 '(transient-mark-mode (quote (only . t))))
(custom-set-faces)
(put 'erase-buffer 'disabled nil)

(global-set-key (kbd "\C-x <down>") 'custom-shrink-window)
(global-set-key (kbd "\C-x <up>") 'custom-enlarge-window)

(defun custom-enlarge-window ()
  (interactive)
  (enlarge-window 8))

(defun custom-shrink-window ()
  (interactive)
  (shrink-window 8))

(defun custom-color-light-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-aalto-light (current-buffer)))

(defun custom-color-default-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-gnome2 (current-buffer)))

(defun custom-color-dark-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-charcoal-black (current-buffer)))

(defun custom-color-shell-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-euphoria (current-buffer)))

(defun custom-color-org-theme ()
  (interactive)
 ;; (color-theme-euphoria))
  (color-theme-buffer-local 'color-theme-pok-wog (current-buffer)))

(defun custom-color-code-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-bharadwaj-slate (current-buffer)))

(setq org-startup-truncated nil)

(setq default-directory (concat (getenv "HOME")))

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

(setq backup-directory-alist '(("." . "~/.emacs_backups")))

(global-set-key (kbd "\C-c b") 'helm-buffers-list)

(setq bookmark-save-flag 1)
(desktop-save-mode 1)

(global-set-key (kbd "C-x p") 'previous-multiframe-window)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 80))
(add-to-list 'default-frame-alist '(alpha 85 80))

(global-set-key (kbd "M-<up>") (lambda () (interactive) (previous-line 8)))
(global-set-key (kbd "M-<down>") (lambda () (interactive) (next-line 8)))
