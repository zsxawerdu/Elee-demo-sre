defmodule EleeWeb.FoodLive.Show do
  use EleeWeb, :live_view

  alias Elee.MobileFood

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:food, MobileFood.get_food!(id))}
  end

  defp page_title(:show), do: "Show Food"
  defp page_title(:edit), do: "Edit Food"
end
