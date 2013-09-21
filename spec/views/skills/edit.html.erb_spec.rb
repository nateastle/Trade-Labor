require 'spec_helper'

describe "skills/edit" do
  before(:each) do
    @skill = assign(:skill, stub_model(Skill,
      :name => "MyString"
    ))
  end

  it "renders the edit skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skill_path(@skill), "post" do
      assert_select "input#skill_name[name=?]", "skill[name]"
    end
  end
end
