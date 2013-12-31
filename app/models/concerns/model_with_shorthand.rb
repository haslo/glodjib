module Concerns::ModelWithShorthand
  extend ActiveSupport::Concern

  included do
    validates :shorthand, :uniqueness =>  true, :presence => true
    validate :shorthand_first_character

    scope :with_id_or_shorthand, lambda { |id_or_shorthand|
      if id_or_shorthand.to_s.is_i?
        self.where(:id => id_or_shorthand)
      else
        self.where(:shorthand => id_or_shorthand)
      end
    }

    def self.get_with_id_or_shorthand(id_or_shorthand)
      with_id_or_shorthand(id_or_shorthand).first
    end

    def shorthand=(value)
      if value.blank?
        write_attribute(:custom_shorthand, false)
        write_attribute(:shorthand, auto_shorthand(read_attribute(:title)))
      else
        write_attribute(:custom_shorthand, true)
        write_attribute(:shorthand, auto_shorthand(value))
      end
    end

    def auto_shorthand(original_value)
      added_index = 0
      current_shorthand = generated_shorthand = original_value.blank? ? nil : original_value.strip.downcase.gsub(' ', '_').gsub(/[^0-9a-z_]/i, '')
      while self.class.where(:shorthand => current_shorthand).any?{|post| post.id != id}
        current_shorthand = "#{generated_shorthand}_#{added_index}"
        added_index += 1
      end
      current_shorthand
    end
    private :auto_shorthand

    def shorthand_first_character
      if read_attribute(:shorthand).blank? || !(read_attribute(:shorthand)[0] =~ /[a-z]/i)
        errors.add(:shorthand, I18n.t('errors.custom_messages.shorthand_start_with_character'))
      end
    end
    private :shorthand_first_character
  end

end