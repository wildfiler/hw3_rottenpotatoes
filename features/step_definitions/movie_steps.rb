# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create movie
  end
#  flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |film1, film2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"
    page.body.should =~ /#{film1}.*#{film2}/im
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(%r{,\s*}).each do |rating|
    if uncheck
      step %{I uncheck "ratings_#{rating}"}
    else
      step %{I check "ratings_#{rating}"}
    end
  end
end

Then /^I should( not)? see the following movies:$/ do |not_see, movies_table|
  # table is a Cucumber::Ast::Table
  movies_table.hashes.each do |movie|
    if not_see
      page.should have_no_content movie[:title]
    else
      page.should have_content movie[:title]
    end
  end
end

Given /^I (un)?check all ratings$/ do |uncheck|
#  pending # express the regexp above with the code you wish you had
  page.all("#ratings_form input[type=checkbox]").each do |rating_element|
    rating_id = rating_element[:id]
    if uncheck
      uncheck rating_id
    else
      check rating_id
    end
  end
end

Then /^I should not see any movie$/ do
#  pending # express the regexp above with the code you wish you had
#  page.all("table#movies tr").count.should == 0#Movies.all.count
end

Then /^I should see all of the movies$/ do
#  pending # express the regexp above with the code you wish you had
  page.all("table#movies tbody tr").count.should == Movie.all.count
end