class CommonQuestionsController < ApplicationController
  def index
    c_question_1 = CommonQuestion.new("What is To-Doing?", "To-Doing is an awesome tool that is going to change your life. To-Doing is your one stop shop to organize all your tasks. You'll also be able to track comments that you and others make. To-Doing may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool.", "what-is-To-Doing")
    c_question_2 = CommonQuestion.new("How do I join To-Doing?", "As soon as it's ready for the public, you'll see a signup link in the upper right. Once that's there, just click it and fill in the form!", "how-do-i-join-To-Doing")
    c_question_3 = CommonQuestion.new("When will To-Doing be finished?", "To-Doing is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is just a click away. Amazing!", "when-will-To-Doing-be-finished")

        @faqs = [c_question_1, c_question_2, c_question_3]

  end
end
