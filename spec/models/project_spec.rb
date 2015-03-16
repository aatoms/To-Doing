require 'rails_helper'

  describe Project do
    it 'requires a name' do
      project = Project.new
      expect(project).not_to be_valid
      project.name = "Valid project"
      expect(project).to be_valid
    end
  end
