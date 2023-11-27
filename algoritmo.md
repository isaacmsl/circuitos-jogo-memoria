As cartas do jogo da memória serão predefinidas. No total serão 16 cartas (uma matriz de 4 × 4).
A seguir, segue um pseudo-algoritmo do funcionamento do jogo.

```
cartas_do_jogo = predefinidas
cartas_viradas = bit(16,0) 
pos_cartas_escolhidas = (0,0) // [0] primeira carta, [1] segunda carta

// Método será sensível à mudança de virar_carta e pos_cartas_escolhidas
espera(virar_carta, pos_cartas_escolhidas):
  if pos_cartas[0] != 0 && pos_cartas_escolhidas[1] != 0:
    compara_cartas_escolhidas()
  else if virar_carta:
    carta_virada()

compara_cartas_escolhidas():
  if jogo[pos_cartas[0]] == cartas_do_jogo[pos_cartas_escolhidas[1]]:
    virar_cartas_escolhidas()

carta_virada():
  for i in range(0, 16):
    if virar_carta[i] == 1 && cartas_viradas[i] == 0:
      virou_primeira_carta = pos_cartas[0] != 0
      pos_cartas[virou_primeira_carta] = i + 1

virar_cartas_escolhidas():
  cartas_viradas[pos_cartas_escolhidas[0]] = 1
  cartas_viradas[pos_cartas_escolhidas[1]] = 1
  verifica_fim()
  pos_cartas_escolhidas = (0,0)

verifica_fim():
  fim = 1
  for i in range(0,16):
    if (cartas_viradas[i] == 0):
      fim = 0

  if fim:
    fim_jogo() // Os componentes do circuito serão desabilitados




```
