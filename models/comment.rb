class Comment < Sequel::Model
  many_to_one :created_user, class: 'User', key: :crt_user_id, primary_key: :user_id
  one_to_one :topic, class: 'Topic', key: :topic_id, primary_key: :ref_id

  def decorate
    {
      id: id,
      comment_text: comment_text,
      status: status,
      creted_at: crt_dt,
      updated_at: upd_dt,
      topic_name: topic.topic_name,
      topic_id: topic.topic_id,
      created_by: created_user.full_name
    }
  end
end