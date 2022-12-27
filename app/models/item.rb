class Item < ApplicationRecord
  belongs_to :tax_rate
  has_one_attached :image
  belongs_to :item_type

  delegate :rate, to: :tax_rate

  def image_url
    Rails.application.routes.url_helpers.rails_blob_path(image, disposition: "attachment", only_path: true)
  end
end
