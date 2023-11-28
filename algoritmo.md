As cartas do jogo da memória serão predefinidas. No total serão 16 cartas (uma matriz de 4 × 4).
A seguir, segue um pseudo-algoritmo do funcionamento do jogo.

```
jogo = predefinidas
viradas = bit(16,0) 
escolhidas = (0,0) // [0] primeira carta, [1] segunda carta

// Método será sensível à mudança de virar_carta e pos_cartas_escolhidas
espera(virar_carta, escolhidas):
  if escolhidas[0] != 0 && escolhidas[1] != 0:    (Estado ESPERA)
    comparacao()                               (Estado COMPARACAO)
  else if virar_carta:                         (Estado ESPERA)
    carta_escolhida()                          (Estado CARTA_ESCOLHIDA)

comparacao():
  if jogo[escolhidas[0]] == jogo[escolhidas[1]]:   (Estado COMPARACAO)
    virar_escolhidas()                         (Estado VIRAR_ESCOLHIDAS)

carta_escolhida():
  for i in range(0, 16):                       (Estado CARTA_ESCOLHIDA)
    if virar_carta[i] == 1 && viradas[i] == 0: (Estado CARTA_ESCOLHIDA)
      virou_primeira = escolhidas[0] != 0      (Estado CARTA_ESCOLHIDA)
      escolhidas[virou_primeira] = i + 1       (Estado CARTA_ESCOLHIDA)

virar_escolhidas():
  viradas[escolhidas[0]] = 1                   (Estado VIRAR_ESCOLHIDAS)
  viradas[escolhidas[1]] = 1                   (Estado VIRAR_ESCOLHIDAS)
  escolhidas = (0,0)                           (Estado VIRAR_ESCOLHIDAS)
  verifica_fim()                               (Estado VERIFICA_FIM)

verifica_fim():
  fim = 1                                      (Estado VERIFICA_FIM)
  for i in range(0,16):                        (Estado VERIFICA_FIM)
    if (viradas[i] == 0):                      (Estado VERIFICA_FIM)
      fim = 0                                  (Estado VERIFICA_FIM)

  // Os componentes do circuito serão desabilitados
  if fim:                                      (Estado VERIFICA_FIM)
    fim_jogo()                                 (Estado FIM)
```
