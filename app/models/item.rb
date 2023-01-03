class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :item_type
  has_one :tax_rate, through: :item_type

  delegate :rate, to: :tax_rate

  def image_url
    "https://9c7a-2405-201-3008-c032-8b46-cea7-94dc-97e3.in.ngrok.io" + Rails.application.routes.url_helpers.rails_blob_path(image, disposition: "attachment", only_path: true)
  end
end
