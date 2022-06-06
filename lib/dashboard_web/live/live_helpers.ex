defmodule DashboardWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

    @doc """
  Renders a component inside the `TestWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, TestWeb.UserLive.FormComponent,
        id: @user.id || :new,
        action: @live_action,
        user: @user,
        return_to: Routes.user_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, DashboardWeb.ModalComponent, modal_opts)
  end

  def live_select(form, field, options, opts \\ []) do
    assigns = %{form: form, field: field, options: options, opts: opts}

    ~L"""
      <div class="relative w-full">
        <%= Phoenix.HTML.Form.select @form, @field, @options, @opts %>
        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
          <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
        </div>
      </div>
    """
  end

  def days_left(date1, date2) do
    diff = 1 + Date.diff(date2, date1)
    day_string = if diff == 1 do
      "Tag"
    else
      "Tage"
    end

    "#{diff} #{day_string} übrig"
  end

  def textualize(string) do
    lines = string |> String.split("\n")

    assigns = %{lines: lines}

    ~L"""
    <%= for line <- @lines do %>
      <%= line %><br>
    <% end %>
    """
  end
end
