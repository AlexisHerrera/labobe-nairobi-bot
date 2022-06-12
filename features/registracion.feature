# language: es

Característica: Registracion de usuario
  Escenario: 01 - Registro exitoso
    Dado que me quiero registrar
    Cuando envio '/registrar Juan, 1144449999, paseo colon 850'
    Entonces el usuario esta registrado
    Y recibo el mensaje "Bienvenido a la Bobe Juan!"

  Escenario: 02 - Registro sin exito, numero corto
    Dado que me quiero registrar
    Cuando ingreso con numero '123'
    Entonces el usuario no se registra
    Y recibo el mensaje "Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850"

  Escenario: 03 - Registro sin exito, numero largo
    Dado que me quiero registrar
    Cuando ingreso con numero '12345678910111213'
    Entonces el usuario no se registra
    Y recibo el mensaje "Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850"

  Escenario: 04 - Registro sin exito, el número ingresado no es un valor númerico
    Dado que me quiero registrar
    Cuando ingreso con numero 'Juan'
    Entonces el usuario no se registra
    Y recibo el mensaje "Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850"

  Escenario: 05 - Registro sin exito, el número ingresado es vacío
    Dado que me quiero registrar
    Cuando ingreso con numero ''
    Entonces el usuario no se registra
    Y recibo el mensaje "Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850"

  Escenario: 06 - Registro sin exito, el nombre ingresado tiene números o caracteres especiales
    Dado que me quiero registrar
    Cuando ingreso con nombre '1J23'
    Entonces el usuario no se registra
    Y recibo el mensaje "Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850"

  Escenario: 07 - Registro sin exito, no se ingresa toda la información necesaria para el registro
    Dado que me quiero registrar
    Cuando envió '/registrar Juan, paseo colon 850'
    Entonces el usuario no se registra
    Y recibo el mensaje "Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850"

  Escenario: 08 - Registro sin exito, el numero ya está en uso
    Dado que me quiero registrar
    Cuando ingreso con numero de un usuario registrado
    Entonces el usuario no se registra
    Y recibo el mensaje "Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850"
