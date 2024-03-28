# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  published  :boolean          default(FALSE), not null
#  slug       :string           not null
#  summary    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_pages_on_created_at  (created_at)
#  index_pages_on_published   (published)
#  index_pages_on_slug        (slug) UNIQUE
#  index_pages_on_title       (title) UNIQUE
#  index_pages_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Page < ApplicationRecord
  attr_accessor :tags_string

  belongs_to :user

  has_many :page_tags, dependent: :destroy
  has_many :tags, through: :page_tags


  validates :title,
    presence: true,
    uniqueness: true

  validates :content,
    presence: true

  before_validation :make_slug

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(created_at: :desc) }

  scope :by_term, ->(term) do
    term.gsub!(/[^-\w ]/, "")
    terms = term.include?(" ") ? term.split : [ term ]

    pages = Page
    terms.each do |t|
      pages = pages.where("content ILIKE ?", "%#{t}%")
    end

    pages
  end

  scope :by_year_month, ->(year, month) do
    sql = <<~SQL
    extract(year from created_at) = ?
    AND
    extract(month from created_at) = ?
    SQL
    where(sql, year, month)
  end

  def self.month_year_list
    sql = <<~SQL
      SELECT DISTINCT
        TRIM(TO_CHAR(created_at, 'Month')) AS month_name,
        TO_CHAR(created_at, 'MM') AS month_number,
        TO_CHAR(created_at, 'YYYY') AS year
      FROM pages
      WHERE published = true
      ORDER BY year DESC, month_number DESC
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  after_save :update_tags

  private

  def make_slug
    return unless title

    self.slug = NameCleanup.clean(title)
  end

  def update_tags
    self.tags = []
    return if tags_string.blank?

    tags_string.split(",").each do |name|
      name = NameCleanup.clean(name)

      tags << Tag.find_or_create_by(name:)
    end
  end
end
