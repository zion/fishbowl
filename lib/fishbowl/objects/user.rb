module Fishbowl::Objects
  class User < BaseObject
    attr_accessor :db_id, :user_name, :first_name, :last_name, :initials, :active

    def self.attributes
      %w{ID UserName FirstName LastName Initials Active}
    end

    def initialize(user_xml)
      @xml = user_xml
      parse_attributes
      self
    end
  end
end
