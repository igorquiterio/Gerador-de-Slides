
# Gerador-de-Slides (2016)
Gerador de slides a partir de um documento de texto utilizando linguagem funcional para a disciplina de paradigmas de linguagens de programação

## Gramatica
Apresentacao ::= Cabecalho Corpo

Cabecalho ::= Identificacao Aparencia

Identificacao ::= Titulo Autor

Titulo ::= **ta string string**

Autor ::= **at lstring**

Aparencia ::= Dimensoes Cores

Dimensoes ::= Largura Altura

Largura ::= **sh** Medida

Altura ::= **sw** Medida

Medida ::= **numero**

Cores ::= Cores1 Cores2

Cores1 ::= Cl1 Cf1

Cl1 ::= **cl1** CorLetra1

Cf1 ::= **cf1** CorFundo1

Cores2 ::= Cl2 Cf2

Cl2 ::= **cl2** CorLetra2

Cf2 ::= **cf2** CorFundo2

Corpo ::= Secoes .

Secoes ::= Secao Secoes | Secao

Secao ::= TituloSec Slides | TituloSec

TituloSec ::= sec lstring

Slides ::= Slide Slides | Slide

Slide ::= sld TituloSlide CorpoSlide dls

TituloSlide ::= lstring

CorpoSlide ::= Blocos

Blocos ::= Bloco Blocos | Bloco

Bloco ::= **blc** CabecalhoBloco Itens clb

CabecalhoBloco ::= Marca TituloBloco CoresBlc

Marca ::=  **c** | **C** | **q** | **Q**

TituloBloco ::= **lstring**

CoresBlc ::= CorFundo1 CorLetra1 CorFundo2 CorLetra2
    |
**CorFundo1** ::= cor
**CorLetra1** ::= cor
**CorFundo2** ::= cor
**CorLetra2** ::= cor

Itens ::= Item Itens | Item

Item ::= **i** Palavras

Palavras ::= Palavra Palavras | Palavra

Palavra ::= PalavraSimples | PalavraIRemissivo

PalavraSimples ::= **string**

PalavraIRemissivo ::= **astring**

Obs.:
1) Não terminais iniciam com letra maiúscula
2) Terminais estão e minúsculas e em negrito
3) lstring é uma sequência de caracteres que pode conter brancos
e termina no final da linha
4) string é uma cadeia de caracteres que não contém brancos.
5) astring é semelhante a uma string, porém o seu último
caractere é um asterisco.

## video de apresentação
https://www.youtube.com/watch?v=37S1fj0IZmI&feature=youtu.be

### Linguagem
RACKET 6.8
