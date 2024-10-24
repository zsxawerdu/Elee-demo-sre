defmodule EleeWeb.FoodLive.FormComponent do
  use EleeWeb, :live_component

  alias Elee.MobileFood

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage food records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="food-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:location]} type="text" label="Location" />
        <.input field={@form[:rating]} type="text" label="Rating" />
        <.input field={@form[:cost]} type="text" label="Cost" />
        <.input field={@form[:hours]} type="text" label="Hours" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Food</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{food: food} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(MobileFood.change_food(food))
     end)}
  end

  @impl true
  def handle_event("validate", %{"food" => food_params}, socket) do
    changeset = MobileFood.change_food(socket.assigns.food, food_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"food" => food_params}, socket) do
    save_food(socket, socket.assigns.action, food_params)
  end

  defp save_food(socket, :edit, food_params) do
    case MobileFood.update_food(socket.assigns.food, food_params) do
      {:ok, food} ->
        notify_parent({:saved, food})

        {:noreply,
         socket
         |> put_flash(:info, "Food updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_food(socket, :new, food_params) do
    case MobileFood.create_food(food_params) do
      {:ok, food} ->
        notify_parent({:saved, food})

        {:noreply,
         socket
         |> put_flash(:info, "Food created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
