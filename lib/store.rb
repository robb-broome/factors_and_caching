class Store

  require 'yaml'

  def attrs
    return @attrs if @attrs
    File.open(store_name,'a+') do |store|
      @attrs = YAML.load_file(store) || {}
    end
  end

  def write key, val
    attrs[key] = val
    persist!
    val
  end

  def read key
    attrs[key]
  end

  def clear
    @attrs = {}
    File.delete(store_name) if File.exist?(store_name)
  end

  def store_name
    'factor_store.yml'
  end

  private

  def persist!
    File.open(store_name, 'w') do |file|
      file.write attrs.to_yaml
    end
  end

end

