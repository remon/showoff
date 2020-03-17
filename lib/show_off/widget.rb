module ShowOff
  class Widget
    def initialize(token = nil)
      @token = token
      @auth = "Bearer #{@token}"
    end

    def list_visible(q = "")
      params = {
        client_id: $client_id,
        client_secret: $client_secret,
        term: q,
      }
      begin
        res = RestClient.get($WIDGETS_URL_VISIBLE, { params: params, :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
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
