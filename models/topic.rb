class Topic < Sequel::Model(:topics)
  one_to_one :user, class: 'User', key: :user_id, primary_key: :user_id
  one_to_many :pending_comments, class: 'Comment', key: :ref_id, primary_key: :topic_id,
              conditions: { ref_type: 'TOPIC', status: 'P' }
  one_to_many :approved_comments, class: 'Comment', key: :ref_id, primary_key: :topic_id,
              conditions: { ref_type: 'TOPIC', status: 'A' }
  one_to_many :all_comments, class: 'Comment', key: :ref_id, primary_key: :topic_id, conditions: { ref_type: 'TOPIC' }

  add_association_dependencies all_comments: :destroy

  def decorate
    {
      topic_id: topic_id,
      topic_name: topic_name,
      topic_desc: topic_desc,
      created_by: user.full_name,
      crt_dt: crt_dt,
      upd_dt: upd_dt,
      comments_count: all_comments.count
    }
  end
end