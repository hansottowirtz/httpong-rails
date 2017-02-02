module Elpong
  module Rails
    module Helper
      def elpong_scheme(name_or_scheme = nil)
        scheme = get_scheme_from_name_or_scheme(name_or_scheme)
        content_tag(:meta, nil, name: 'elpong-scheme', content: scheme.to_json, scheme: scheme.name)
      end

      def elpong_collection(name, options = {})
        scheme = get_scheme_from_name_or_scheme(options[:scheme])
        # options[:locals] ||=
        throw new StandardError('No path') if !options[:path]
        attributes = {
          name: 'elpong-collection',
          content: h( render(template: options[:path], locals: options[:locals] || {}) ),
          scheme: scheme.name,
          collection: name
        }
        content_tag(:meta, nil, attributes)
      end

      def elpong_element(singular_name, options = {})
        scheme = get_scheme_from_name_or_scheme(options[:scheme])
        throw new StandardError('No path') if !options[:path]
        attributes = {
          name: 'elpong-element',
          content: h( render(template: options[:path], locals: options[:locals] || {}) ),
          scheme: scheme.name,
          collection: singular_name.pluralize
        }
        options[:attributes].each do |name, value|
          attributes[name] = value
        end
        content_tag(:meta, nil, attributes)
      end

      private
      def get_scheme_from_name_or_scheme(name_or_scheme)
        if name_or_scheme.class == Elpong::Scheme
          name_or_scheme
        elsif name_or_scheme
          Elpong.get_scheme(name_or_scheme)
        else
          Elpong.default_scheme
        end
      end
    end
  end
end