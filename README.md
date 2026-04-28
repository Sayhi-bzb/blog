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
- 用 `writing/blog-post-template.md` 或自己的 Markdown 文件开始写文章

## 写作约定

- 新文章放在 `_posts/` 下，文件名使用 `YYYY-MM-DD-slug.md`
- 文章默认继承 `post` 布局，只需要写标题和正文
- 首页最近文章数量由 `_config.yml` 中的 `theme_config.home_post_limit` 控制
- 如果需要 KaTeX 样式，可以在 `_config.yml` 中把 `katex` 设为 `true`，或者只在单页 front matter 里写 `katex: true`

## 自动导入文章

如果你在 Obsidian 或 Notion 里写文章，可以先复制 `writing/blog-post-template.md` 作为写作模板。写完后用导入脚本生成 Jekyll 文章：

```bash
ruby scripts/import_post.rb path/to/article.md
```

脚本会：

- 读取 `title`、`date`、`slug`、`tags`、`katex` 等 front matter
- 缺少标题时从第一个 `# 一级标题` 或文件名推导
- 缺少日期时使用当前时间
- 缺少 slug 时从标题或文件名推导
- 输出到 `_posts/YYYY-MM-DD-slug.md`
- 将本地图片复制到 `assets/images/posts/<slug>/`
- 将 Obsidian 图片 `![[image.png]]` 改写成普通 Markdown 图片
- 将 Obsidian 内链 `[[Note]]` 或 `[[Note|Alias]]` 转成纯文本并输出 warning
- 导入前校验 YAML、日期、slug 和本地图片路径
- 构建失败时自动回滚本次写入的文章和图片
- 默认执行 `bundle exec jekyll build`

导入脚本把问题分成两类：

- error：会阻止导入，例如 YAML 错误、日期错误、slug 不安全、本地图片缺失
- warning：只提示不阻止，例如 Obsidian 内链会降级成纯文本

常用选项：

```bash
ruby scripts/import_post.rb path/to/article.md --dry-run
ruby scripts/import_post.rb path/to/article.md --no-build
ruby scripts/import_post.rb path/to/article.md --force
```

## 写作格式速查

### 页面组件

- 首页：站点标题、简介、导航、最近文章、全站 footer
- 文章页：返回首页、日期、标题、正文、全站 footer
- 静态页：返回首页、标题、正文、全站 footer
- 归档页：返回首页、标题、文章列表、全站 footer

### Markdown 写法

标题：

```md
# 一级标题
## 二级标题
### 三级标题
```

段落、链接、加粗、行内代码：

```md
这是一段正文。

[链接文字](https://example.com)

**重点文字**

运行 `bundle exec jekyll build`。
```

列表：

```md
- 第一项
- 第二项

1. 第一步
2. 第二步
```

代码块：

````md
```bash
bundle exec jekyll build
bundle exec jekyll serve
```
````

引用：

```md
> 这里是一段引用。
```

分割线：

```md
---
```

分割线会复用站点里的 `hr` 样式，渲染成 `/////` 风格的文本分隔。

表格：

```md
| 场景 | 动作 |
| --- | --- |
| 写草稿 | 先记录 |
| 写教程 | 给出步骤 |
```

图片：

```md
![图片说明](/assets/images/example.png)
```

脚注：

```md
这里有一个脚注引用[^1]。

[^1]: 这里是脚注内容。
```

HTML 上标：

```md
术语<sup>[A]</sup>
```

KaTeX：

```yaml
---
title: 带公式的文章
katex: true
---
```

KaTeX 默认关闭。需要全站开启时改 `_config.yml`，只在单篇文章开启时写在 front matter 里。

当前没有专门的 `callout` 组件。需要提示块时先使用 Markdown 引用 `>`；如果以后要新增 callout，再单独设计对应样式。

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

