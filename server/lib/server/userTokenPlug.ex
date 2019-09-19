defmodule Server.UserTokenPlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    token = Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end)
    if token do
      infoToken = Server.Token.verify_and_validate(Kernel.elem(token, 1))
      if Kernel.elem(infoToken, 0) == :ok do
        conn
        |> put_status(:ok)
      else
        conn
        |> send_resp(:unauthorized, "Login to proceed")
        |> halt()
      end
    else
        conn
        |> send_resp(:unauthorized, "Login to proceed")
        |> halt()
    end
  end
end