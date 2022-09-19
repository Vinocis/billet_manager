defmodule BilletManager.CommonTest do
  use ExUnit.Case

  alias BilletManager.Common

  @moduletag :unit

  describe "parse_integer_to_money!/2" do
    test "when just amount is passed currency is BRL" do
      parsed_value = Common.parse_integer_to_money!(100)

      assert %Money{amount: 100, currency: :BRL} == parsed_value
    end

    test "when amount and currency is passed" do
      parsed_value = Common.parse_integer_to_money!(100, :USD)

      assert %Money{amount: 100, currency: :USD} == parsed_value
    end
  end
end
