require 'savon'

module Sogou
  module Search
    module Api
      class PromotionGroup
        attr_accessor :authorization

        def initialize()
          @url = 'http://api.agent.sogou.com:8080/sem/sms/v1/CpcGrpService?wsdl'
        end

        def get_cpc_grp_by_cpc_plan_id(plan_ids)
          resp = client.call(:get_cpc_grp_by_cpc_plan_id,
                             message: { cpc_plan_ids: plan_ids })
          puts resp.header
          resp.body
        end

        def get_cpc_grp_id_by_cpc_plan_id(plan_ids)
          resp = client.call(:get_cpc_grp_id_by_cpc_plan_id,
                             message: { cpc_plan_ids: plan_ids })
          puts resp.header
          resp.body
        end

        def client
          @client ||= begin
            soap_header = {}
            authorization.apply(soap_header)

            Savon.client(
              pretty_print_xml: true,
              wsdl: @url,
              namespaces: { "xmlns:v1" => "http://api.sogou.com/sem/common/v1" },
              env_namespace: :soapenv,
              namespace_identifier: :v11,
              soap_header: soap_header
            )
          end
        end
      end
    end
  end
end
