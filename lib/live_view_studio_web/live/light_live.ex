defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :brightness, 10)}
  end

  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>
    </div>
    <div>
      <button phx-click="off">
        Off
      </button>
      <button phx-click="on">
        On
      </button>
      <button phx-click="down">
        Down
      </button>

      <button phx-click="up">
        Up
      </button>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    # method 1
    # brightness = socket.assigns.brightness + 10
    # socket = assign(socket, :brightness, brightness)

    # method 2
    # socket = update(socket, :brightness, fn b -> b + 10 end)
    # {:noreply, socket}

    # method 3
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end
end
