defmodule TcpPlayground do
end

defmodule TcpPlayground.TaskOne do
  def listen(port) do
    {:ok, listen_socket} = :gen_tcp.listen(port, [:binary, active: false])
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    {:ok, received} = receive_data(socket, [])
    :ok = :gen_tcp.close(socket)
    received
  end

  defp receive_data(socket, acc) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        receive_data(socket, [data|acc])

      {:error, :closed} ->
        data = Enum.reverse(acc) |> :erlang.list_to_binary
        {:ok, data}
    end
  end
end
