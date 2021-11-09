# PardallMarkdown Phoenix LiveView Demo [![Donate using PayPal](https://raw.githubusercontent.com/laurent22/joplin/dev/Assets/WebsiteAssets/images/badges/Donate-PayPal-green.svg)](https://www.paypal.com/donate?hosted_button_id=FC5FTRRE3548C) [![Become a patron](https://raw.githubusercontent.com/laurent22/joplin/dev/Assets/WebsiteAssets/images/badges/Patreon-Badge.svg)](https://www.patreon.com/alfredbaudisch)

Demo project for the [PardallMarkdown](https://github.com/alfredbaudisch/pardall_markdown) framework.

Production website running with this template: https://pardall.xyz. *Notice that the website Pardall.xyz is my own experimental Wiki, and the content is not the same as the [demo sample content](https://github.com/alfredbaudisch/pardall_markdown_sample_content) used in this demo application, but other than that, it's the same source code (pardall.xyz content comes from the [alfredbaudisch/pardall.xyz_content](https://github.com/alfredbaudisch/pardall.xyz_content) repository)*.

# Demo Features
- Example **Phoenix.LiveView website** that contains both **a Blog and a Documentation section**, both powered by PardallMarkdown **instant updates**.
    - Showcases archive pages, trees, single posts, sidebars, table of contents, next and previous posts, static images, etc.
- **[Sample content](https://github.com/alfredbaudisch/pardall_markdown_sample_content)**, with nested hierarchies, custom post metadata and taxonomy overrides and custom sorting. The sample content also includes local images and links.
- **[HTML helpers](./lib/pardall_web/views/pardall_markdown_helpers.ex) for PardallMarkdown** content trees, taxonomy trees and table of contents.
- HTML helper and example to create a **collapsible PardallMarkdown content tree**.

# Video Demo and Tutorial
See PardallMarkdown in action and learn how to use it by following this video:
[![](https://github.com/alfredbaudisch/pardall_markdown/blob/master/sample_content/static/images/pardallmarkdown-demo-and-tutorial-with-play.jpg)](https://www.youtube.com/watch?v=FdzqToe3dug)

# Want to know more?
Check [PardallMarkdown](https://github.com/alfredbaudisch/pardall_markdown) repository's README and or the library documentation.

# How to run the demo?
- [Configure](https://github.com/alfredbaudisch/pardall_markdown#usage-in-elixir-otp-applications) the application. You can use the included local "sample_content" `remote_repository_url: "https://github.com/alfredbaudisch/pardall_markdown_sample_content"` sample content repository, or change to another folder and/or another repository.
    - Remember that `root_path` is required, but `remote_repository_url` is optional. You can use content from a folder, without pulling it from a repository.
- Install dependencies with `mix deps.get`
- Install JS deps (currently only "top_bar" to make the LiveView experience a little better): `cd assets & npm install`
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
