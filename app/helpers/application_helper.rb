module ApplicationHelper
  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    ActiveModelSerializers::SerializableResource.new(target, options).to_json
  end
end
