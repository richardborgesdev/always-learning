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
