module ClientsHelper

  def client_lifetime_value(client)
    Client.lifetime_value(client)
  end

  def avg_client_lifetime_value
    Client.avg_lifetime_value
  end
end
