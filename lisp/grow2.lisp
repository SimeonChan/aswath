(defun grow2a (epic a0 theta1 g1 ncash h1 gt ct)
  (let* ((r (/ (+ 1 g1) (+ 1 h1)))
         (r5 (expt r 5))
         (p1-num (* a0 (- 1 theta1) r (- 1 r5)))
         (p1 (/ p1-num (- 1 r)))
         (pt0-num (* a0 r5 (+ 1 gt)))
         (pt0 (/ pt0-num ct))
         (voa (+ p1 pt0))
         (voe (+ voa ncash)))
    ;;(break)
    (format t "~4a ~10,2F~%" epic voe)))

(defun grow2b (epic b0 dcov roce ncash &key (h1 0.1) (gt 0.025) (ct 0.08) (taxr 0.21))
  (let* ((a0 (* b0 (- 1 taxr)))
	 (theta1 (- 1 (/ 1 dcov)))
	 (g1 (* roce theta1)))
    (grow2a epic a0 theta1 g1 ncash h1 gt ct)))

(grow2a "MMM" 3586.0 0.3 0.075 (+ 2476 778 -5297 -1215) 0.0863 0.03 0.0676) ; 60762 correct as at 11-Sep-2014
(grow2b "PAY" 44.3 1.5 0.427 41.6) ; 714 correct as at 11-sep-2014
(grow2b "TSCO"  2353.0 2.99 0.0915 -6597.0) ; 16069 correct as at 11-Sep-2014
(grow2b "HOME" 170 2.2 0.024 331)
(grow2b "HIK" 443 7.68 0.305 (- 3483  5779) :h1 0.0791 :gt 0.0295 :ct 0.0791)
         

             
