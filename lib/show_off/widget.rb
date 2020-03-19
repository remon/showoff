module ShowOff
  class Widget
    attr_accessor :token

    def initialize(token = nil)
      @token = token
      @auth = "Bearer #{@token}"
    end

    def set_token(token)
      @token = token
      @auth = "Bearer #{@token}"
    end

    def show(id)
      begin
        params = {
          client_id: $client_id,
          client_secret: $client_secret,
        }
        res = RestClient.get(ShowOff::Constants::WIDGETS_URL + "/#{id}", { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def list_visible(q = "")
      params = {
        client_id: $client_id,
        client_secret: $client_secret,
        term: q,
      }
      begin
        res = RestClient.get(ShowOff::Constants::WIDGETS_URL_VISIBLE, { params: params, :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    ###
    # list all logged in user widgets (access tokens are required)
    # should returns all widgets  or session is expired if access are wrong or expired
    ###
    def logged_in_user_widgets(q = "")
      begin
        params = {
          client_id: $client_id,
          client_secret: $client_secret,
          term: q,
        }
        res = RestClient.get(ShowOff::Constants::USER_WIDGETS_URL, { params: params, :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def make_widget(widget_params)
      begin
        res = RestClient.post(ShowOff::Constants::WIDGETS_URL, widget_params, { :Authorization => @auth })
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
        res = RestClient.put(ShowOff::Constants::WIDGETS_URL + "/#{id}", widget_params, { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def delete(id)
      begin
        res = RestClient.delete(ShowOff::Constants::WIDGETS_URL + "/#{id}", { :Authorization => @auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end
  end
end
