class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :item_type
  has_one :tax_rate, through: :item_type

  delegate :rate, to: :tax_rate

  def image_url
    "https://coffee-shop1.herokuapp.com" + Rails.application.routes.url_helpers.rails_blob_path(image, disposition: "attachment", only_path: true)
  end
end
