#language: es

Característica: Pedido de menú
  Como usuario
  Quiero realizar un pedido
  Para que el pedido llegue a mi domicilio

Escenario: US5.1 - Hacer un pedido en el menu
  Dado que soy un cliente registrado
  Cuando ejecuto el comando de pedir el menu 1
  Entonces debería recibir un mensaje con el código de pedido

Escenario: US5.2 - Hacer un pedido que no esta en el menu
  Dado que soy un cliente registrado
  Cuando ejecuto el comando de pedir el menu 4
  Entonces debería recibir un mensaje de error

