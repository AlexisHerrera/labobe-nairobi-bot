Escenario: US6.1 - Consultar el estado de un pedido con un código válido
    Dado que realicé un pedido con código 1
    Cuando ingreso el comando de consulta de estado de ese pedido
    Entonces recibo el mensaje con el estado del pedido

Escenario: US6.2 - Consultar el estado de un pedido con un código inválido
    Dado que realicé un pedido con código 1
    Cuando ingreso el comando de consulta de estado de un pedido inexistente
    Entonces recibo un mensaje con un error de pedido inválido

Escenario: US6.3 - Consultar el estado de un pedido que no es mio
    Dado que no realicé un pedido con código 1
    Cuando ingreso el comando de consulta de estado de ese pedido
    Entonces recibo un mensaje con un error de pedido que no me pertenece
