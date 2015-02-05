# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(name: "Levi")
u2 = User.create!(name: "Joe")

p1 = Poll.create!(title: "Weather", author_id: u1.id)
p2 = Poll.create!(title: "Sports", author_id: u2.id)
p3 = Poll.create!(title: "News", author_id: u2.id)

q1 = Question.create!(body: "How's the weather?", poll_id: p1.id)
q2 = Question.create!(body: "Do you watch football?", poll_id: p2.id)
q3 = Question.create!(body: "Snow or rain?", poll_id: p1.id)

a1 = AnswerChoice.create!(body: "great", question_id: q1.id)
a2 = AnswerChoice.create!(body: "amazing", question_id: q1.id)
a3 = AnswerChoice.create!(body: "yes", question_id: q2.id)
a4 = AnswerChoice.create!(body: "no", question_id: q2.id)

Response.create!(respondent_id: u1.id, answer_choice_id: a3.id)
Response.create!(respondent_id: u2.id, answer_choice_id: a1.id)
