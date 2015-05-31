class Category < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true

  def self.user_categories_by_keyword(user, keyword)
    user.categories.where("LOWER(name) LIKE LOWER(?)", "%#{keyword}%").all
  end

end
