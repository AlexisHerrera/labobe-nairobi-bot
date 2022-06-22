class ParserDeMensajes
  def registro_usuario_exitoso(nombre)
    "Bienvenido #{nombre}!, te registraste exitosamente."
  end

  def registro_usuario_no_exitoso_datos_invalidos
    'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850'
  end

  def registro_usuario_no_exitoso_ya_registrado
    'Ya estás registrado'
  end

  def mostrar_menus(menus)
    mensaje = []
    menus.each { |menu| mensaje.push("#{menu.id}-#{menu.descripcion} ($#{menu.precio})") }
    mensaje.join(', ')
  end

  def pedido_exitoso(id_pedido)
    "Su pedido ha sido registrado: N° #{id_pedido}."
  end

  def pedido_invalido
    'No se pudo realizar el pedido. Asegurarse de estar registrado o solicitar un menu valido.'
  end

  def consulta_estado_exitosa(id_pedido, estado)
    "Pedido #{id_pedido}: #{estado}"
  end

  def consulta_estado_no_exitosa_pedido_inexistente
    'No se pudo consultar el pedido. Asegurese de que el pedido exista.'
  end

  def consulta_estado_no_exitosa_usuario_no_coincide
    'El usuario no coincide con el dueño del pedido.'
  end
end
