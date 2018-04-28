defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new game returns game struct" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "game state doesn't change when game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game()
             |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, 'x')
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, tally} = Game.make_move(game, 'x')
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    {game, tally} = Game.make_move(game, 'x')
    assert game.game_state != :already_used
    {game, tally} = Game.make_move(game, 'x')
    assert game.game_state == :already_used
  end

end