;; See youtube video http://www.youtube.com/cmmagid
;; Create an Invoice from your Pomodoros
;; -------------------------------------



;; Input: From vitamin-r copy and past an RTF file from menubar tools / logs / toggle log book.
;; copy and paste the file into a blank emacs buffer.
;; Then run this function.
;; After that copy and paste the results into a spreadsheel like google docs
(defun cmm-vitamin-r ()
  "Lower case the current word or text selection."
  (interactive)
  (let (pos1 pos2 meat)
    (if (and transient-mark-mode mark-active)
	(setq pos1 (region-beginning)
	      pos2 (region-end))
      (setq pos1 (car (bounds-of-thing-at-point 'symbol))
	    pos2 (cdr (bounds-of-thing-at-point 'symbol))))
    
					; now, pos1 and pos2 are the starting and ending positions
					; of the current word, or current text selection if exists
    
    (goto-char (point-min))
    (flush-lines "^\\( \\|	\\)*$" nil nil t)

    (goto-char (point-min))
    (replace-string "

" "
" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))
    
    (goto-char (point-min))
    (replace-string "	" "  " nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (delete-matching-lines "^Status: " nil nil t)

    (goto-char (point-min))
    (delete-matching-lines "^Concentration Level: " nil nil t)

    (goto-char (point-min))
    (replace-string "Objective:" "{NL-tab}Objective:" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-string "Time: " "{tab}Time: " nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-string "Duration: " "{tab}Duration: " nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (set-variable (quote fill-column) 999999999 nil)
    (fill-paragraph nil t)

    (goto-char (point-min))
    (replace-string "{NL-tab}" "
	" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-string "────────────────────────────────" "{delete rest}" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-regexp "{delete rest} \\([a-fA-F0-9-]\\)*" "" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))
    
    (goto-char (point-min))
    (replace-string "{tab}" "	" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-string "	Duration: " "	" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))


    (goto-char (point-min))
    (replace-string "	Time: " "	" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-string "	Objective: " "	" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (insert "	OBJECTIVE	TIME	DURATION")
    
    )
  )



;; To get the input for this function do the following.  Run the
;; function above then past it into a spreadsheet like google docs
;; spreadsheet.  Highlight the duration's column and copy it.  Then
;; past that column into a buffer.  Not all modes work so try
;; fundamental-mode if there are issues when running this function.
;; After running this function copy and past the results into a ruby
;; script/console window for repl evaluation. 
(defun cmm-add-durations ()
  "Lower case the current word or text selection."
  (interactive)
  (let (pos1 pos2 meat)
    (if (and transient-mark-mode mark-active)
	(setq pos1 (region-beginning)
	      pos2 (region-end))
      (setq pos1 (car (bounds-of-thing-at-point 'symbol))
	    pos2 (cdr (bounds-of-thing-at-point 'symbol))))
    
					; now, pos1 and pos2 are the starting and ending positions
					; of the current word, or current text selection if exists
    
    (goto-char (point-min))
    (replace-string " minute" ".minute" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-string " second" ".second" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-string " hour" ".hour" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))

    (goto-char (point-min))
    (replace-regexp "[0-9]+" "+ \\&" nil (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))


    (goto-char (point-min))
    (delete-matching-lines "DURATION" nil nil t)

    (goto-char (point-min))
    (flush-lines "^\\( \\|	\\)*$" nil nil t)

    (goto-char (point-min))
    (set-variable (quote fill-column) 999999999 nil)
    (fill-paragraph nil t)


    (goto-char (point-min))
    (search-forward "+")
    (backward-delete-char-untabify 1 nil)

    (goto-char (point-min))
    (insert "(")


    (goto-char (point-max))
    (backward-word 1)
    (forward-word 1)
    (insert ") / (60.0 * 60.0)")

    ;; ;; put your code here.
    
    ;; ;; Some example of things you might want to do
    ;; (downcase-region pos1 pos2) ; example of a func that takes region as args
    ;; (setq meat (buffer-substring-no-properties pos1 pos2)) ; grab the text.
    ;; (delete-region pos1 pos2) ; get rid of it
    ;; (insert "newText") ; insert your new text
    
    )
  )



;;; (( 25.minutes + 53.minutes + 28.seconds + 25.minutes + 19.minutes + 30.seconds + 25.minutes + 1.hour + 39.minutes + 3.seconds +  25.minutes + 25.minutes + 25.minutes + 34.minutes + 25.minutes + 2.minutes + 59.seconds + 25.minutes + 25.minutes + 25.minutes + 25.minutes + 25.minutes + 25.minutes) / 60.0)
;;;=> 534.0