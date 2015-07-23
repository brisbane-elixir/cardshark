defmodule CardShark.CommandExecutor do
  def execute(command = %CreateCard{}) do
    changeset = Card.changeset(%Card{}, command.card_params)

    if changeset.valid? do
      card = Repo.insert!(changeset)
      event = card |> Event.card_created |> Event.publish
      {:ok, card}
    else
      {:error, changeset}
    end
  end
end
