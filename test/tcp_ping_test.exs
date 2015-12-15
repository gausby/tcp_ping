defmodule TcpPingTest do
  use ExUnit.Case
  doctest TcpPing

  test "task 1" do
    # setup tcp server and listen on port 9000
    ref = Task.async(TcpPlayground.TaskOne, :listen, [9000])
    message = "Hello, world!"

    # connect to the tcp server
    {:ok, port} = :gen_tcp.connect('localhost', 9000, [])
    :gen_tcp.send(port, message)
    :gen_tcp.close(port)

    # the server should receive the message we send
    assert Task.await(ref) == message
  end

  test "task 2" do
    {:ok, pid} = TcpPlayground.TaskTwo.start_link()
  end
end
