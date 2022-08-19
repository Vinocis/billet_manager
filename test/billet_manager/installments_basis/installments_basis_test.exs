defmodule BilletManager.InstallmentsBasis.InstallmentsBasisTest do
  use BilletManager.DataCase

  alias BilletManager.InstallmentsBasis
  alias BilletManager.InstallmentsBasis.Db
  alias BilletManager.Common.Adapters.Pagination, as: PaginationAdapter

  describe "create_customer/1" do
    test "create a customer with valid params" do
      customer = %{
        name: "Jhon Doe",
        cpf: "111.444.777-35"
      }

      assert {:ok, _} = InstallmentsBasis.create_customer(customer)
    end

    test "fails to create a customer with invalid params" do
      customer = %{
        name: "Jhon Doe"
      }

      assert {:error, _} = InstallmentsBasis.create_customer(customer)
    end
  end

  describe "update_customer/2" do
    test "updates a existent customer" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      new_customer_name = %{"customer_name" => "Jhon Doe"}

      assert {:ok, _} = InstallmentsBasis.update_customer(new_customer_name, customer.cpf)
    end

    test "fails to update if customer does not exist" do
      new_customer_name = %{"customer_name" => "Jhon Doe"}

      assert {:error, error} =
               InstallmentsBasis.update_customer(new_customer_name, "111.444.777-35")

      assert error == :customer_not_found
    end

    test "fails to update with invalid params" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      attrs_for_update = %{name: 1111}

      assert {:error, _} = InstallmentsBasis.update_customer(attrs_for_update, customer.cpf)
    end
  end

  describe "create_billet/1" do
    test "create billet with valid params and customer exists" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      customer = Db.get_customer_by_params(cpf: "111.444.777-35")

      billet = %{
        customer_id: customer.id,
        code: "11111.11111 11111.11111",
        value: 250,
        expire_on: "2022-10-03T14:08:48-03:00"
      }

      assert {:ok, _} = InstallmentsBasis.create_billet(billet)
    end

    test "fails to create billet with valid params and customer doesn't exists" do
      billet = %{
        "billet_code" => "11111.11111 11111.11111",
        "billet_value" => 250,
        "billet_expire_on" => "2022-10-03T14:08:48-03:00"
      }

      assert {:error, error} = InstallmentsBasis.create_billet(billet)
      assert error == :customer_not_found
    end

    test "fails to create billet with invalid params and customer exists" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      customer = Db.get_customer_by_params(cpf: "111.444.777-35")

      billet = %{
        "customer_id" => customer.id,
        "billet_code" => "11111.11111 11111.11111",
        "billet_value" => nil,
        "billet_expire_on" => "2022-10-03T14:08:48-03:00"
      }

      assert {:error, _} = InstallmentsBasis.create_billet(billet)
    end
  end

  describe "list_customers_with_pagination/1" do
    test "returns a map with a list of customers and pagination info" do
      customer = %{cpf: "111.444.777-35", name: "Jhon Doe"}
      Db.insert_customer(customer)

      params = %{page: 1, page_size: 50}
      {:ok, pagination_data} = PaginationAdapter.params_to_internal_pagination(params)
      data = InstallmentsBasis.list_customers_with_pagination(pagination_data)

      assert [pagination_customer] = data.entries
      assert pagination_customer == customer
    end
  end
end
