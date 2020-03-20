module ShowOff
  class Http
    def self.get(url, auth, params = nil)
      begin
        res = params.nil? ? RestClient.get(url, { Authorization: auth }) : RestClient.get(url, { params: params, Authorization: auth })

        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def self.post(url, auth, params)
      begin
        res = RestClient.post(url, params, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def self.put(url, auth, params)
      begin
        res = RestClient.put(url, params, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end

    def self.delete(url, auth, params = nil)
      begin
        res = RestClient.delete(url, { :Authorization => auth })
        body = JSON.parse(res.body)
      rescue RestClient::ExceptionWithResponse => err
        JSON.parse(err.response.body)
      end
    end
  end
end
