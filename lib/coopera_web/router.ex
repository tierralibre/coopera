defmodule CooperaWeb.Router do
  use CooperaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CooperaWeb do
    pipe_through :api
  end
end
