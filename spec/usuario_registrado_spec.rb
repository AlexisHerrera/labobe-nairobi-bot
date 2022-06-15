require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/usuario_registrado_steps'
require_relative 'bot_spec_steps/registration_steps'

describe 'Registro' do
  token = 'fake_token'
  it 'cuando el usuario ya esta registrado no puede volver a registrarse' do
    cuando_envio(token, '/registrar Juan, 1144449999, paseo colon 850')

    dado_que_me_quiero_registrar_ya_registrado('Francisco', '1166669999', 'Av Rivadavia 100')
    cuando_envio(token, '/registrar Francisco, 1166669999, Av Rivadavia 100')

    entonces_no_estoy_registrado
    y_recibo_mensaje(token, 'Ya estás registrado')

    start_bot(token)
    expect(a_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")).to have_been_made.at_least_once
  end
end
