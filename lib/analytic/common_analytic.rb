module CommonAnalytic

  def extract_from_list(list, property)
    list.map { |item| item.send(property) }
  end

  def self.included(o)
    o.extend(ClassMethods)
  end

  module ClassMethods
    def available_analytics
      instance_methods.map(&:to_s)
    end
  end

end