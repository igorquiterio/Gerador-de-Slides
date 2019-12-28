;Igor da Costa Quiterio - Paradigmas de Linguagens de Programação
;T2-gramatica

#lang racket

(provide (all-defined-out))
(require "svg.rkt")

;item();
(define (item vtr arq saida lista-items marcador vtr-item)
  (define frase (string-append marcador " " (string-replace (rmv-und(string-join (cdr vtr-item))) "*" "")))
  (for ([palavra (cdr vtr-item)])
    (if (regexp-match #rx".*\\*" palavra) (adiciona-remissivo palavra) "palavra comum"))
  (bloco vtr arq saida (append  lista-items (list frase))))

;;bloco();;
(define (bloco vtr arq saida lista-items)
  (define novo-vtr (string-split(read-line arq)))
  (define marcador (cond [(equal? (cadr vtr) "c") "◦"]
                         [(equal? (cadr vtr) "C") "○"]
                         [(equal? (cadr vtr) "q") "▫"]
                         [(equal? (cadr vtr) "Q") "◻"]))
  (define nome-bloco (rmv-und(caddr vtr)))
  (cond [(equal? (car novo-vtr) "i") (item vtr arq saida lista-items marcador novo-vtr)]
        [(and (equal? (car novo-vtr) "clb") (> (length vtr) 3)) (begin (escreve-bloco nome-bloco lista-items arq saida (fourth vtr) (fifth vtr) (sixth vtr) (seventh vtr)) (slide novo-vtr arq saida))]
        [(equal? (car novo-vtr) "clb") (begin (escreve-bloco nome-bloco lista-items arq saida cf1 cl1 cf2 cl2) (slide novo-vtr arq saida))]))

;;;slide();;;
(define (slide vtr arq saida) 
  (define novo-vtr (string-split(read-line arq)))
  (cond [(equal? (car novo-vtr) "blc") (bloco novo-vtr arq saida (list))]
        [(equal? (car novo-vtr) "dls") (termina-slide saida)]
        ))

;;;;cria-slide();;;;
(define (cria-slide vtr arq saida)
  (define titulo-slide (rmv-und(string-join(cdr vtr))))
  (adiciona-topico titulo-slide 0); o 0 indica que é um slide e nao uma seccao
  (cria-corpo-slide titulo-slide saida)
  (slide vtr arq saida))

;;;;;cabecalho();;;;;
(define (cabecalho vtr arq dirsaida)
  (let ([comando (car vtr)])
    (cond [(equal? comando "ta") (titulo-apresentacao vtr)]
          [(equal? comando "at") (autor-trabalho vtr)]
          [(equal? comando "sh") (altura vtr)]
          [(equal? comando "sw") (largura vtr)]
          [(equal? comando "cf1") (cor-cf1 vtr)]
          [(equal? comando "cl1") (cor-cl1 vtr)]
          [(equal? comando "cf2") (cor-cf2 vtr)]
          [(equal? comando "cl2") (cor-cl2 vtr)]
          [(equal? comando "sec") (seccao vtr)]
          [(equal? comando "sld") (cria-slide vtr arq dirsaida)])))

;;;;;;produz-slides();;;;;;
(define (produz-slides arqsli dirsaida)
  (define in (open-input-file arqsli))
  (define saida (string-append dirsaida "/" (string-trim (last (string-split arqsli "/")) ".txt")))
  ;(displayln saida)
  (for ([linha (in-lines in)])
    (define vetorlinha (string-split linha))
    (if (not (null? vetorlinha)) (cabecalho vetorlinha in saida) (displayln linha)))
  (close-input-port in)
  (faz-capa-slide saida)
  (faz-topicos saida)
  (faz-indice-remissivo saida)
  (limpa)
  )

;;remove-underscore();;
(define (rmv-und frase)
  (string-replace frase  "_" " "))

;;;;titulo-apresentacao();;;;
(define (titulo-apresentacao vtr)
  (define-ta (rmv-und(string-join (cdr vtr)))))

;;;;autor-trabalho();;;;
(define (autor-trabalho vtr)
  (define-at (rmv-und(string-join (cdr vtr)))))

;;;;altura();;;;
(define (altura vtr)
  (define-sh (string->number(cadr vtr))))

;;;;largura();;;;
(define (largura vtr)
  (define-sw (string->number(cadr vtr))))

;;;;cor-cf1();;;;
(define (cor-cf1 vtr)
  (define-cf1  (cadr vtr)))

;;;;cor-cf2();;;;
(define (cor-cf2 vtr)
  (define-cf2  (cadr vtr)))

;;;;cor-cl1();;;;
(define (cor-cl1 vtr)
  (define-cl1  (cadr vtr)))

;;;;cor-cl2();;;;
(define (cor-cl2 vtr)
  (define-cl2  (cadr vtr)))

;;;;seccao();;;;
(define (seccao vtr)
  (define nomescc (rmv-und(string-join(cdr vtr))))
  (nova-seccao nomescc)
  (adiciona-topico nomescc 1))
