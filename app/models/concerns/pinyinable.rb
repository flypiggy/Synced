module Pinyinable
  extend ActiveSupport::Concern

  included do
    before_validation do
      if name.present? && (name_changed? || pinyin.blank? || pinyin_abbr.blank?)
        self.pinyin = PinYin.of_string(name).join.downcase
        self.pinyin_abbr = PinYin.abbr(name)
      end
    end
  end
end
