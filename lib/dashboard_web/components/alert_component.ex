defmodule AlertComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    if live_flash(assigns.flash, assigns.key) do
      ~L"""
      <div class="alert alert-<%= @key %>"
        phx-value-key="<%= @key %>" role="alert"
      >
        <div>
          <span class="font-semibold mr-2 text-left flex-auto">
            <%= live_flash(@flash, String.to_atom(@key)) %>
          </span>
        </div>
        <div>
          <svg class="stroke-current w-3 h-3 opacity-75 cursor-pointer ml-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" phx-click="lv:clear-flash">
            <path d="M0,0 L20,20" />
            <path d="M20,0 L0,20" />
          </svg>
        </div>
      </div>
      """
    else
      ~L"""
      """
    end
  end
end
