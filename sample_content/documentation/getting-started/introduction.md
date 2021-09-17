%{
    title: "Introduction to Phoenix.LiveView",
    position: 0,
    published: true
}
---
## Phoenix.LiveView behaviour (Phoenix LiveView v0.16.3)

LiveView provides rich, real-time user experiences with server-rendered HTML.

The LiveView programming model is declarative: instead of saying "once event X happens, change Y on the page", events in LiveView are regular messages which may cause changes to its state. Once the state changes, LiveView will re-render the relevant parts of its HTML template and push it to the browser, which updates itself in the most efficient manner. This means developers write LiveView templates as any other server-rendered HTML and LiveView does the hard work of tracking changes and sending the relevant diffs to the browser.

At the end of the day, a LiveView is nothing more than a process that receives events as messages and updates its state. The state itself is nothing more than functional and immutable Elixir data structures. The events are either internal application messages (usually emitted by [`Phoenix.PubSub`](https://hexdocs.pm/phoenix_pubsub/2.0.0/Phoenix.PubSub.html)) or sent by the client/browser.

LiveView is first rendered statically as part of regular HTTP requests, which provides quick times for "First Meaningful Paint", in addition to helping search and indexing engines. Then a persistent connection is established between client and server. This allows LiveView applications to react faster to user events as there is less work to be done and less data to be sent compared to stateless requests that have to authenticate, decode, load, and encode data on every request. The flipside is that LiveView uses more memory on the server compared to stateless requests.

## Use cases

There are many use cases where LiveView is an excellent fit right now:

- Handling of user interaction and inputs, buttons, and forms - such as input validation, dynamic forms, autocomplete, etc;
    
- Events and updates pushed by server - such as notifications, dashboards, etc;
    
- Page and data navigation - such as navigating between pages, pagination, etc can be built with LiveView using the excellent live navigation feature set. This reduces the amount of data sent over the wire, gives developers full control over the LiveView life-cycle, while controlling how the browser tracks those changes in state;
    

There are also use cases which are a bad fit for LiveView:

- Animations - animations, menus, and general UI events that do not need the server in the first place are a bad fit for LiveView. Those can be achieved without LiveView in multiple ways, such as with CSS and CSS transitions, using LiveView hooks, or even integrating with UI toolkits designed for this purpose, such as Bootstrap, Alpine.JS, and similar.

## Life-cycle

A LiveView begins as a regular HTTP request and HTML response, and then upgrades to a stateful view on client connect, guaranteeing a regular HTML page even if JavaScript is disabled. Any time a stateful view changes or updates its socket assigns, it is automatically re-rendered and the updates are pushed to the client.

You begin by rendering a LiveView typically from your router. When LiveView is first rendered, the [`mount/3`](#c:mount/3) callback is invoked with the current params, the current session and the LiveView socket. As in a regular request, `params` contains public data that can be modified by the user. The `session` always contains private data set by the application itself. The [`mount/3`](#c:mount/3) callback wires up socket assigns necessary for rendering the view. After mounting, [`render/1`](#c:render/1) is invoked and the HTML is sent as a regular HTML response to the client.

After rendering the static page, LiveView connects from the client to the server where stateful views are spawned to push rendered updates to the browser, and receive client events via `phx-` bindings. Just like the first rendering, [`mount/3`](#c:mount/3) is invoked with params, session, and socket state, where mount assigns values for rendering. However in the connected client case, a LiveView process is spawned on the server, pushes the result of [`render/1`](#c:render/1) to the client and continues on for the duration of the connection. If at any point during the stateful life-cycle a crash is encountered, or the client connection drops, the client gracefully reconnects to the server, calling [`mount/3`](#c:mount/3) once again.

## Example

Before writing your first example, make sure that Phoenix LiveView is properly installed. If you are just getting started, this can be easily done by running `mix phx.new my_app --live`. The `phx.new` command with the `--live` flag will create a new project with LiveView installed and configured. Otherwise, please follow the steps in the [installation guide](https://hexdocs.pm/phoenix_live_view/installation.html) before continuing.

### Example 1
A LiveView is a simple module that requires two callbacks: [`mount/3`](#c:mount/3) and [`render/1`](#c:render/1):

```
defmodule  MyAppWeb.ThermostatLive  do  # If you generated an app with mix phx.new --live,  # the line below would be: use MyAppWeb, :live_view  use  Phoenix.LiveView  def  render(assigns)  do  ~H"""
    Current temperature: <%= @temperature %>
    """  end  def  mount(_params,  %{"current_user_id"  =>  user_id},  socket)  do  temperature  =  Thermostat.get_user_reading(user_id)  {:ok,  assign(socket,  :temperature,  temperature)}  end  end
```

The [`render/1`](#c:render/1) callback receives the `socket.assigns` and is responsible for returning rendered content. We use the `~H` sigil to define a HEEx template, which stands for HTML+EEx. They are an extension of Elixir's builtin EEx templates, with support for HTML validation, syntax-based components, smart change tracking, and more. You can learn more about the template syntax in [`Phoenix.LiveView.Helpers.sigil_H/2`](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Helpers.html#sigil_H/2).

Next, decide where you want to use your LiveView.

### Example 2
You can serve the LiveView directly from your router (recommended):

```
defmodule  MyAppWeb.Router  do  use  Phoenix.Router  import  Phoenix.LiveView.Router  scope  "/",  MyAppWeb  do  live  "/thermostat",  ThermostatLive  end  end
```

*Note:* the above assumes there is `plug :put_root_layout` call in your router that configures the LiveView layout. This call is automatically included by `mix phx.new --live` and described in the installation guide. If you don't want to configure a root layout, you must pass `layout: {MyAppWeb.LayoutView, "app.html"}` as an option to the [`Phoenix.LiveView.Router.live/3`](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Router.html#live/3) macro above.

### Example 3
Alternatively, you can `live_render` from any template. In your view:

```
import  Phoenix.LiveView.Helpers
```

#### Example 3.1

Then in your template:

```
Temperature  Control  <%=  live_render(@conn,  MyAppWeb.ThermostatLive)  %>
```

When a LiveView is rendered, all of the data currently stored in the connection session (see [`Plug.Conn.get_session/1`](https://hexdocs.pm/plug/1.12.1/Plug.Conn.html#get_session/1)) will be given to the LiveView.

## Colocating templates

In the examples above, we have placed the template directly inside the LiveView:

```
defmodule  MyAppWeb.ThermostatLive  do  use  Phoenix.LiveView  def  render(assigns)  do  ~H"""
    Current temperature: <%= @temperature %>
    """  end
```
