defmodule CardShark.ProjectBoardContext do
  use WhiteBread.Context
  given_ ~r/^a project with the columns:$/, fn state, %{ table_data: table_data } ->
    project = CardSharkDriver.create_project "A test project"
    CardSharkDriver.define_columns table_data[0]
    {:ok, %{ state | project: project }}
  end

  given_ ~r/^I add a ticket "(?<argument_one>[^"]+)" with status "(?<argument_two>[^"]+)"$/,
  fn state, %{argument_one: _argument_one,argument_two: _argument_two} ->
    {:ok, state}
  end

  when_ ~r/^I request the project board$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^a board is displayed like:$/, fn state ->
    {:ok, state}
  end

end
