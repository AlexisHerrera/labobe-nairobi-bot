require 'spec_helper'

def start_bot(token)
  app = BotClient.new(token)
  app.run_once
end

describe 'Registro' do
  token = 'fake_token'

  it 'El bot responde a que equipo pertenece' do
    when_i_send_text(token, '/equipo')
    then_i_get_text(token, 'Hola Nairobi')

    start_bot(token)
  end

  it 'cuando me /registro deberia responder con Bienvenido nombre!, te registraste exitosamente.' do
    dado_que_me_quiero_registrar
    cuando_envio(token, '/registrar Juan, 1144449999, paseo colon 850')
    entonces_estoy_registrado
    y_recibo_mensaje(token, 'Bienvenido Juan!, te registraste exitosamente.')

    start_bot(token)
  end
end
