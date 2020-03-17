module ShowOff
  class Widget
    def initialize(token)
      @token = token
      @auth = "Bearer #{@token}"
    end

    def list
      begin
        res = RestClient.get($WIDGETS_URL, { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def make_widget(widget_params)
      begin
        res = RestClient.post($WIDGETS_URL, widget_params, { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def update(id, params)
      widget_params = {
        widget: params,
      }
      begin
        res = RestClient.put($WIDGETS_URL + "/#{id}", widget_params, { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def delete(id)
      begin
        res = RestClient.delete($WIDGETS_URL + "/#{id}", { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end
  end
end
