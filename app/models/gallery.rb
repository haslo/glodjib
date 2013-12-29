class Gallery < ActiveRecord::Base
  include Concerns::ModelWithShorthand

  has_and_belongs_to_many :images

end
