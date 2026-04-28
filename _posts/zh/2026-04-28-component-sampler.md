---
title: 组件测试文章
date: 2026-04-28 10:00:00 +0800
slug: component-sampler
translation_key: component-sampler
tags:
  - test
  - component
katex: false
draft: false
---

这是一篇用来检查博客正文组件的示例文章。它不解决具体问题，只把常用排版放在同一个页面里，方便发布前确认样式没有互相挤压。

<aside class="note" markdown="1">
Note 适合放短提醒、版本信息或旁批。桌面端靠右对齐，窄屏下回到正文宽度。
</aside>

## 博客正文

正文段落应该保持可读的行高和稳定的节奏。这里故意写成几段短文本，用来观察标题、段落、强调和链接之间的距离。

普通行内代码长这样：`bundle exec jekyll build`。强调文字长这样：**重要判断先写清楚**。链接可以指向 [Cloudflare Pages](https://developers.cloudflare.com/pages/)。

列表用于记录步骤：

1. 写 Markdown。
2. 本地构建。
3. 部署到 Cloudflare Pages。

表格用于做小型对照：

| 组件 | 用途 | 状态 |
| --- | --- | --- |
| code | 展示命令和片段 | 已测试 |
| callout | 展示提示和结论 | 已测试 |
| columns | 展示并排内容 | 已测试 |

## Code

代码块需要能换行、保留缩进，并且在窄屏上不撑破页面。

```ruby
def build_blog
  system("bundle exec jekyll build")
  puts "site generated in _site/"
end

build_blog
```

```css
.columns {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}
```

## Callout

<div class="callout" data-title="提示" markdown="1">
这是一个 callout。它比普通引用更像一条明确提示，可以承载结论、注意事项或短小的上下文。
</div>

<div class="callout" data-title="发布前检查" markdown="1">
- 确认 `_config.yml` 的 `url` 指向正式域名。
- 确认 RSS、SEO tag 和 favicon 都能生成。
- 确认移动端没有横向滚动。
</div>

## 分栏

<div class="columns" markdown="1">
<div markdown="1">
### 左栏

左栏可以放背景、条件或输入。这里放一段短说明，检查列宽、标题和段落间距。
</div>

<div markdown="1">
### 右栏

右栏可以放结果、判断或输出。移动端下两栏会自动堆叠，避免文字太窄。
</div>
</div>

## 引用

> 引用块用于摘录、旁白或保留语气的文本。它应该和 callout 有区别，但仍然保持黑白极简风格。

## Note、分割线和脚注

---

脚注用于补充来源、解释或不适合打断正文的细节。这里放一个脚注引用[^component-note]。

[^component-note]: 这篇文章的目的只是测试组件渲染，不代表正式内容结构。
