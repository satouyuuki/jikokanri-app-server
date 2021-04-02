# frozen_string_literal: true

# services以下を強制的にロードさせる
# config.paths.addでは呼び出し時にLoadErrorが発生することがあったため、明示的に読み込ませるようにした

services_path = Rails.root.join('app', 'services')

Dir.glob("#{services_path}/**/*.rb").each do |path|
  next if path.index(__FILE__).present?
  require_relative path
end