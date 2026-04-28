---
name: blog-md-publisher
description: Publish user-provided Markdown files into this repository's Jekyll blog using the existing scripts/import_post.rb pipeline. Use when the user gives an .md file, Obsidian note, Notion-exported Markdown, or asks an agent to turn Markdown into a blog post without rewriting the article.
---

# Blog Markdown Publisher

## Core Rule

Preserve the user's article. Do not rewrite prose, restructure sections, add commentary, or improve wording unless the user explicitly asks for editing. This skill is for publishing Markdown through the blog import pipeline, not for content rewriting.

## Workflow

1. Confirm the repository root is `D:\codes\blog\blog` or locate the root that contains `scripts/import_post.rb`, `_config.yml`, and `_posts/`.
2. Confirm the source file is a readable `.md` file. If the user provided content instead of a path, ask for a file path or create no files unless explicitly told to.
3. Run a dry run first:

   ```bash
   ruby scripts/import_post.rb path/to/article.md --dry-run
   ```

4. If dry-run reports `Import failed validation`, stop and report the errors. Do not manually bypass the script.
5. If dry-run reports warnings, summarize them for the user. Obsidian internal links becoming plain text are acceptable warnings unless the user wants link preservation.
6. Publish only after dry-run succeeds:

   ```bash
   ruby scripts/import_post.rb path/to/article.md
   ```

7. Report the generated post path, build result, and any warnings. If the script rolls back after a build failure, state that no post was published.

## Script Contract

Use the repository script as the source of truth. It handles:

- Jekyll front matter generation.
- Missing title/date/slug fallbacks.
- Local image copying into `assets/images/posts/<slug>/`.
- Obsidian image embeds like `![[image.png]]`.
- Obsidian internal-link degradation to plain text.
- YAML/date/slug/image validation.
- `bundle exec jekyll build`.
- Rollback of files written during a failed import.

Use `--force` only when the user explicitly wants to overwrite an existing post. Use `--no-build` only for debugging or when the user explicitly asks to skip rendering.

## Failure Handling

- Validation errors are blockers.
- Build failures are blockers.
- Warnings are not blockers, but must be visible in the final response.
- Do not hand-edit `_posts` to work around the importer unless the user explicitly asks for manual intervention after seeing the failure.
