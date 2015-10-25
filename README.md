= Mongoa
== Missing matchers for Rspec w/ MongoMapper, inspired by Shoulda (thanks to Thoughtbot)

= Usage

Test your MongoMapper associations and validations. Currently only works with RSpec.

    describe Post do
	    it { should belong_to(:user) }
	    it { should have_many(:comments) }

	    it { should validate_presence_of(:body) }
	    it { should validate_inclusion_of(:state, %w("new" "active" "closed")) }
	    it { should validate_length_of(:image_path, :maximum => 256) }
	    it { should validate_numericality_of(:times_read) } #FORTHCOMING
	  end

= Credits

Mongoa was inspired by Shoulda, the excellent gem by {thoughtbot}[http://thoughtbot.com/community]

== Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010 Scott J. Tamosunas. See LICENSE for details.
