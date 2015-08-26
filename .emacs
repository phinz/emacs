;; @see http://www.emacswiki.org/emacs/JorgenSchaefersEmacsConfig

;; Pfad zu den Lisp Packages
(add-to-list 'load-path "~/.emacs.d/lisp/")

;;;;;;;;;;;;;;;;;;
;; LISP MODULES ;;
;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "C:/Python34/Lib/site-packages")

;; Load webkit Browser @see http://www.emacswiki.org/emacs/WebKit#toc4
;; (load "webkit/webkit.el")

;; Installiert das MELPA Package System
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; Lädt die Monokai Theme beim starten
(load-theme 'monokai t)

;; Browser Einstellungen
;; Damit die Funktionen wie "browser-url-firefox" funktionieren muss sich der Firefox Pfad in der PATH Umgebungsvariabel befinden.
;; Oder wir fügen ihn hier manuell nach:
(setenv "PATH"
        (concat
         "C:/Program Files (x86)/Mozilla Firefox/"
         ";"
         (getenv "PATH")))

;; Standard Einstellungen
(setq-default
 ;; Neue Zeile ans Dateiende...
 require-final-newline 'ask
 ;; Keine zwei leerzeichen nach einem Doppelpunkt
 sentence-end-double-space nil
 ;; Meine E-Mail-Adresse
 user-mail-address "hinz@elemente.ms"
 ;; Standard Browser
 browse-url-browser-function 'fc-choose-browser
)

;;;;;;;;;;;;;;
;; Commands ;;
;;;;;;;;;;;;;;

;; Browserwahl
(defun fc-choose-browser (url &rest args)
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (browse-url-firefox url)
    (progn
      (split-window-right)
      (eww url)
    )))

;; Lorem ipsum Platzhalter
(defun lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
          "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad "
          "minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
          "aliquip ex ea commodo consequat. Duis aute irure dolor in "
          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
          "culpa qui officia deserunt mollit anim id est laborum."))

;; Leo Übersetzer
(defun leo (word)
  (interactive "sWord: ")
  (browse-url (format "http://dict.leo.org/?search=%s" word)))

;; PHP Docs
(defun php-doc (word)
  (interactive "sWord: ")
  (browse-url (format "http://php.net/manual-lookup.php?pattern=%s" word)))

;; MySQL Docs
(defun mysql-doc (word)
  (interactive "sWord: ")
  (browse-url (format "https://search.oracle.com/search/search?search.timezone=-120&search_startnum=&search_endnum=&num=10&search_dupid=&exttimeout=false&actProfId=0&q=%s&group=MySQL&sw=t&search_p_main_operator=all&search_p_atname=&adn=&search_p_op=equals&search_p_val=&search_p_atname=&adn=&search_p_op=equals&search_p_val=" word)))

;; TYPO3 TCA
(defun typo3-doc-tca (word)
  (interactive "sWord: ")
  (browse-url (format "https://docs.typo3.org/typo3cms/TCAReference/search.html?q=%s&check_keywords=yes&area=default" word)))

;; TYPO3 TypoScript
(defun typo3-doc-ts (word)
  (interactive "sWord: ")
  (browse-url (format "https://docs.typo3.org/typo3cms/TyposcriptReference/search.html?q=%s" word)))

;; TYPO3 TSconfig
(defun typo3-doc-tsconfig (word)
  (interactive "sWord: ")
  (browse-url (format "https://docs.typo3.org/typo3cms/TSconfigReference/search.html?q=%s&check_keywords=yes&area=default" word)))

;; TYPO4 API
(defun typo3-api (word)
  (interactive "sWord: ")
  (browse-url (format "http://typo3.org/api/typo3cms/search/all_17.html?%s" word)))

;; Google
(defun google (what)
  (interactive "sSearch: ")
  (browse-url (concat "http://www.google.de/search?q=" what)))

;;;;;;;;;;;;
;;; ido-mode

(if (not (fboundp 'ido-mode))
    (iswitchb-mode 1)
  (ido-mode 1)
  (setq ido-everywhere t
        ido-case-fold t
        ido-use-filename-at-point t
        ido-use-url-at-point t
        ido-confirm-unique-completion t
        ido-auto-merge-work-directories-length -1)

  (add-hook 'ido-setup-hook
            (lambda ()
              (define-key ido-common-completion-map (kbd "C-c")
                (make-sparse-keymap))
              (define-key ido-common-completion-map (kbd "C-c C-u")
                'fc-ido-copy-selection)
              (define-key ido-file-dir-completion-map (kbd "<up>")
                'ido-prev-work-directory)
              (define-key ido-file-dir-completion-map (kbd "<down>")
                'ido-next-work-directory))))
