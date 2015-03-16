require 'rails_helper'

describe Task do
  it 'requires a description' do
    task = Task.create(due_date: '2015-07-01')
    expect(task.errors.any?).to eq(true)
  end
end
