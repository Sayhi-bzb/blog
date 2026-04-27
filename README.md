# Personal Blog Template

一个极简、可长期维护的 Jekyll 个人博客模板。仓库默认只保留最基础的博客结构：首页、文章页、静态页、归档页，以及一条足够轻的构建链路。

## 特性

- 保留极简视觉，不再混入上游主题的演示内容
- 首页默认展示个人简介、导航和最近文章
- 文章默认使用 `post` 布局，不需要每篇手写 `layout`
- 内置 `jekyll-feed` 和 `jekyll-seo-tag`
- `GoatCounter` 和 KaTeX 样式按配置开启，默认关闭
- GitHub Actions 只做构建校验，不绑定特定部署平台

## 目录结构

- `_config.yml`：站点主配置
- `_layouts/`：`home`、`page`、`post`、`archive` 页面骨架
- `_includes/`：头部、返回首页、菜单、文章列表等复用片段
- `_data/menu.yml`：首页导航
- `_posts/`：文章内容
- `index.md`、`about.md`、`archive.md`：站点级页面

## 开始使用

1. 安装 Ruby 和 Bundler。
2. 执行 `bundle install` 安装依赖。
3. 执行 `bundle exec jekyll serve` 启动本地预览。
4. 打开 `http://127.0.0.1:4000` 查看站点。

第一次接手这个模板时，通常只需要改这几处：

- `_config.yml` 里的站点标题、作者、网址、简介
- `_data/menu.yml` 里的导航链接
- `about.md` 里的自我介绍
- `_posts/` 里的占位文章

## 写作约定

- 新文章放在 `_posts/` 下，文件名使用 `YYYY-MM-DD-slug.md`
- 文章默认继承 `post` 布局，只需要写标题和正文
- 首页最近文章数量由 `_config.yml` 中的 `theme_config.home_post_limit` 控制
- 如果需要 KaTeX 样式，可以在 `_config.yml` 中把 `katex` 设为 `true`，或者只在单页 front matter 里写 `katex: true`

## 部署

默认构建命令：

```bash
bundle exec jekyll build
```

构建产物输出到 `_site/`。你可以把它发布到 GitHub Pages、自托管静态服务器，或任何接受静态目录输出的平台。仓库里的 [`.github/workflows/jekyll.yml`](.github/workflows/jekyll.yml) 只负责 CI 构建检查。

## GitNexus

给当前仓库建立或刷新 GitNexus 索引：

```bash
npx gitnexus analyze .
```

索引数据会写到本地 `.gitnexus/`，该目录已加入 `.gitignore`。

## Credits

这个模板基于 `riggraz/no-style-please` 的极简布局思路收敛而来，但仓库结构已经调整为面向个人博客长期使用的站点模板。

## License

[MIT](LICENSE.txt)

