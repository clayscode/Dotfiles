;;; ob-velo.el --- org-babel functions for velo evaluation
;; Author: your name here
;; Keywords: literate programming, reproducible research
;; Homepage: https://orgmode.org
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file is not intended to ever be loaded by org-babel, rather it
;; is a velo for use in adding new language support to Org-babel.
;; Good first steps are to copy this file to a file named by the
;; language you are adding, and then use `query-replace' to replace
;; all strings of "velo" in this file with the name of your new
;; language.
;;
;; If you have questions as to any of the portions of the file defined
;; below please look to existing language support for guidance.
;;
;; If you are planning on adding a language to org-babel we would ask
;; that if possible you fill out the FSF copyright assignment form
;; available at https://orgmode.org/request-assign-future.txt as this
;; will make it possible to include your language support in the core
;; of Org-mode, otherwise unassigned language support files can still
;; be included in the contrib/ directory of the Org-mode repository.

;;; Requirements:

;; Use this section to list the requirements of this language.  Most
;; languages will require that at least the language be installed on
;; the user's system, and the Emacs major mode relevant to the
;; language be installed as well.

;;; Code:
(require 'ob)
(require 'ob-ref)
(require 'ob-comint)
(require 'ob-eval)
(require 'ob-async)
;; possibly require modes required for your language

(defgroup ob-velo nil
  "Org Babel Velo Package"
  :group 'lang
  )
;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("velo" . "vql"))

;; optionally declare default header arguments for this language
(defvar org-babel-default-header-args:velo '())

;; This function expands the body of a source code block by doing
;; things like prepending argument definitions to the body, it should
;; be called by the `org-babel-execute:velo' function below.
;; This is the main function which is called to evaluate a code
;; block.
;;
;; This function will evaluate the body of the source code and
;; return the results as emacs-lisp depending on the value of the
;; :results header argument
;; - output means that the output to STDOUT will be captured and
;;   returned
;; - value means that the value of the last statement in the
;;   source code block will be returned
;;
;; The most common first step in this function is the expansion of the
;; PARAMS argument using `org-babel-process-params'.
;;
;; Please feel free to not implement options which aren't appropriate
;; for your language (e.g. not all languages support interactive
;; "session" evaluation).  Also you are free to define any new header
;; arguments which you feel may be useful -- all header arguments
;; specified by the user will be available in the PARAMS variable.
(defun org-babel-execute:velo (body params)
  "Execute a block of Velo code with org-babel.
This function is called by `org-babel-execute-src-block'"
  (message "executing Velo source code block")
  (message (format "%s" (assoc-default :format params)))
  (message (format "%s" (assoc-default :loc params)))
  (message (format "%s" (assoc-default :scope params)))
  (message (format "%s" (assoc-default :art_dir params)))
  (let*
      ((processed-params (org-babel-process-params params))
       (in-file (org-babel-temp-file "velo" ".vql"))
       (format (assoc-default :format params))
       (loc (assoc-default :loc params))
       (scope (assoc-default :scope params))
       (art_dir (assoc-default :art_dir params))
       (verbose (assoc-default :verbose params))
       )
;;        (verbosity (or (cdr (assq :verbosity params)) 0))
    (with-temp-file in-file
      (insert body))
    (org-babel-eval
     (format "velof %s %s %s %s %s %s"
             format
             (org-babel-process-file-name in-file)
             loc
             scope
             art_dir
             verbose)
     "")))
(defun org-babel-velo-table-or-string (results)
  "If the results look like a table, then convert them into an
Emacs-lisp table, otherwise return the results as a string."
  )
(provide 'ob-velo)
