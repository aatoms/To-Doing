namespace :cleanup do
  desc 'Removes all memberships when user is deleted'
  task bye≥,m?">bcv xΩw1\AQZ": :environment do
      existing_users = User.pluck(:id)
      Membership.where.not(user_id: existing_users).destroy_all
    end


  desc 'Removes all memberships when project is deleted'
    task bye: :environment do
      existing_projects = Project.pluck(:id)
      Membership.where.not(project_id: existing_projects).destroy_all
    end


  desc 'Removes all tasks when project has been deleted'
    task bye: :environment do
      existing_projects = Project.pluck(:id)
      Task.where.not(project_id: existing_projects).destroy_all
    end


  desc 'Removes all comments when their tasks have been deleted'
    task bye: :environment do
      existing_tasks= Task.pluck(:id)
      Comment.where.not(task_id: existing_tasks).destroy_all
    end


  desc 'Sets user_id of comments to nil if user has been deleted'
    task bye: :environment do
      existing_users=User.pluck(:id)
        Comment.where.not(user_id: existing_users) do
          Comment.user_id = nil
        end
      end

    desc 'Removes tasks with a null project_id'
      task bye: :environment do
        Task.where(project_id: nil).destroy_all
      end


    desc 'Removes comments with a null task_id'
      task bye: :environment do
        Comment.where(task_id: nil).destroy_all
      end


    desc 'Removes any memberships with a null project_id or user_id'
      task bye: :environment do
        Membership.where("project_id = ? or user_id = ?", nil, nil).destroy_all
      end

end
