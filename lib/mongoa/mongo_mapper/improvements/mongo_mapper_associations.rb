module MongoMapper
  module Plugins
    module Associations
      module ClassMethods
        def find_association(name)
          name_association = self.associations.detect {|key, value| key.to_s == name.to_s}
          name_association ? name_association.last : nil
        end
      end
    end
  end
end