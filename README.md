# PardallMarkdown Phoenix LiveView Demo [![Donate using PayPal](https://raw.githubusercontent.com/laurent22/joplin/dev/Assets/WebsiteAssets/images/badges/Donate-PayPal-green.svg)](https://www.paypal.com/donate?hosted_button_id=FC5FTRRE3548C) [![Become a patron](https://raw.githubusercontent.com/laurent22/joplin/dev/Assets/WebsiteAssets/images/badges/Patreon-Badge.svg)](https://www.patreon.com/alfredbaudisch)

Demo project for the [PardallMarkdown](https://github.com/alfredbaudisch/pardall_markdown) framework. 

# Demo Features
- Example **Phoenix.LiveView website** that contains both **a Blog and a Documentation section**, both powered by PardallMarkdown **instant updates**.
    - Showcases archive pages, trees, single posts, sidebars, table of contents, next and previous posts, static images, etc.
- **[Sample content](./sample_content)**, with nested hierarchies, custom post metadata and taxonomy overrides and custom sorting. The sample content also includes local images and links.
- **[HTML helpers](./lib/pardall_markdown_web/views/pardall_markdown_helpers.ex) for PardallMarkdown** content trees, taxonomy trees and table of contents.
- HTML helper and example to create a **collapsible PardallMarkdown content tree**.

# Video Demo and Tutorial
See PardallMarkdown in action and learn how to use it by following this video:
[![](https://github.com/alfredbaudisch/pardall_markdown/blob/master/sample_content/static/images/pardallmarkdown-demo-and-tutorial-with-play.jpg)](https://www.youtube.com/watch?v=FdzqToe3dug)

# Want to know more?
Check [PardallMarkdown](https://github.com/alfredbaudisch/pardall_markdown) repository's README and or the library documentation.

# Demo instructions
- [Configure](https://github.com/alfredbaudisch/pardall_markdown#usage-in-elixir-otp-applications) the application. You can use the included local "sample_content" folder, or change to another folder.
- Install dependencies with `mix deps.get`
- Start Phoenix endpoint with `mix phx.server`
- Visit [`localhost:4000`](http://localhost:4000).
- Change content from inside the content folder and see it being reflected in the website.

# How to use the Sample application for your own website?
- Change the [configuration](https://github.com/alfredbaudisch/pardall_markdown#usage-in-elixir-otp-applications) accordingly, especially the `root_path` path.
- Adjust the Phoenix.LiveView views and components accordingly.
- Deploy!

# Copyright License

    Copyright 2021 Alfred Reinold Baudisch (alfredbaudisch, pardall)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
