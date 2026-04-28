---
title: 文章标题
date: 2026-04-28 10:00:00 +0800
slug: article-slug
tags:
  - note
katex: false
draft: false
---

# 文章标题

开头先写清楚这篇文章要解决什么问题，或者记录什么判断。

## 第一节

这里写正文。保持段落短一点，每段只表达一个意思。

> 当前没有专门的 callout 组件。需要提示块时，先用这种引用写法。

## 代码或命令

行内代码适合写短命令，比如 `bundle exec jekyll build`。

```bash
bundle exec jekyll build
bundle exec jekyll serve
```

## 图片

普通 Markdown 图片：

```md
![图片说明](./image.png)
```

Obsidian 图片嵌入：

```md
![[image.png]]
```

导入脚本会把本地图片复制到 `assets/images/posts/<slug>/`，并改写文章里的图片路径。

## 分割线

---

分割线会复用站点里的 `hr` 样式，渲染成 `/////` 风格。

## 脚注

这里有一个脚注引用[^1]。

[^1]: 这里是脚注内容。
