require 'net/http'
require 'json'
# Importing rails to grab credentials needed to make requests to Spreedly
require 'rails'

class Spreedly < Rails::Application
    BASE_URL = 'https://core.spreedly.com/v1/'
    ENV_KEY = Rails.application.credentials.spreedly[:environment_key]
    APP_SECRET = Rails.application.credentials.spreedly[:access_secret]

    # Create a Spreedly gateway
    def create_test_gateway
        body  = {
            "gateway" => {
                "gateway_type" => "test"
            }
        }

        resp = build_request('post', 'gateways.json', {'body' => body})

        puts resp.code
        puts resp.body
    end

    # Get list of created gateways
    def get_created_gateways
        resp = build_request('get', 'gateways.json')

        r_body = JSON.parse(resp.body)
        puts r_body
        gateway_token = r_body['gateways'][0]['token']
    end

    # Create a payment method
    def create_payment_method
        gateway_token = self.get_created_gateways
        body = {
            "transaction" => {
                "credit_card" => {
                    "first_name" => "Joe",
                    "last_name" => "Smith",
                    "number" => "4111111111111111",
                    "month" => "12",
                    "year" => "2020",
                },
                "amount" => 100,
                "currency_code" => "USD"
            }
        }

        resp = build_request('post', "gateways/#{gateway_token}/purchase.json", {'body' => body})

        puts resp.code
        puts resp.body

        body = JSON.parse(resp.body)
    end

    # Execute a purchase with an existing token
    # @todo: This is essentially the same call as the create payment method with a different body
    def create_purchase_transaction
        uri = URI(BASE_URL + "gateways/#{gateway_token}/purchase.json")
        request = Net::HTTP::Post.new(uri)
        request.basic_auth ENV_KEY, APP_SECRET

        body = {
            "transaction" => {
                "payment_method_token" => '',
                "amount" => 100,
                "currency_code" => "USD"
            }
        }
    end

    private
        # build_request method
        # @param string method - http method for the request
        # @param string endpoint - url endpoint for the api
        # @param [mixed] **args - body, header arguments to be passed with the request
        def build_request(method, endpoint, args={})
            uri = URI(BASE_URL + endpoint)
            if method == 'post'
                req = Net::HTTP::Post.new(uri)
            elsif method == 'get'
                req = Net::HTTP::Get.new(uri)
            else
                puts "Error"
            end

            req.basic_auth(ENV_KEY, APP_SECRET)

            if args.key?("body")
                req.body = args['body'].to_json
            end

            if args.key?("headers")
                puts args['headers']
            end

            req['Content-Type'] = 'application/json'
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
    
            resp = http.request(req)

            return resp
        end
end


s = Spreedly.new
s.create_payment_method
# s.get_created_gateways
# s.create_test_gateway
