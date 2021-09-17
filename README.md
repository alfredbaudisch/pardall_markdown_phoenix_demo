# PardallMarkdown Phoenix LiveView Demo

Demo project for the [PardallMarkdown](https://github.com/alfredbaudisch/pardall_markdown) framework. 

## Demo Features
- Example **Phoenix.LiveView website** that contains both **a Blog and a Documentation section**, both powered by PardallMarkdown **instant updates**.
    - Showcases archive pages, trees, single posts, sidebars, table of contents, next and previous posts, static images, etc.
- **Sample content**, with nested hierarchies, custom post metadata and taxonomy overrides and custom sorting. The sample content also includes local images and links.
- **[HTML helpers](./lib/pardall_markdown_web/views/pardall_markdown_helpers.ex) for PardallMarkdown** content trees, taxonomy trees and table of contents.
- HTML helper and example to create a **collapsible PardallMarkdown content tree**.

## Want to know more?
Check the [PardallMarkdown](https://github.com/alfredbaudisch/pardall_markdown) repository's README and or the library documentation.

## Demo instructions
To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.