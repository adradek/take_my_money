module HasReference
  extend ActiveSupport::Concern

  class_methods do
    def generate_reference
      loop do
        result = SecureRandom.hex(10)
        return result unless exists?(reference: result)
      end
    end
  end
end
