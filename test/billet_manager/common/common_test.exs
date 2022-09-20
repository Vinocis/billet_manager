defmodule BilletManager.CommonTest do
  use ExUnit.Case

  alias BilletManager.Common

  @moduletag :unit

  describe "parse_integer_to_money!/2" do
    test "when amount is passed as integer" do
      parsed_value = Common.parse_to_money!(100)

      assert parsed_value == %Money{amount: 100, currency: :BRL}
    end

    test "when amount is string" do
      parsed_value = Common.parse_to_money!("1.234,56")

      assert parsed_value == %Money{amount: 123_456, currency: :BRL}
    end
  end
end
