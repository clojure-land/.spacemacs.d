(defun plexus/enable-recording-modeline ()
  (interactive)
  (add-to-list #'mode-line-format '(:eval (plexus/recording-modeline))))


(defun plexus/recording-modeline ()
  `((:propertize " ⚫ " font-lock-face (:foreground ,(case plexus/record-state
                                                       ('recording "red")
                                                       (t "gray"))
                                                    :background "black"))
    (:propertize " 🎥 " font-lock-face (:background ,(if plexus/record-video "green" "black") :foreground "white"))
    (:propertize " 🔊 " font-lock-face (:background ,(if plexus/record-audio "red" "black") :foreground "white"))
    (:propertize " " font-lock-face (:background "white" :foreground "black"))
    (:propertize (:eval plexus/record-counter) font-lock-face (:background "white" :foreground "black"))
    (:propertize " " font-lock-face (:background "white" :foreground "black"))
    " "))

;; lambda island

(defun plexus/lambdaisland-recording-setup ()
  (interactive)
  (set-frame-font "Inconsolata-17" t
                  (list (make-frame '((name . "islandmacs"))))))

(defun plexus/resize-for-lambda-island ()
  (setq frame-resize-pixelwise t)
  (set-frame-width (selected-frame) 1265 nil t)
  (set-frame-height (selected-frame) 720 nil t))

(defun plexus/ffmpeg-position ()
  (let* ((f (frame-position))
         (x (car f))
         (y (cdr f)))
    ;; these offsets have been carefully, experimentally verified. They
    ;; compensate for the drop shadow and title bar that is somehow considered
    ;; part of the frame
    (format "%d,%d" (mod (+ x 10) 1920) (+ y 35))))


(defun plexus/minimal-decorations ()
  (interactive)
  (when linum-mode
    (linum-mode))
  (setq mode-line-format '("%e"
                           mode-line-front-space
                           mode-line-frame-identification
                           mode-line-buffer-identification
                           "   "
                           mode-line-position)))

(defun plexus/screencast-mode ()
  (interactive)
  (plexus/minimal-decorations)
  (blink-cursor-mode 0)
  (setq indicate-empty-lines nil)
  (set-frame-parameter nil 'left-fringe 18)
  (centered-cursor-mode))

(frame-parameter (selected-frame) 'right-fringe)

;;(setq mode-line-format '("%e" (:propertize "    Lambda Island | 37. Transducers" font-lock-face (:foreground "#b294bb"))))

