As cartas do jogo da memória serão predefinidas. No total serão 16 cartas (uma matriz de 4 × 4).
A seguir, segue um pseudo-algoritmo do funcionamento do jogo.

```
cartas_do_jogo = predefinidas
cartas_viradas = bit(16,0) 
pos_cartas_escolhidas = (0,0) // [0] primeira carta, [1] segunda carta

// Método será sensível à mudança de virar_carta e pos_cartas_escolhidas
espera(virar_carta, pos_cartas_escolhidas):
  if pos_cartas[0] != 0 && pos_cartas_escolhidas[1] != 0:               (Estado ESPERA)
    compara_cartas_escolhidas()                                         (Estado COMPARACAO)
  else if virar_carta:                                                  (Estado ESPERA)
    carta_virada()                                                      (Estado CARTA_VIRADA)

compara_cartas_escolhidas():
  if jogo[pos_cartas[0]] == cartas_do_jogo[pos_cartas_escolhidas[1]]:   (Estado COMPARACAO)
    virar_cartas_escolhidas()                                           (Estado VIRAR_CARTAS)

carta_virada():
  for i in range(0, 16):                                                (Estado CARTA_VIRADA)
    if virar_carta[i] == 1 && cartas_viradas[i] == 0:                   (Estado CARTA_VIRADA)
      virou_primeira_carta = pos_cartas[0] != 0                         (Estado CARTA_VIRADA)
      pos_cartas[virou_primeira_carta] = i + 1                          (Estado CARTA_VIRADA)

virar_cartas_escolhidas():
  cartas_viradas[pos_cartas_escolhidas[0]] = 1                          (Estado VIRAR_CARTAS)
  cartas_viradas[pos_cartas_escolhidas[1]] = 1                          (Estado VIRAR_CARTAS)
  pos_cartas_escolhidas = (0,0)                                         (Estado VIRAR_CARTAS)
  verifica_fim()                                                        (Estado VERIFICA_FIM)

verifica_fim():
  fim = 1                                                               (Estado VERIFICA_FIM)
  for i in range(0,16):                                                 (Estado VERIFICA_FIM)
    if (cartas_viradas[i] == 0):                                        (Estado VERIFICA_FIM)
      fim = 0                                                           (Estado VERIFICA_FIM)

  if fim:                                                               (Estado VERIFICA_FIM)
    fim_jogo() // Os componentes do circuito serão desabilitados        (Estado FIM)
```
