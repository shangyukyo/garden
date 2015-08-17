module LocaleTransform
  extend ActiveSupport::Concern

  def status_i18n
    return nil if not self.respond_to?(:status)
    ::I18n.t("#{self.class.to_s.downcase}.statuses.#{self.status}")
  end

end 