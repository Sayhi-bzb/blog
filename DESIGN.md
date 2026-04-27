# Design System: Personal Blog Template
**Project ID:** Local Jekyll template derived from `no-style-please`

## 1. Visual Theme & Atmosphere

This design system is built around a deliberately restrained form of late-20th-century hacker minimalism. It should feel closer to a personal text file, a terminal-adjacent notebook, or an early hand-authored web page than to a branded product interface. The mood is plainspoken, quiet, anti-decorative, and slightly austere without becoming hostile.

The governing principle is not "unstyled" in the careless sense. It is "nearly no CSS" as an editorial stance. Styling exists only where it materially improves reading, hierarchy, or content clarity. The interface should never appear polished for its own sake. It should appear useful, calm, and intentionally underdesigned.

This system should avoid modern SaaS cues. No soft cards, no lush gradients, no ornamental iconography, no glossy component polish. Visual identity comes from discipline: semantic HTML, square edges, monochrome contrast, and strong reading rhythm.

At the same time, the experience should respect modern reading habits. The page is intentionally narrow, breathing room is generous, paragraphs are separated clearly, and headings open up the vertical rhythm. The result is retro in tone but contemporary in comfort.

## 2. Color Palette & Roles

- **Paper White (`#ffffff`)**: The default page field. Used as the uninterrupted background for both `html` and `body`, creating a bright document-like surface.
- **Terminal Black (`#000000`)**: The primary foreground color. Used for body text, borders, horizontal rule ornamentation, table strokes, and the visual skeleton of the interface.
- **Reversed Ink White (`#ffffff`) on Terminal Black (`#000000`)**: Used for inline code and code blocks. This is the only strong inversion in the light theme, giving code a tool-like, command-line presence.
- **Anchor Signal Yellow (`#ffff00`)**: Used only for `:target` highlighting. It behaves like a utilitarian marker pen, calling attention to a navigated fragment without becoming a persistent brand accent.

Dark appearance is not a separately designed palette. It is produced through full-page inversion. This gives the system a pragmatic, old-school hacker quality: the same document is flipped rather than cosmetically re-skinned. Images are inverted by default in dark mode and may opt out where needed.

## 3. Typography Rules

The default type voice is `Maple Mono NF CN`, falling back to a generic monospace family. This choice is not decorative nostalgia. It establishes the site's technical, text-first character and keeps every page inside the same restrained register while remaining comfortable for modern Chinese and mixed-language reading.

Body copy uses a compact but readable rhythm: `16px` type at `1.55` line height. This is a deliberate compromise between terminal severity and long-form readability. The typography should feel efficient, never airy or luxurious, but it must still support extended reading without fatigue.

Headings are explicit but restrained. They share a firm weight and a tight line height (`1.2`), and step down in a compact scale rather than a dramatic editorial scale. `h1` is the only strongly prominent headline at `2rem`. `h2` to `h4` form the practical reading hierarchy for essays and notes, with generous top spacing to create pause without ornamental devices. `h5` and `h6` remain available but intentionally low-drama.

Paragraphs maintain consistent separation (`1rem`). Lists preserve the same vertical rhythm while using modest indentation (`1.5rem`) and a tight but legible item cadence (`0.4rem`). Inline code shares the same type family as the body so the document remains typographically coherent even when switching into technical notation.

The system allows a very small number of supporting text roles. A **Lead** paragraph may appear for home-page descriptions or the opening paragraph after an article title; it should feel slightly larger and more breathable than body copy, not promotional. **Small** text is reserved for compact metadata or support copy. **Muted** text lowers emphasis through tone rather than through a different typeface or decorative treatment.

The typographic system should remain plain. Avoid expressive display fonts, dramatic tracking, oversized hero headlines, or editorial flourishes. Hierarchy should come from semantics, order, and spacing.

## 4. Component Stylings

* **Buttons:** There are no native button patterns in the visual language. Interactive emphasis should default to text links rather than filled controls. If a future button is required, it should stay square, monochrome, and text-led rather than product-like.
* **Cards/Containers:** The system intentionally avoids card metaphors. The primary container is a single reading column with no shadow, no tint shift, and no rounded corners. Content blocks are differentiated by semantic structure, not by panels.
* **Inputs/Forms:** There is no established form styling in the current template. Any future form elements should inherit the same plain, squared, black-on-white document language.
* **Links and Navigation:** Links are treated as ordinary textual affordances within the document flow. Navigation should feel like a curated list of references, not like an app menu bar.
* **Article Metadata:** Dates are understated, aligned to the right, and treated as small muted support text rather than as a decorative badge.
* **Blockquotes:** Quotes are enclosed by a firm `2px` black border with internal padding (`1rem`) and italic text. They read like annotated excerpts pulled into the page margin, but remain fully square and flat.
* **Code Blocks:** Code appears as reversed monochrome: white text on black. Blocks have internal padding (`1rem`) and wrap safely for narrow screens, preserving readability over strict terminal emulation.
* **Tables:** Tables use firm `2px` black borders with collapsed strokes. They should feel utilitarian, closer to a reference sheet than to a data dashboard.
* **Horizontal Rules:** Dividers are ornamental in a minimal ASCII-like way, built from forward slashes rather than graphic lines. This detail quietly reinforces the hacker-text sensibility.
* **Images:** Images are centered, responsive, and secondary to text. They should not define the layout or overpower the document rhythm.

## 5. Layout Principles

The layout is a single centered reading column capped at `640px`. This narrow measure is essential. It keeps the page in the register of a personal note system or long-form technical journal rather than a magazine spread or modern app shell.

Page padding is generous at the outer frame (`4rem` top and bottom, `2rem` left and right). This creates breathing room around an otherwise austere system and prevents the experience from feeling cramped or accidentally primitive.

Whitespace is applied selectively and purposefully. The system is not spacious in a luxurious sense; it is spacious where reading needs pause. Headings, paragraphs, lists, quotes, and code blocks should all keep a clear vertical rhythm without introducing decorative separation devices.

The home page should read like a structured document, not a landing page. Title, short description, intro copy, navigation, and recent posts stack in a calm linear order. Archive and article pages should keep the same single-column discipline.

When extending this system, prefer semantic HTML first and CSS second. Any new styling should earn its place by improving legibility, orientation, or content structure. If a design decision makes the site feel more branded, more polished, or more application-like, it is probably moving away from the intended language.
