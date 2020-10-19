Feature: User can manually delete movie
  As a movie fan
  So that I can delete a movies that I was add 
Scenario: delete a movie
  Given I have added "Men In Black" with rating "G"
  When I follow "More about Men In Black"
  And I follow "Delete"
  And I come back to the RottenPotatoes home page
  Then I should not see "Men In Black"