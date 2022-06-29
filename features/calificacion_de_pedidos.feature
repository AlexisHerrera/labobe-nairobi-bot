#language: es

Característica: Consulta de menú
  Como usuario
  Quiero calificar el pedido
  Para poder expresar mi satisfacion con el pedido

Escenario: US10.1 - Calificacion exitosa
  Dado que un pedido del cliente esta "Entregado"
  Cuando quiero calificar un pedido como excelente
  Entonces la calificacion queda registrada

Escenario: US10.2 - Calificacion de un pedido inexistente
  Cuando califico un pedido inexistente
  Entonces no se registra la calificacion

Escenario: US10.3 - Calificacion de un pedido con un valor que excede el rango
  Dado que un pedido del cliente esta "Entregado"
  Cuando quiero calificar un pedido con un valor que excede el rango
  Entonces no se registra la calificacion

Escenario: US10.4 - Calificacion de un pedido con un valor que es inferior al rango
  Dado que un pedido del cliente esta "Entregado"
  Cuando quiero calificar un pedido con un valor que es inferior al rango
  Entonces no se registra la calificacion

Escenario: US10.5 - Calificacion de un pedido con un valor no numerico
  Dado que un pedido del cliente esta "Entregado"
  Cuando quiero calificar un pedido con un valor no numerico
  Entonces no se registra la calificacion

Escenario: US10.6 - Calificacion de un pedido que no esta entregado
  Dado que un pedido del cliente esta "En preparacion"
  Cuando quiero calificar un pedido como excelente
  Entonces no se registra la calificacion

Escenario: US10.7 - Calificacion de un pedido que no es del cliente que lo pidio
  Dado que un pedido que no es del cliente esta "Entregado"
  Cuando quiero calificar un pedido que no es del cliente como excelente
  Entonces no se registra la calificacion
