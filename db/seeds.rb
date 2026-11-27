# Demo data for the course platform.
# Lesson content vendored from github.com/rupinski75/aa-public-ruby-curriculum
# at commit 8855294; license and source live in db/seed_data/.
# nil filename - placeholder content

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

SEED_DATA = Rails.root.join("db/seed_data")
PLACEHOLDER = "Lesson from the App Academy Open Ruby curriculum " \
              "(github.com/rupinski75/aa-public-ruby-curriculum)."
sections = {
  "Getting started" => { "Setting up a development environment" => "dev_setup.md" },
  "Enumerables and debugging" => {
    "Nontechnical overview of Ruby" => "ruby_nontech.md",
    "Debugging" => "debugger.md",
    "Common exceptions" => "common-exceptions.md",
    "Breaking methods into parts" => "breaking-into-parts.md",
    "Enumerables project" => "enumerables_project.md"
  },
  "References and scope" => {
    "References" => "references.md",
    "Array and hash defaults" => "array-hash-defaults.md",
    "Scope" => "scope.md",
    "DRY: don't repeat yourself" => "dry.md"
  },
  "Recursion" => {
    "Recursion intro" => "recursion.md",
    "Recursion vs iteration" => nil,
    "Recursion homework" => "recursion_homework.md"
  },
  "Git" => {
    "Git: overview and why we use it" => "why-git.md",
    "Git: mental models" => "git-summary.md",
    "Git workflow" => "git-workflow.md"
  },
  "Data structures" => {
    "Data structures" => "intro-algorithms-and-data-structures.md",
    "DFS" => nil,
    "Graph traversal" => "graph_traversal_notes_reading.md",
    "Knights travails" => "knights_travails.md"
  }
}
sections.each do |section_title, lessons|
  section = course.sections.find_or_create_by!(title: section_title)
  lessons.each do |lesson_title, filename|
    content = filename ? SEED_DATA.join(filename).read : PLACEHOLDER
    lesson = section.lessons.find_or_create_by!(title: lesson_title)
    lesson.update!(content: content) unless lesson.content == content
  end
end

puts "Done: #{User.count} users, #{Course.count} course, " \
     "#{Section.count} sections, #{Lesson.count} lessons."
