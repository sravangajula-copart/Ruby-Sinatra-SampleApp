class User < Sequel::Model

  one_to_many :topics, class: 'Topic', key: :user_id

  add_association_dependencies topics: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end


end