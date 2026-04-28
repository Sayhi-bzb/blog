---
title: 文章标题
date: 2026-04-28 10:00:00 +0800
lang: zh-CN
slug: article-slug
translation_key: article-slug
tags:
  - note
katex: false
draft: false
---

# 文章标题

开头先写清楚这篇文章要解决什么问题，或者记录什么判断。

## 第一节

这里写正文。保持段落短一点，每段只表达一个意思。

<div class="callout" data-title="提示" markdown="1">
需要强调的提示、结论或发布前检查，可以写在 callout 里。
</div>

## 代码或命令

行内代码适合写短命令，比如 `bundle exec jekyll build`。

```bash
bundle exec jekyll build
bundle exec jekyll serve
```

## 分栏和 Note

<aside class="note" markdown="1">
Note 适合放短提醒。桌面端靠右对齐，窄屏下回到正文宽度。
</aside>

<div class="columns" markdown="1">
<div markdown="1">
左栏内容。
</div>

<div markdown="1">
右栏内容。
</div>
</div>

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
