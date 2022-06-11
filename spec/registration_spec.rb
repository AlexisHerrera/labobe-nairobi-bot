require 'spec_helper'

describe 'Registro' do
  # Dado que me quiero registrar
  # Cuando envio '/registrar Juan, 1144449999, paseo colon 850'
  # Entonces el usuario esta registrado
  # Y recibo el mensaje "Bienvenido a la Bobe Juan!"

  it 'El bot responde a que equipo pertenece' do
    token = 'fake_token'

    when_i_send_text(token, '/equipo')
    then_i_get_text(token, 'Hola Nairobi')

    app = BotClient.new(token)
    app.run_once
  end

  xit 'cuando me /registro deberia responder con Bienvenido nombre!, te registraste exitosamente.' do
    token = 'fake_token'
    when_i_send_text(token, '/registrar Juan, 1144449999, paseo colon 850') # envio mensaje
    cuando_me_registro(token, '/registrar Juan, 1144449999, paseo colon 850') # llamado a la api
    # then_i_get_text(token, 'Bienvenido Juan!, te registraste exitosamente.') # recibo mensaje
    app = BotClient.new(token)
    app.run_once
  end
end
