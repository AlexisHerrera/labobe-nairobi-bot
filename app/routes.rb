require "#{File.dirname(__FILE__)}/../lib/routing"
require "#{File.dirname(__FILE__)}/../lib/version"
require "#{File.dirname(__FILE__)}/tv/series"
require_relative 'api_bobe.rb'
require 'byebug'
require_relative 'errors/usuario_invalido.rb'
require_relative 'errors/usuario_ya_registrado.rb'
require_relative 'errors/pedido_invalido.rb'

class Routes
  include Routing
  api_bobe = APIBobe.new
  # TODO: Ubicar el logger dentro del bot
  bot_logger = SemanticLogger['BotClient']

  on_message '/start' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Hola, #{message.from.first_name}")
  end

  on_message_pattern %r{/say_hi (?<name>.*)} do |bot, message, args|
    bot.api.send_message(chat_id: message.chat.id, text: "Hola, #{args['name']}")
  end

  on_message '/stop' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "Chau, #{message.from.username}")
  end

  on_message '/time' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: "La hora es, #{Time.now}")
  end

  on_message '/tv' do |bot, message|
    kb = Tv::Series.all.map do |tv_serie|
      Telegram::Bot::Types::InlineKeyboardButton.new(text: tv_serie.name, callback_data: tv_serie.id.to_s)
    end
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)

    bot.api.send_message(chat_id: message.chat.id, text: 'Quien se queda con el trono?', reply_markup: markup)
  end

  on_message '/busqueda_centro' do |bot, message|
    kb = [
      Telegram::Bot::Types::KeyboardButton.new(text: 'Compartime tu ubicacion', request_location: true)
    ]
    markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
    bot.api.send_message(chat_id: message.chat.id, text: 'Busqueda por ubicacion', reply_markup: markup)
  end

  on_location_response do |bot, message|
    response = "Ubicacion es Lat:#{message.location.latitude} - Long:#{message.location.longitude}"
    puts response
    bot.api.send_message(chat_id: message.chat.id, text: response)
  end

  on_response_to 'Quien se queda con el trono?' do |bot, message|
    response = Tv::Series.handle_response message.data
    bot.api.send_message(chat_id: message.message.chat.id, text: response)
  end

  on_message '/version' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: Version.current)
  end

  on_message '/equipo' do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Hola Nairobi')
  end

  on_message_pattern %r{/registrar (?<nombre>.*), (?<telefono>.*), (?<direccion>.*)} do |bot, message, args|
    usuario = api_bobe.registro_usuario(args['nombre'], args['telefono'], args['direccion'], message.from.id.to_s)
    bot.api.send_message(chat_id: message.chat.id, text: "Bienvenido #{usuario.nombre}!, te registraste exitosamente.")
    bot_logger.info "Registro de usuario exitoso: #{args} "
  rescue UsuarioInvalido
    bot_logger.info "Error al registrar usuario: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')
  rescue UsuarioYaRegistrado
    bot_logger.info "El usuario ya estaba registrado: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: 'Ya estás registrado')
  end

  on_message_pattern %r{/registrar (?<nombre>.*), (?<direccion>.*)} do |bot, message, args|
    bot_logger.info "Error de parametros en registrar: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: 'Datos invalidos, ingrese un telefono de 10 digitos, un nombre valido y una direccion. /registrar Francisco, 1144449999, paseo colon 850')
  end

  on_message '/menus' do |bot, message|
    menus = api_bobe.pedir_menus
    mensaje = []
    menus.each { |menu| mensaje.push("#{menu.id}-#{menu.descripcion} ($#{menu.precio})") }
    bot.api.send_message(chat_id: message.chat.id, text: mensaje.join(', '))
  end

  on_message_pattern %r{/pedir (?<menu>.*)} do |bot, message, args|
    pedido = api_bobe.hacer_pedido(message.from.id.to_i, args['menu'].to_i)
    bot.api.send_message(chat_id: message.chat.id, text: "Su pedido ha sido registrado: N° #{pedido.id}.")
  rescue PedidoInvalido
    bot_logger.info "Error al realizar pedido: #{args}"
    bot.api.send_message(chat_id: message.chat.id, text: 'No se pudo realizar el pedido. Asegurarse de estar registrado o solicitar un menu valido.')
  end

  default do |bot, message|
    bot.api.send_message(chat_id: message.chat.id, text: 'Uh? No te entiendo! Me repetis la pregunta?')
  end
end
