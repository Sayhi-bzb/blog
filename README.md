# Blog

This is the source code for my personal blog.

The site is built with Jekyll and keeps a small, text-first structure for notes,
posts, and static pages.

## Development

Install dependencies:

```bash
bundle install
```

Run the local server:

```bash
bundle exec jekyll serve
```

Build the site:

```bash
bundle exec jekyll build
```

## Writing

Posts live in `_posts/`.

There is also a local import helper for Markdown drafts:

```bash
ruby scripts/import_post.rb path/to/article.md
```

## Credits

Most of the code is based on
[riggraz/no-style-please](https://github.com/riggraz/no-style-please).

## License

MIT. See [LICENSE.txt](LICENSE.txt).
