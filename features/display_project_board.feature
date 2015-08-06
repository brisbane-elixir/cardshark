Feature: Displays a project board

  Scenario: Displays simple project board
    Given a project with the columns:
    | To Do | Doing | Done |
    And I add a ticket "Do something" with status "To Do"
    And I add a ticket "Do something else" with status "Doing"
    And I add a ticket "A thing to be done" with status "Done"
    When I request the project board
    Then a board is displayed like:
    | To Do        | Doing             | Done               |
    | Do something | Do something else | A thing to be done |

