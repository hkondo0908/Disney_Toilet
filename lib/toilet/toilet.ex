defmodule Toilet.Toilet do
  use Ecto.Schema
  schema "toilets" do
    field :name, :string
    field :latitude, :float
    field :longitude, :float
  end

  def changeset(toilet, params \\ %{}) do
    toilet
    |> Ecto.Changeset.cast(params, [:name, :latitude,:longitude])
  end

  def length(lat1, lon1, lat2, lon2) do
    x = abs(lat1 - lat2) * 110949.769
    y = abs(lon1 - lon2) * 90163.292
    :math.sqrt(:math.pow(x,2) + :math.pow(y,2))
  end

  def read_csv(filename) do
    toilet = %Toilet.Toilet{}
    Path.expand(filename)
    |> File.stream!
    |> CSV.Decoding.Decoder.decode(headers: true)
    |> Enum.to_list()
    |> Keyword.get_values(:ok)
    |> Enum.each(fn map ->
      changeset(toilet,map)
      |> Toilet.Repo.insert()
    end)
  end

  def is_near? do
    x = IO.gets("x>")
    |> String.trim()
    |> String.to_float()
    y = IO.gets("y>")
    |> String.trim()
    |> String.to_float()

    data = Toilet.Toilet |> Toilet.Repo.all
    |> Enum.map(&Map.take(&1,[:name,:latitude,:longitude]))
    Enum.map(data, fn %{name: name,latitude: lat, longitude: lon} ->
      if length(lat,lon,x,y) <= 50 do
        name
      end
    end)
    |> Enum.filter(& &1)
    |> Enum.each(&IO.puts(&1))


  end


end
