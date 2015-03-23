(define-syntax test-check
  (syntax-rules ()
    ((_ title tested-expression expected-result)
     (begin
       (display "Testing ")
       (display title)
       (newline)
       (let* ((expected expected-result)
              (produced tested-expression))
         (or (equal? expected produced)
             (error (list title 'failed
                          (list 'input 'tested-expression)
                          (list 'expected expected)
                          (list 'produced produced)))))))))
