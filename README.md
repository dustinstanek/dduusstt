# dduusstt.cargo.site

Source backup of the **new media only** Cargo 3 site.

Extracted from Cargo's internal Redux store on 2026-03-21.

## Structure

```
global.css                  — site-wide stylesheet (fonts, layout, vars)
top/                        — landing page / enter button variants
website/                    — nav, header, main menu, workpage
photography-folder/         — all photo project pages
  ├── 2518-folder/
  ├── shy-ranje-folder/
  ├── synthesis+-folder/
  ├── in-whos-name-folder/
  ├── bulow-folder/
  ├── analogue-folder/
  ├── hissy-fitter-folder/
  ├── photo-project-example/
  └── mutumbo-folder/
films-folder/               — film, tv, adverts, music videos
creative-direction-folder/  — extasy, act group, odie
fonts-+-typefaces/           — type specimens and testing
index.html / index-v1..v3   — index page variants
```

## File conventions

Each Cargo page becomes two files:
- `page-name.html` — the page's HTML content (from Cargo's Code View)
- `page-name.css` — the page's local/scoped CSS

`global.css` is the site-wide stylesheet shared across all pages.

## Editing workflow

1. Edit files here (or via Claude Code)
2. Copy changes into Cargo's editor:
   - **Global CSS** → Cargo CSS Editor
   - **Page HTML** → open page → Code View (bottom-right `</>` icon) → paste
   - **Page CSS** → page design panel → local CSS area
3. Commit changes to Git

## Stats

- **70** pages across **25** folders
- **37 KB** global CSS
- **164 KB** total code (HTML + CSS)
