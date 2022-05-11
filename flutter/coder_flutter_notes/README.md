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

## Escrevendo bons códigos
- fácil leitura e entendimento
- desempenho
- entender e manter a longo prazo
- outros devem manter e entender a longo prazo
- entender o que do desempenho está na sua mão
- custo beneficio do desempenho
- explore novas práticas

## ciclo de vida dos widgets
- sempre que chama um componente chama um construtor
- stateless > construtor > build()
- stateful > construtor > initState() > build() > setState() > didUpdateWidget() > build() > dispose()

## ciclo de vida da aplicação
- inativo: nenhuma entrada do usuário é recebida
- paused: app não visível, executando em background
- resumed: app novamente visível, respondendo ao usuário
- suspending: app será fechado

## context
- único para cada elemento
- meta informação, localização na árvore de componentes
- theme, media query, navigator
- inheritedWidget: comunicação mais distantes dentro da árvore de componentes, informações do media query em qualquer lugar da aplicação
