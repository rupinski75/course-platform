# Demo data for the course platform.
puts "Seeding users..."
admin = User.find_or_create_by!(email: "admin@demo") do |user|
  user.password = "demopass123"
  user.role = :admin
end

student = User.find_or_create_by!(email: "student@demo") do |user|
  user.password = "demopass123"
  user.role = :student
end

puts "Seeding Ruby course (App Academy Open)..."
course = Course.find_or_create_by!(title: "Ruby") do |c|
           c.description = "The Ruby module of the App Academy Open curriculum: " \
                        "enumerables, references, recursion, git, data structures, OOP, RSpec, Big-O."
           c.published = true
         end

sections = {
  "Getting started" => [
    "Setting up a development environment"
  ],
  "Enumerables and debugging" => [
    "Nontechnical overview of Ruby",
    "Debugging",
    "Common exceptions",
    "Breaking methods into parts",
    "Enumerables project"
  ],
  "References and scope" => [
    "References",
    "Array and hash defaults",
    "Scope",
    "DRY: don't repeat yourself"
  ],
  "Recursion" => [
    "Recursion intro",
    "Recursion vs iteration",
    "Recursion homework"
  ],
  "Git" => [
    "Git: overview and why we use it",
    "Git: mental models",
    "Git workflow"
  ],
  "Data structures" => [
    "Data structures",
    "DFS",
    "Graph traversal",
    "Knights travails"
  ]
}

sections.each do |section_title, lesson_titles|
  section = course.sections.find_or_create_by!(title: section_title)
  lesson_titles.each do |lesson_title|
    section.lessons.find_or_create_by!(title: lesson_title) do |lesson|
      lesson.content = "Lesson from the App Academy Open Ruby curriculum " \
                       "(github.com/rupinski75/aa-public-ruby-curriculum)."
    end
  end
end

puts "Done: #{User.count} users, #{Course.count} course, " \
     "#{Section.count} sections, #{Lesson.count} lessons."
