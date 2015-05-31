class Category < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  before_save :unique_category_for_user

  def self.user_categories_by_keyword(user, keyword)
    user.categories.where("name LIKE ?", "%#{keyword}%").all
  end

    private
    def unique_category_for_user
      if Category.where(user_id: user_id, name: name).present?
        errors[:name] << "You already have a category with #{name}"
      end
    end

end
