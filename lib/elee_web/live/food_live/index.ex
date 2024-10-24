defmodule EleeWeb.FoodLive.Index do
  use EleeWeb, :live_view

  alias Elee.MobileFood
  alias Elee.MobileFood.Food

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :mobile, MobileFood.list_mobile())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Food")
    |> assign(:mobile, MobileFood.get_food!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Food")
    |> assign(:mobile, %Food{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Foods")
    |> assign(:mobile, nil)
  end

  @impl true
  def handle_info({EleeWeb.FoodLive.FormComponent, {:saved, mobile}}, socket) do
    {:noreply, stream_insert(socket, :mobile, mobile)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    food = MobileFood.get_food!(id)
    {:ok, _} = MobileFood.delete_food(food)

    {:noreply, stream_delete(socket, :foods, food)}
  end
end
