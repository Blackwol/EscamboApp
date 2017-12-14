class Ad < ActiveRecord::Base
  
  QTT_PAGE = 6

  #RatyRate
  ratyrate_rateable 'quality'

  # Associações
  belongs_to :member
  belongs_to :category, counter_cache: true
  has_many :comments

  # Validates
  #validates :title, :picture, :description, :category, :finish_date , presence: true
  #validates :price, numericality: {greater_than: 0}
  validates_presence_of :title, :picture, :description, :category, :finish_date, :price

  #scopes
  scope :descending_order, ->(page) {order(created_at: :desc).page(page).per(QTT_PAGE)}
  scope :to_the, ->(member) {where(member: member)}
  scope :by_category, ->(id, page) {where(category: id).page(page).per(QTT_PAGE)}
  scope :search, ->(q, page) {where("title LIKE ?", "%#{q}%").page(page).per(QTT_PAGE)}
  scope :random, ->(quantity) {
    Rails.env.production?
      limit(quantity).order("RAND()") # MySQL
    else
      limit(quantity).order("RANDOM()") #SQLite
    end} 

  # Paperclip
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # gem money-rails
  monetize :price_cents

  def second
    self[1]
  end

  def third
    self[2]
  end

  private
end
