defmodule Cards do
  @moduledoc """
    Provides methos for creating and handling decks of cards
  """
  
  @doc """
    Returns a lis of string representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamons"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def suffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples
    iex> deck = Cards.create_deck
    iex> Cards.contains?(deck, "Ace of Spades")
    true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and hte remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.suffle
    |> Cards.deal(hand_size)
  end
end
