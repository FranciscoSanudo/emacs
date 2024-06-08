#!/bin/bash

# This is one shot script that will set your emacs and minimal config for your rhel/centos box

init_file=~/.emacs.d/init.el

#For testing purposes, use it first and iterate
# init_file=~/file_01.el

echo "1. Update system"
yum update -y
echo ""

echo "2. Install emacs, python and tools"
yum install python3 python3-pip emacs -y
echo ""

echo "3. Checking emacs configuration"
if [ -f "$init_file" ]; then
    echo "File: $(init_file) file already exists. Everything is good!"
else
    touch "$init_file"
    echo ";; Linux configuration file for centos/rhel
;; User: Francisco S.; File created on: $(date)

(require 'ob-python)
(require 'browse-url)
;; Load other languages for Org Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (sh . t)
))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable more stable melpa, but only if you want to, not mandatory
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; Set file extensions for tangling
(eval-after-load 'org
  '(add-to-list 'org-babel-tangle-lang-exts '("python3" . "py")))

;; Enable shell-mode for Bash scripts
(add-to-list 'auto-mode-alist '("\\.sh\\'" . shell-script-mode))

;; Enable python-mode for Python scripts
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;; Configure colors for Org files
(setq org-src-fontify-natively t)

;; Enable capabilities for org-mode files
(add-hook 'org-mode-hook 'org-indent-mode) ;; Indentation in org-mode
(add-hook 'org-mode-hook 'auto-fill-mode) ;; Auto-fill mode for text wrapping

;; Enable viper-mode
(require 'viper)
(viper-mode 1)

;; Enable mouse support
(xterm-mouse-mode 1)
(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))

;; Other custom configurations can be added below

(provide 'init)" > $init_file
fi
echo "New file created"
echo ""
