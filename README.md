# nathanjordaan.com

My personal CV site — a simple Rails 8.1 showcase that powers [nathanjordaan.com](https://nathanjordaan.com).

## What it does

- **Public CV** — renders my CV as a clean web page with a downloadable PDF version
- **Contact form** — lets visitors get in touch (with honeypot spam protection)
- **Admin panel** — lets me edit CV sections, entries, and bullet points behind authentication

## Tech stack

- **Rails 8.1** with SQLite, Propshaft, and Solid Queue/Cache/Cable
- **Phlex** for component-driven views
- **RubyUI** for styled UI primitives
- **Prawn** for PDF generation
- **Turbo & Stimulus** for interactivity

## Deployed at

**[nathanjordaan.com](https://nathanjordaan.com)** — deployed via [Kamal](https://kamal-deploy.org) as a Docker container on a VPS, with SSL via Let's Encrypt.

## Running locally

```bash
bin/setup
bin/rails server
```

Then visit `http://localhost:3000`.
