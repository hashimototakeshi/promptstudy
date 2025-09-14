---
seq: 30
title: 新たなクレームに高度なプロンプト戦略で挑む
slug: chapter05/work13
description: AIの「個性」に合わせた指示を出すことでさらなる能力を引き出すことができます
type: column
relation: chapter05/index,chapter05/work10,chapter05/work11
difficulty: 4
displayLanguage: ja
duration: 45
---


# 【コラム】特定のAIを"得意"にさせるプロンプト術

第1章でAIにも「個性」があると学びましたが、その個性に合わせた指示を出すことで、さらに能力を引き出すことができます。
wAnthropic社のClaudeは自然言語のプロンプトを受けることもできますが、プロンプトを**XMLタグ**で構造化することを公式に推奨しています。ClaudeはHTMLやXMLのような構造化文書を大量に学習しているため、指示と参照テキストなどをタグで明確に区別すると、文脈をより正確に理解し、精度が向上する傾向があります。

**▼ 従来の書き方**

```markdown
以下の記事を要約してください。
記事：[ここに長い記事のテキスト]
要約は3つの箇条書きでお願いします。
```

**▼ Claudeが好む書き方（XMLタグ活用）**

```xml
<document>
[ここに長い記事のテキスト]
</document>

<instructions>
上記の<document>の内容を、3つの箇条書きで要約してください。
</instructions>
```

このように、モデルの特性を理解しプロンプトを最適化することも、重要なテクニックの一つです。