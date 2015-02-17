require 'open-uri'
module Alipay
  module Service
    module QrCode
      GATEWAY_URL = 'https://mapi.alipay.com/gateway.do'
      MANAGE_REQUIRED_OPTIONS = %w( service partner _input_charset timestamp method )
      BIZ_DATA_REQUIRED_OPTIONS = %w( trade_type need_address goods_info )
      GOODS_INFO_REQUIRED_OPTIONS = %w( id )
      def self.manage_url(options)
        options = Utils.stringify_keys(options)
        
        if options['biz_data']
          biz_data_options = Utils.stringify_keys(options.delete('biz_data'))
          Alipay::Service.check_required_options(biz_data_options, BIZ_DATA_REQUIRED_OPTIONS)
          
          goods_info_options = Utils.stringify_keys(biz_data_options.delete('goods_info'))
          Alipay::Service.check_required_options(goods_info_options, GOODS_INFO_REQUIRED_OPTIONS)
          biz_data_options['goods_info'] = goods_info_options
        end
        
        options = {
          'service' => 'alipay.mobile.qrcode.manage',
          'partner' => Alipay.pid,
          '_input_charset' => 'utf-8',
          'timestamp' => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          'biz_data' => biz_data_options
        }.merge(options)

        # TODO BIZ_DATA


        Alipay::Service.check_required_options(options, MANAGE_REQUIRED_OPTIONS)
        "#{GATEWAY_URL}?#{query_string(options)}"
      end

      def self.query_string(options)
        sign = Alipay::Sign.generate(options)
        options.merge!('sign_type' => 'MD5')
        options.merge('sign' => sign).map do |key, value|
          "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
        end.join('&')
      end
    end
  end
end
