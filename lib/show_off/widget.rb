module ShowOff
  class Widget
    def list(token)
      auth = "Bearer #{token}"
      begin
        res = RestClient.get($WIDGETS_URL, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end
  end
end
