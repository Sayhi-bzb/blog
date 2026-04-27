# Design System: Personal Blog Template
**Project ID:** Local Jekyll template derived from `no-style-please`

## 1. Visual Theme & Atmosphere

This design system is built around a deliberately restrained form of late-20th-century hacker minimalism. It should feel closer to a personal text file, a low-resolution reading document, or an early hand-authored web page than to a branded product interface. The mood is plainspoken, quiet, anti-decorative, and slightly austere without becoming hostile.

The governing principle is not "unstyled" in the careless sense. It is "nearly no CSS" as an editorial stance. Styling exists only where it materially improves reading, hierarchy, or content clarity. The interface should never appear polished for its own sake. It should appear useful, calm, and intentionally underdesigned.

This system should avoid modern SaaS cues. No soft cards, no lush gradients, no ornamental iconography, no glossy component polish. Visual identity comes from discipline: semantic HTML, square edges, monochrome contrast, and strong reading rhythm.

At the same time, the experience should respect modern reading habits. The page is intentionally narrow, breathing room is generous, paragraphs are separated clearly, and headings open up the vertical rhythm. The result is retro in tone but contemporary in comfort.

## 2. Color Palette & Roles

- **Paper White (`#ffffff`)**: The default page field. Used as the uninterrupted background for both `html` and `body`, creating a bright document-like surface.
- **Terminal Black (`#000000`)**: The primary foreground color. Used for body text, borders, horizontal rule ornamentation, table strokes, and the visual skeleton of the interface.
- **Reversed Ink White (`#ffffff`) on Terminal Black (`#000000`)**: Used for inline code and code blocks. Inline code keeps the document's bitmap text voice but flips foreground and background; block code adds `Maple Mono NF CN` to make the technical zone feel more tool-like and terminal-adjacent.
- **Anchor Signal Yellow (`#ffff00`)**: Used only for `:target` highlighting. It behaves like a utilitarian marker pen, calling attention to a navigated fragment without becoming a persistent brand accent.

Dark appearance is not a separately designed palette. It is produced through full-page inversion. This gives the system a pragmatic, old-school hacker quality: the same document is flipped rather than cosmetically re-skinned. Images are inverted by default in dark mode and may opt out where needed.

## 3. Typography Rules

The default type voice is `WenQuanYi Bitmap Song`, mapped across `12px`, `14px`, and `16px` bitmap cuts. This choice is not decorative nostalgia. It gives the site a document-like low-resolution texture that feels deliberate rather than retro for its own sake. `Maple Mono NF CN` remains present, but only for block-level code where a more explicit tool register is useful.

Body copy uses a relaxed but still disciplined rhythm: `16px` type at `1.8` line height. This is a deliberate shift away from terminal density toward sustained reading comfort, especially for Chinese and mixed-language long-form text. The typography should feel calm and durable rather than airy, luxurious, or editorial.

Headings are explicit but restrained. They share a regular weight, a tight line-height envelope, and a scale built from bitmap-safe sizes rather than arbitrary interpolation. `h1` uses the `16px` bitmap face at `2rem`; `h2` uses the `14px` face at `1.75rem`; `h3` and `h4` use the `12px` face at `1.5rem`; `h5` and `h6` return to the `16px` body register. Hierarchy comes from this safe scaling plus vertical spacing, not from glossy display typography or exaggerated weight.

Paragraphs maintain consistent separation (`1.25rem`). Lists preserve the same vertical rhythm while using modest indentation (`1.5rem`), slightly looser block spacing (`1.15rem`), and a measured item cadence (`0.5rem`). Inline code shares the same bitmap type family as the body and is slightly reduced in size so it reads as part of the document instead of as a second font system. Block code switches to `Maple Mono NF CN` at a matched visual size to create a clearer technical boundary.

The system allows a very small number of supporting text roles. A **Lead** paragraph may appear for home-page descriptions or the opening paragraph after an article title; it keeps the same bitmap family and size as body copy, but inherits the looser reading rhythm. **Small** text is reserved for compact metadata or support copy and moves to the `14px` bitmap cut. **Muted** text lowers emphasis through tone rather than through a different typeface or decorative treatment.

The typographic system is intentionally tokenized. Body text, supporting text, headings, emphasis, and code blocks should all route through a small shared interface rather than through ad hoc font declarations or browser defaults. New text elements should inherit one of these established roles instead of introducing a fresh type treatment.

The typographic system should remain plain. Avoid expressive display fonts, dramatic tracking, oversized hero headlines, or editorial flourishes. Hierarchy should come from semantics, order, and spacing.

## 4. Component Stylings

* **Buttons:** There are no native button patterns in the visual language. Interactive emphasis should default to text links rather than filled controls. If a future button is required, it should stay square, monochrome, and text-led rather than product-like.
* **Cards/Containers:** The system intentionally avoids card metaphors. The primary container is a single reading column with no shadow, no tint shift, and no rounded corners. Content blocks are differentiated by semantic structure, not by panels.
* **Inputs/Forms:** There is no elaborate form styling in the current template. Any future form elements should inherit the same plain, squared, black-on-white document language and attach to the shared text system rather than to browser-default UI fonts.
* **Links and Navigation:** Links are treated as ordinary textual affordances within the document flow. Navigation should feel like a curated list of references, not like an app menu bar.
* **Article Metadata:** Dates are understated, aligned to the right, and treated as small muted support text rather than as a decorative badge.
* **Blockquotes:** Quotes are enclosed by a firm `2px` black border with internal padding (`1rem`) and italic text. They read like annotated excerpts pulled into the page margin, but remain fully square and flat.
* **Code Blocks:** Code appears as reversed monochrome: white text on black. Inline code stays inside the body bitmap voice; only block-level code switches to `Maple Mono NF CN`. Blocks have internal padding (`1rem`) and wrap safely for narrow screens, preserving readability over strict terminal emulation.
* **Tables:** Tables use firm `2px` black borders with collapsed strokes. Body cells share the same reading system as paragraphs, while table headers rely on explicit emphasis rules rather than browser-default bold styling. The result should feel utilitarian, closer to a reference sheet than to a data dashboard.
* **Horizontal Rules:** Dividers are ornamental in a minimal ASCII-like way, built from forward slashes rather than graphic lines. This detail quietly reinforces the hacker-text sensibility.
* **Images:** Images are centered, responsive, and secondary to text. They should not define the layout or overpower the document rhythm.

## 5. Layout Principles

The layout is a single centered reading column capped at `640px`. This narrow measure is essential. It keeps the page in the register of a personal note system or long-form technical journal rather than a magazine spread or modern app shell.

Page padding is generous at the outer frame (`4rem` top and bottom, `2rem` left and right). This creates breathing room around an otherwise austere system and prevents the experience from feeling cramped or accidentally primitive.

Whitespace is applied selectively and purposefully. The system is not spacious in a luxurious sense; it is spacious where reading needs pause. Headings, paragraphs, lists, quotes, and code blocks should all keep a clear vertical rhythm without introducing decorative separation devices.

The home page should read like a structured document, not a landing page. Title, short description, intro copy, navigation, and recent posts stack in a calm linear order. Archive and article pages should keep the same single-column discipline.

When extending this system, prefer semantic HTML first and CSS second. Any new styling should earn its place by improving legibility, orientation, or content structure. If a design decision makes the site feel more branded, more polished, or more application-like, it is probably moving away from the intended language.
