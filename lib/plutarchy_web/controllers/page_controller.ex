defmodule PlutarchyWeb.PageController do
  use PlutarchyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
