require 'spec_helper'
require 'web_mock'

require_relative 'bot_spec_steps/registrar_repartidor_steps'

describe 'Registrar Repartidor' do
  token = 'fake_token'

  it 'cuando me registro como repartidor deberia responder con Bienvenido nombre!, te registraste como repartidor exitosamente.' do
    dado_que_me_quiero_registrar_como_repartidor
    cuando_envio(token, '/registrarRepartidor Juan, 45571468, 1147239653')
    entonces_estoy_registrado_como_repartidor
    y_recibo_mensaje(token, 'Bienvenido Juan!, te registraste exitosamente como repartidor.')

    start_bot(token)
  end
end
