module ShowOff
  class Widget
    def initialize(token)
      @token = token
    end

    def list
      auth = "Bearer #{@token}"
      begin
        res = RestClient.get($WIDGETS_URL, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def make_widget(widget_params)
      auth = "Bearer #{@token}"
      begin
        res = RestClient.post($WIDGETS_URL, widget_params, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end
  end
end
