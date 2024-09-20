Para separar cada palavra em uma nova linha no Vim, você pode usar o
seguinte comando de substituição:

vim

:%s/\s\+/\r/g

Aqui está o que o comando faz:

    :%s/ : Inicia um comando de substituição para todas as linhas do
           arquivo (% indica todas as linhas).

    \s\+ : Correspondência de um ou mais espaços em branco (que pode
           ser espaço, tabulação, etc.).

    \r : Insere uma nova linha.

    /g : Aplica a substituição globalmente em todas as ocorrências da
         linha.

Esse comando irá transformar uma linha com palavras separadas por
espaços em várias linhas, cada uma contendo uma palavra.
