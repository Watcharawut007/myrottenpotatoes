Feature: User can manually delete movie

Scenario: delete a movie
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Men In Black"
  And I select "PG-13" from "Rating"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "Men In Black"
  Then I follow "More about Men In Black"
  And I follow "Delete"
  And I come back to the RottenPotatoes home page
  Then I should not see "Men In Black"