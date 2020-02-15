class Bill < ApplicationRecord
  belongs_to :session

  validates :code, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :tabled_date, :presence => true
  validates :page_url, :presence => true
  validates :full_text_url, :presence => true

  validate :tabled_date_must_not_be_in_the_future

  def tabled_date_must_not_be_in_the_future
    if tabled_date.present? && tabled_date >= Date.today
      errors.add(:tabled_date, "must not be in the future")
    end
  end 

end