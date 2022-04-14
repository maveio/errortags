defmodule ErrortagsWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.LiveComponent

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(assigns) do
    ~H"""
    <%= for form_tag <- @has_error? do %>
      <div class={"transition-all duration-150 ease-out #{if Keyword.get_values(@f.errors, @name) |> length > 0, do: " h-10 overflow-visible", else: "h-0 overflow-hidden"}"}>
        <%= for error <- Keyword.get_values(@f.errors, @name) |> Enum.map(& translate_error(&1)) do %>
          <div class="flex -mb-1 border-transparent mx-3 items-center">
            <div class="text-rose-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><polyline points="14 15 9 20 4 15"></polyline><path d="M20 4h-7a4 4 0 0 0-4 4v12"></path></svg>
            </div>
            <div class="text-rose-400 mx-1.5 text-sm mb-3 w-40">
              <%= error %>
            </div>
          </div>
        <% end %>
      </div>

      <%= render_slot(form_tag, Keyword.get_values(@f.errors, @name) |> length > 0) %>
    <% end %>
    """
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(ErrortagsWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(ErrortagsWeb.Gettext, "errors", msg, opts)
    end
  end
end
