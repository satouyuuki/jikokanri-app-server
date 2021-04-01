# class ServiceLoader
#   class << self
#     def load
#       load_path = File.expand_path(__dir__)
#       Dir.glob("#{load_path}/**/*.rb").each(&method(:load_service))
#     end

#     private

#     def load_service(path)
#       return if path.index(__FILE__).present?
#       require_relative path
#     end
#   end
# end
# ServiceLoader.load