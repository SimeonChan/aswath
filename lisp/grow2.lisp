(defun grow2 (epic a0 dcov roce ncash)
  (let* ((theta1 (- 1 (/ 1 dcov)))
         (g1 (* roce theta1))
         (h1 0.1)
         (r (/ (+ 1 g1) (+ 1 h1)))
         (r5 (expt r 5))
         (p1-num (* a0 (- 1 theta1) r (- 1 r5)))
         (p1 (/ p1-num (- 1 r)))
         (gt 0.025)
         (ct 0.08)
         (pt0-num (* a0 r5 (+ 1 gt)))
         (pt0 (/ pt0-num ct))
         (voa (+ p1 pt0))
         (voe (+ voa ncash)))
    ;;(break)
    (format t "~a ~a" epic voe)))

(grow2 "pay" 44.3 1.5 0.427 41.6) ; correct as at 05-sep-2014
         

             
