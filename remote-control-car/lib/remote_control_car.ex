defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car) when is_struct(remote_car, RemoteControlCar) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car) when is_struct(remote_car, RemoteControlCar) do
    battery = remote_car.battery_percentage
    if battery == 0 do
      "Battery empty"
    else
      "Battery at #{battery}%"
    end
  end

  def drive(remote_car) when is_struct(remote_car, RemoteControlCar) do
    battery = remote_car.battery_percentage
    distance = remote_car.distance_driven_in_meters
    if battery == 0 do
      remote_car
    else
      remote_car
      |> Map.put(:battery_percentage, battery - 1)
      |> Map.put(:distance_driven_in_meters, distance + 20)
    end
  end
end
