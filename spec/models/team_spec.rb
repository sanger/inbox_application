require 'rails_helper'

RSpec.describe Team, type: :model do


  let(:valid_attributes) {
    {
      key: generate(:team_key)
    }
  }

  it "will auto generate a unique key" do
    existing_team = create :team, name: 'example', key: 'example'
    new_team = Team.new(name: 'example')
    expect(new_team).to be_valid
    expect(new_team.key).to_not eq('example')
  end

  it "requires a key" do
    new_team = Team.new(valid_attributes.merge(key: nil))
    expect(new_team).to_not be_valid
    expect(new_team.errors[:key]).to include("can't be blank")
  end

  it "converts names to keys" do
    new_team = Team.new(name:'Team A')
    expect(new_team.key).to eq('team-a')
  end

  it "requires a name that can be parameterized" do
    new_team = Team.new(name: '!"$%')
    expect(new_team).to_not be_valid
    expect(new_team.errors[:name]).to include("must contain at least one letter or number")
  end

  it 'shows returns inboxes in the specified order' do
    team = create :team
    inbox_last  = (create :team_inbox, team: team, order: 2).inbox
    inbox_first = (create :team_inbox, team: team, order: 1).inbox
    expect(team.inboxes).to include(inbox_first)
    expect(team.inboxes).to include(inbox_last)
    expect(team.inboxes.first).to eq(inbox_first)
  end
end
