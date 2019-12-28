;Igor da Costa Quiterio - Paradigmas de Linguagens de Programação
;T2-svg

#lang racket

(provide (all-defined-out))


(define ta "apresentação de slides")
(define at "MODO EXPRESSO")
(define sh 300)
(define sw 500)
(define cf1 "purple")
(define cl1 "black")
(define cf2 "black")
(define cl2 "white")

(define lista-topicos (list))
(define indice-remissivo (list))
(define pagina 2)
(define seccao-atual "MODO EXPRESSO")
(define altura-bloco 0)

(define (junta elemento lista)
  (cond [(null? lista) null]
        [(equal? (caar lista) elemento) (cons (cadar lista) (junta elemento (cdr lista)))]
        [#t (junta elemento (cdr lista))]))

(define (faz-indice-remissivo saida)
  (proxima-pagina)
  (define nome (string-append saida "-slide" (number->string pagina)  "-indice remissivo.svg"))
  (define slide (open-output-file nome
                                  #:exists 'replace ))

  ;canvas
  (fprintf slide "<!-- Igor da Costa Quiterio -->")
  (fprintf slide "~n<svg height=\"~s\" width=\"~s\">" sh sw)
  (fprintf slide "~n<rect x=\"0.0\" y=\"0.0\" fill=\"#FFFFFF\" stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" sw sh)
  ;titulo
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" 5 5 cf1 (- sw 10) 15)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>Indice Remissivo</text>~n " (/ sw 2.0) 16 cl1)
  ;conteudo
  (define yy 60)
  (define remissivo-ord (sort indice-remissivo #:key car string<?))
  (define anterior " x x x x x")
  (for ([dupla remissivo-ord])
    (if (equal? anterior (car dupla)) 0 (begin (fprintf slide "~n<text text-anchor=\"start\" x=\"50\" y=\"~s\" fill=~s>∘~a ~a</text>~n " yy cl1 (car dupla) (string-join (junta (car dupla) remissivo-ord) ", ")) (set!  yy (+ yy 14))))
    (set! anterior (car dupla)))
  ;rodapé
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" 5 (- sh 20) cf1 (- sw 10) 15)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (/ sw 2.0) (- sh 8) cl1 at)

  (fprintf slide "</svg>")

  (close-output-port slide)
  )

(define (faz-topicos saida)
  (define nome (string-append saida "-slide2-topicos.svg"))
  (define slide (open-output-file nome
                                  #:exists 'replace ))
  ;canvas
  (fprintf slide "<!-- Igor da Costa Quiterio -->")
  (fprintf slide "~n<svg height=\"~s\" width=\"~s\">" sh sw)
  (fprintf slide "~n<rect x=\"0.0\" y=\"0.0\" fill=\"#FFFFFF\" stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" sw sh)
  ;titulo
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" 5 5 cf1 (- sw 10) 15)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>Tópicos</text>~n " (/ sw 2.0) 16 cl1)
  ;conteudo
  (define yy 60)
  (for ([palavra lista-topicos])
    (fprintf slide "~n<text text-anchor=\"start\" x=\"50\" y=\"~s\" fill=~s>~a</text>~n " yy cl1 palavra)
    (set! yy (+ yy 14)))
  ;rodapé
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" 5 (- sh 20) cf1 (- sw 10) 15)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (/ sw 2.0) (- sh 8) cl1 at)

  (fprintf slide "</svg>")

  (close-output-port slide)
  )

(define (termina-slide saida)
  (define nome (string-append saida "-slide" (number->string pagina) ".svg"))
  (define slide (open-output-file nome
                                  #:exists 'append ))
  (fprintf slide "~n</svg>")
  (close-output-port slide)
  )

(define (escreve-bloco nome-bloco lista arq saida f1 l1 f2 l2)
  (define nome (string-append saida "-slide" (number->string pagina) ".svg"))
  (define slide (open-output-file nome
                                  #:exists 'append ))
  (define tamanho-bloco (* 14 (length lista)))
  ;titulo do bloco
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\" rx=\"5\" ry=\"5\"/>" 40 altura-bloco f1 (- sw 80) 15)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (/ sw 2.0) (+ altura-bloco 12) l1 nome-bloco)
  ;bloco
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\" rx=\"5\" ry=\"5\"/>" 40 (+ altura-bloco 15) f2 (- sw 80) tamanho-bloco)
  (define altura-texto (+ altura-bloco 26))
  (for ([palavra lista])
    (fprintf slide "~n<text text-anchor=\"start\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " 50 altura-texto l2 palavra)
    (set! altura-texto (+ altura-texto 13)))
  (posic-bloco (+ tamanho-bloco 30 altura-bloco))
  (close-output-port slide)
)

(define (cria-corpo-slide titulo saida)
  (proxima-pagina)
  (define nome (string-append saida "-slide" (number->string pagina) ".svg"))
  (define slide (open-output-file nome
                                   #:exists 'replace ))
  ;canvas do slide
  (fprintf slide "<!-- Igor da Costa Quiterio -->")
  (fprintf slide "~n<svg height=\"~s\" width=\"~s\">" sh sw)
  (fprintf slide "~n<rect x=\"0.0\" y=\"0.0\" fill=\"#FFFFFF\" stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" sw sh)
  ;titulo da seccao
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" 5 5 cf1 (- sw 10) 15)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (/ sw 2.0) 16 cl1 seccao-atual)
  ;titulo do slide
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\" rx=\"5\" ry=\"5\"  />" 10 20 cf2 (- sw 20) 25)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (/ sw 2.0) 37 cl2 titulo)
  ;rodapé
  (fprintf slide "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" 5 (- sh 20) cf1 (- sw 10) 15)
  (fprintf slide "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (/ sw 2.0) (- sh 8) cl1 (string-append at ", slide: " (number->string pagina)))
  (posic-bloco 60)
  (close-output-port slide))

;;faz-capa();;
(define (faz-capa-slide dirsaida)
  (define nome (string-append dirsaida "-slide1-capa.svg"))
  (define capa (open-output-file nome
                                 #:exists 'replace ))
  (define widblc1 (/ sw 3.0))
  (define heiblc1 (/ sh 8.0))
  (define xblc1 (- (/ sw 2.0) (/ widblc1 2.0)))
  (define yblc1 (/ sh 6.0))
  (define yblc2 (+ yblc1 heiblc1 30))


  (fprintf capa "<!-- Igor da Costa Quiterio -->")
  (fprintf capa "~n<svg height=\"~s\" width=\"~s\">" sh sw)
  (fprintf capa "~n<rect x=\"0.0\" y=\"0.0\" fill=\"#FFFFFF\" stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\"/>" sw sh)

  (fprintf capa "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\" rx=\"5\" ry=\"5\" />" xblc1 yblc1 cf1 widblc1 heiblc1)
  (fprintf capa "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (+ xblc1 (/ widblc1 2.0)) (+ yblc1 (/ heiblc1 2.0)) cl1 ta)

  (fprintf capa "~n<rect x=\"~s\" y=\"~s\" fill=~s stroke=\"#000000\" stroke-miterlimit=\"10\" width=\"~s\" height=\"~s\" rx=\"5\" ry=\"5\" />" (+ xblc1 25) yblc2 cf2 (- widblc1 50) heiblc1)
  (fprintf capa "~n<text text-anchor=\"middle\" x=\"~s\" y=\"~s\" fill=~s>~a</text>~n " (+ xblc1 (/ widblc1 2.0)) (+ yblc2 (/ heiblc1 2.0)) cl2  at)

  (fprintf capa "~n</svg>")
  (close-output-port capa))

;;;;;seters;;;;;

(define (adiciona-remissivo palavra)
  (define pal (string-replace palavra  "*" ""))
  (set! indice-remissivo (append indice-remissivo (list(list pal (number->string pagina))))))

(define (adiciona-topico topico sec) ;sec = 1 para seccao ou qualquer outra coisa para slide
  (define slide (string-append "∘   " topico))
  (set! lista-topicos (if (= 1 sec) (append lista-topicos (list topico)) (append lista-topicos (list slide)))))

(define (proxima-pagina) (set! pagina (+ pagina 1)))

(define (nova-seccao nome)
  (set! seccao-atual nome))

(define (define-ta titulo)
  (set! ta titulo))

(define (define-at autor)
  (set! at autor))

(define (define-sh altura)
  (set! sh altura))

(define (define-sw largura)
  (set! sw largura))

(define (define-cf1 cor)
  (set! cf1 cor))

(define (define-cf2 cor)
  (set! cf2 cor))

(define (define-cl1 cor)
  (set! cl1 cor))

(define (define-cl2 cor)
  (set! cl2 cor))

(define (posic-bloco posicao)
  (set! altura-bloco posicao))

(define (limpa)
  (set! ta "apresentação de slides")
  (set! at "MODO EXPRESSO")
  (set! sh 300)
  (set! sw 500)
  (set! cf1 "purple")
  (set! cl1 "black")
  (set! cf2 "black")
  (set! cl2 "white")
  (set! lista-topicos (list))
  (set! indice-remissivo (list))
  (set! pagina 2)
  (set! altura-bloco 0))
