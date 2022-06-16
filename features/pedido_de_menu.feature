#language: es

Característica: Pedido de menú
  Como usuario
  Quiero realizar un pedido
  Para que el pedido llegue a mi domicilio

Escenario 01: Hacer un pedido en el menu
  Dado que soy un cliente que quiere hacer un pedido
  Cuando ejecuto el comando "/pedido 1"
  Entonces debería recibir el mensaje: "Su pedido ha sido registrado: N° 1234."
