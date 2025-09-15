---
seq: 48
title: エラーの原因特定と対策提案
slug: chapter04/work35
description: これまでに学んだ技術調査、設計書作成、ログ解析のスキルを総動員した実践的な課題に取り組む
type: practice
relation: chapter04_for_Engineers/index,chapter04_for_Engineers/work3
difficulty: 3
displayLanguage: ja
duration: 15
---

### 【実践課題】AIと共に進める新機能開発

:::exercise
## 課題3 ログ解析
前回の続きの課題となります。
設計に基づき簡単なテストコードを動かしたところ、API連携部分で以下のエラーログが出力されました。

**▼ 出力されたエラーログ**
```json
{
  "error": {
    "code": 401,
    "message": "Request had invalid authentication credentials. Expected OAuth 2 access token, login cookie or other valid authentication credential. See [https://developers.google.com/identity/sign-in/web/devconsole-project](https://developers.google.com/identity/sign-in/web/devconsole-project).",
    "status": "UNAUTHENTICATED"
  }
}
```

**【あなたのタスク】**
このエラーログの原因を特定し、考えられる対策をAIに提案させるプロンプトを作成してください。
:::

:::Hint
AIは、関連性の高い背景情報（コンテキスト）を具体的に与えるほど、精度の高い推論を行います。ワーク3で学んだように、「このエラーメッセージは何？」と聞くだけでなく、**「どのAPIを呼び出した際に」「どんな状況で」**このエラーが出たのか、という**コンテキスト（背景情報）**を具体的に与えることが、的を射た回答を引き出すための鍵となります。今回は、エラーログに加えて「Google Cloud Vision APIを呼び出した際に発生した」という情報を添えてみましょう。
:::

<details>
<summary>▼課題3 プロンプト例</summary>

```markdown
あなたは、クラウドAPI連携のトラブルシューティングを専門とするエンジニアです。
以下のエラーログについて、原因と解決策を分析してください。

# コンテキスト
- Google Cloud Vision API を呼び出した際に、このエラーレスポンスが返ってきました。

# エラーログ
{
  "error": {
    "code": 401,
    "message": "Request had invalid authentication credentials. Expected OAuth 2 access token, login cookie or other valid authentication credential. See https://developers.google.com/identity/sign-in/web/devconsole-project.",
    "status": "UNAUTHENTICATED"
  }
}
# 指示
このエラーの原因として考えられることを、箇条書きで複数挙げてください。また、それぞれの原因に対する具体的な解決策も提示してください。
```

</details>

