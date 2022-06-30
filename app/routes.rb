require "#{File.dirname(__FILE__)}/../lib/routing"
require "#{File.dirname(__FILE__)}/../lib/version"
require_relative 'api_bobe.rb'
require_relative 'parser_mensajes.rb'
require 'byebug'
require_relative 'errors/usuario_invalido.rb'
require_relative 'errors/usuario_ya_registrado.rb'
require_relative 'errors/pedido_invalido.rb'
require_relative 'errors/usuario_no_coincide.rb'
require_relative 'errors/estado_pedido_invalido.rb'

class Routes
  include Routing
  api_bobe = APIBobe.new
  # TODO: Ubicar el logger dentro del bot
  bot_logger = SemanticLogger['BotClient']
  parser = ParserDeMensajes.new

  on_message '/start' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Hola, #{message.from.first_name}")
  end

  on_message '/version' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Version.current)
  end

  on_message '/equipo' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Hola Nairobi')
  end

  on_message_pattern %r{/registrar (?<nombre>.*), (?<telefono>.*), (?<direccion>.*)} do |bot, message, args|
    usuario = api_bobe.registro_usuario(args['nombre'], args['telefono'], args['direccion'], message.from.id.to_s)
    bot.api.send_message(chat_id: message.chat.id, text: parser.registro_usuario_exitoso(usuario.nombre))
    bot_logger.info "Registro de usuario exitoso: #{args} "
  rescue UsuarioInvalido
    bot_logger.info "Error al registrar usuario: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.registro_usuario_no_exitoso_datos_invalidos)
  rescue UsuarioYaRegistrado
    bot_logger.info "El usuario ya estaba registrado: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.registro_usuario_no_exitoso_ya_registrado)
  end

  on_message_pattern %r{/registrar (?<nombre>.*), (?<direccion>.*)} do |bot, message, args|
    bot_logger.info "Error de parametros en registrar: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.registro_usuario_no_exitoso_datos_invalidos)
  end

  on_message '/menus' do |bot, message|
    menus = api_bobe.pedir_menus
    bot.api.send_message(chat_id: message.chat.id, text: parser.mostrar_menus(menus))
  end

  on_message_pattern %r{/pedir (?<menu>.*)} do |bot, message, args|
    pedido = api_bobe.hacer_pedido(message.from.id.to_i, args['menu'].to_i)
    bot.api.send_message(chat_id: message.chat.id, text: parser.pedido_exitoso(pedido.id_pedido))
  rescue PedidoInvalido
    bot_logger.info "Error al realizar pedido: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.pedido_invalido)
  end

  on_message_pattern %r{/pedido (?<numeroPedido>.*)} do |bot, message, args|
    pedido = api_bobe.consultar_pedido(message.from.id.to_i, args['numeroPedido'].to_i)
    bot.api.send_message(chat_id: message.chat.id, text: parser.consulta_estado_exitosa(pedido.id_pedido, pedido.estado))
  rescue PedidoInvalido
    bot_logger.info "Pedido invalido: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.consulta_estado_no_exitosa_pedido_inexistente)
  rescue UsuarioNoCoincide
    bot_logger.info "Usuario: #{message.from.id.to_i} consulto estado de pedido #{args} y no es el dueño"
    bot.api.send_message(chat_id: message.chat.id, text: parser.consulta_estado_no_exitosa_usuario_no_coincide)
  end

  on_message_pattern %r{/calificar (?<numeroPedido>.*), (?<calificacion>.*)} do |bot, message, args|
    api_bobe.calificar_pedido(args['numeroPedido'].to_i, message.from.id.to_i, args['calificacion'].to_i)
    bot.api.send_message(chat_id: message.chat.id, text: parser.calificacion_pedido_exitosa)
  rescue PedidoInvalido
    bot_logger.info "Calificacion a Pedido invalido: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.consulta_estado_no_exitosa_pedido_inexistente)
  rescue CalificacionInvalida
    bot_logger.info "Calificacion invalida a pedido: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.calificacion_invalida)
  rescue EstadoPedidoInvalido
    bot_logger.info "Calificacion a Pedido no entregado: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: parser.calificacion_pedido_no_entregado)
  rescue UsuarioNoCoincide
    bot_logger.info "Usuario: #{message.from.id.to_i} quiso calificar pedido #{args} y no es el dueño"
    bot.api.send_message(chat_id: message.chat.id, text: parser.consulta_estado_no_exitosa_usuario_no_coincide)
  end

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Uh? No te entiendo! Me repetis la pregunta?')
  end
end
