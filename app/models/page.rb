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
  belongs_to :user

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

  def self.month_year_list
    sql = <<~SQL
      SELECT
        TRIM(TO_CHAR(created_at, 'Month')) AS month_name,
        TO_CHAR(created_at, 'MM') AS month_number,
        TO_CHAR(created_at, 'YYYY') AS year
      FROM pages
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  def make_slug
    return unless title

    self.slug = title
      .downcase
      .gsub(/[_ ]/, "-")
      .gsub(/[^-a-z0-9+]/, "")
      .gsub(/-{2,}/, "-")
      .gsub(/^-/, "")
      .chomp("-")
  end
end
