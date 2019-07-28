class TaskPublicationSerializer < ActiveModel::Serializer

  attributes :id, :task_submission_id, :link, :created_at, :platform

  def platform
    self.object.publishing_platform.name
  end

end


