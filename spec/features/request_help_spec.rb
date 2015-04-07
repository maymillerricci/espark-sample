require "rails_helper"

describe "request help" do

  before(:each) do
    @student = FactoryGirl.create(:student)
  end

  describe "student show page" do

    it "should display correct text" do
      visit student_path(@student.id)
      expect(page).to have_selector("h1", text: "Welcome, #{@student.name}")
      expect(page).to have_selector("a.request-help", text: "Request Help From My Teacher")
    end

  end

  describe "clicking request help button" do

    before(:each) do
      visit student_path(@student.id)
      click_link("Request Help From My Teacher")
    end

    it "should hide request help button and display teacher notified message on student page" do
      expect(page).to have_text("Your teacher has been notified of your request for help.")
      expect(page).to_not have_text("Request Help From My Teacher")
    end

    it "should show student help request on teacher page" do
      visit root_path
      expect(page).to have_text("#{@student.name} wants your help.")
    end

  end

end

# student view should have "Request Help From My Teacher" button
# when student clicks button
  # button disappears
  # indicator saying teacher has been notified appears

# teacher view
  # if no students have requested help
    # no alert that students have requested help
  # if any students have requested help
    # alert shows students who have requested help in the past day,
      # along with time help was requested,
      # along with option to clear help request for that student
    # TODO: how to deal with requests that last longer than a day without being cleared?
    # TODO: shouldn't student also be able to clear their own request?
      # (they could easily answer their own question before the teacher gets to them...)

# when teacher clears help request (after talking to student)
  # student disappears from teacher dashboard alert
  # button to request help shows up again for student
