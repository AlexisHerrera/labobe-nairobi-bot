#language: es

Característica: Registración de usuarios

  Escenario: 01 - Un usuario registrado no se puede registrar de nuevo
    Dado que soy un usuario registrado
    Cuando envió '/registrar Juan, 1144449999, paseo colon 850'
    Entonces el usuario no se registra
    Y recibo el mensaje 'Ya estás registrado'
