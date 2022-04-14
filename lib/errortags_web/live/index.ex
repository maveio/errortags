defmodule ErrortagsWeb.Index do
  use ErrortagsWeb, :live_view

  alias Errortags.User

  def mount(_params, _session, socket) do
    changeset = User.registration_changeset(%User{})
    {:ok, socket |> assign(:changeset, changeset)}
  end

  def handle_event("submit", %{"user" => user_params}, socket) do
    changeset = User.registration_changeset(%User{}, user_params) |> Map.put(:action, :validate)
    {:noreply, socket |> assign(:changeset, changeset)}
  end

  def input(assigns) do
    ~H"""
    <.error_tag f={@f} name={@name}>
      <:has_error? let={has_error}>
        <%= text_input @f, @name,
          placeholder: @name,
          autocomplete: "off",
          spellcheck: "false",
          autocapitalize: "off",
          autocorrect: "off",
          class: "w-full rounded-md bg-white border border-stone-200 ring-1 ring-stone-200 ring-opacity-50 md:shadow-sm shadow-stone-200 placeholder-stone-300 text-md text-stone-700 px-4 pt-3 pb-2.5 cursor-pointer outline-none focus:ring-blue-500 hover:shadow-md hover:shadow-stone-100 focus:ring-2 transition ease-out transform-gpu hover:scale-105 duration-150 #{if has_error, do: "border border-red-500 bg-red", else: "md:border-none"}" %>
      </:has_error?>
    </.error_tag>
    """
  end

  def button(assigns) do
    ~H"""
    <button type="submit" class="relative inline-block items-center rounded-full cursor-pointer select-none overflow-hidden bg-blue-600 hover:bg-blue-500 active:bg-blue-600 text-white">
      <div class="flex items-center">
        <div class="py-1 z-10 px-4">
          <%= @label %>
        </div>
      </div>
    </button>
    """
  end
end
