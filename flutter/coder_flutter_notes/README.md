# Anotações do curso da coder de flutter

## Árvores de widgets
widget tree
- configuração
- disparada pelo método build
- renderizada com frequência
- imutável
- setState, vai refazer o build
- alterações no media query refazem o build

element tree
- ligação do componente com o que vai ser renderizado na tela
- renderizada com menos frequência
- estrutura lógica

render tree
- objeto renderizado na tela
- renderizada com menos frequência
- o que você vê na tela


## Quando a tela é atualizada?
- Quando há mudanças no estado, uma novo árvore de widgets é gerada
- árvore de elementos só é alterada, quando os tipos mudam

## Quando o método build é chamado?
- revisão dos métodos abordados dentro da aplicação de despesas


## Construtores e widgets constantes
- final, constante em runtime
- const, valor atribuido deve ser conhecido no momento da compilação
- construtor const, todos os atributos devem ser final
- construtor constante gera um componente constante
