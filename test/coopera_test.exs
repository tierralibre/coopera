defmodule CooperaTest do
  use ExUnit.Case
  doctest Coopera

  test "create key pair and sign document" do
    {:ok, %{secret: secret, public: public}} = :sphincs.keypair()

    sd = :sphincs.sign("document", secret)
    result = :sphincs.verify(sd, public)
    assert result == {:ok, "document"}
  end

  test "jason encode" do
    map = %{"age" => 44, "name" => "Steve Irwin", "nationality" => "Australian"}
    encode = Jason.encode!(map)
    IO.inspect encode

    decode = Jason.decode!(encode)

    assert decode == map

  end

  test "write file" do
    db_folder = "wallets"
    key = "wallet_key"
    #path = Path.join(db_folder, to_string(key))
    {:ok, data} = :sphincs.keypair()
    File.mkdir_p!(db_folder)

    db_folder
    |> file_name(key)
    |> IO.inspect
    |> File.write!(:erlang.term_to_binary(data))

    read_data =
      case File.read(file_name(db_folder, key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    assert data == read_data

    #File.write!(:erlang.term_to_binary(data))
  end

  defp file_name(db_folder, key) do
    Path.join(db_folder, to_string(key))
  end

  def hash(data, algo), do: :crypto.hash(algo, data)


end
