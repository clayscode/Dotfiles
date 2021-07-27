;;; packages.el --- velo layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
;;
;; Author: clay
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `velo-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `velo/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `velo/pre-init-PACKAGE' and/or
;;   `velo/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst velo-packages
  '(
    (ob-velo :location local)
   )
)


;;; packages.el ends here

(defun velo/init-exec ()
  (progn
    (spacemacs/declare-prefix-for-mode 'velo-mode "me" "execute")
    (spacemacs/set-leader-keys-for-major-mode
      'velo-mode "eb" 'spacemacs/velo/exec-buffer)
)
  )
(defun velo/pre-init-ob-velo ()
  (spacemacs|use-package-add-hook org
    :post-config
    (use-package ob-velo
                :init (add-to-list 'org-babel-load-languages '(velo . t)))))

(defun velo/init-ob-velo())
