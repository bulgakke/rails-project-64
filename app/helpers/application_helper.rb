module ApplicationHelper
  def updated?(resource)
    resource.updated_at != resource.created_at
  end
end
