---
seq: 45
title: ログ解析・デバッグ支援
slug: chapter04/work40
description: AIを活用した効率的なログ解析とデバッグのテクニックを学ぶ
type: work
relation: chapter04/index,chapter04/work2
difficulty: 3
displayLanguage: ja
duration: 30
---

# ログ解析・デバッグ支援

## サンプル課題
:::sample-quiz

システムの設計・実装を進める高橋さん。テスト中に、どうやら実装中のシステムで予期せぬエラーが発生していることに気づきました。

**高橋さんのお悩み:**
> 「実装中のシステムでエラーが発生した！開発環境のログは何千行もあって、どこから見ればいいか分からない。この大量のログの中から、エラーの原因を素早く特定して、すぐに対処法を見つけ出したいんだけど、時間がかかりそうだ…。」

このように大量の非構造化データ（ログ）から特定の情報を探し出し、原因を推測するタスクも生成AIの得意分野です。AIを使って高橋さんのデバッグ作業を支援しましょう。
:::

## 解説

### AIはログ解析の「高速アナリスト」

インプットするトークン数の上限はモデルによって異なりますが、大量のテキストデータの中からパターンを見つけ出し、文脈を理解するのが得意です。もちろん、エラーログの解析においても効果を発揮します。

* **原因の迅速な特定**: エラーメッセージとスタックトレースをAIに与えることで、エラーの直接的な原因となっているコードの箇所や、その理由を瞬時に特定させることができます。
* **解決策の提案**: エラーの原因に基づき、考えられる修正コードの案や、関連する技術ドキュメントへのリンクを提示させることができます。
* **傾向分析**: 大量のログをまとめて分析させ、特定のエラーがどのくらいの頻度で、どのような状況で発生しているのかを要約させ、問題の全体像を把握するのに役立ちます。

成功の鍵は、AIに**エラーログの断片**だけでなく、**「どんなアプリケーションで」「何をしている時に」**発生したエラーなのか、といった**周辺のコンテキスト（背景情報）**を可能な限り与えることです。

:::point
### ログをAIに渡す際の注意点
エラーログには、個人情報やIPアドレス、APIキーといった機密情報が含まれている可能性があります。特に本番環境のログを扱う際は細心の注意が必要ですが、実装環境のログであっても、AIに渡す前に必ずマスキング（`XXX`などで置き換え）や削除を行う習慣をつけましょう。機密情報の漏洩は、重大なセキュリティインシデントに繋がります。
:::

:::warning
AIが提案する解決策は、あくまで学習したデータの一般的なベストプラクティスに基づいたものであり、あなたのシステムの事情を完全に理解しているわけではありません。提案されたコードを鵜呑みにせず、必ず内容を理解・検証した上で、自己の責任において適用してください。
:::


高橋さんが遭遇したエラーログは以下の通りです。

**▼ 実装環境のエラーログ**

```
ERROR 2025-07-30 22:10:01 [http-nio-8080-exec-5] c.g.s.controller.UserController - Failed to get user profile
java.lang.NullPointerException: Cannot invoke "com.growthtech.saas.entity.User.getName()" because "user" is null
    at com.growthtech.saas.service.UserService.getUserProfile(UserService.java:45)
    at com.growthtech.saas.controller.UserController.getProfile(UserController.java:30)
    ... 15 more
```
このログをAIに分析させるためのプロンプト例と、それに対するAIの回答例を見てみましょう。

## サンプルプロンプト

```
あなたは、JavaによるWebアプリケーション開発の経験が20年以上ある、伝説的なトラブルシューターです。
以下の実装環境のサーバーログに出力されたエラーの原因を特定し、具体的な修正案を提示してください。

# エラーログ
ERROR 2025-07-30 22:10:01 [http-nio-8080-exec-5] c.g.s.controller.UserController - Failed to get user profile
java.lang.NullPointerException: Cannot invoke "com.growthtech.saas.entity.User.getName()" because "user" is null
    at com.growthtech.saas.service.UserService.getUserProfile(UserService.java:45)
    at com.growthtech.saas.controller.UserController.getProfile(UserController.java:30)
    ... 15 more
```

**▼ AIによる出力例**

```markdown 

承知いたしました。このエラーは、Java開発者にとって馴染み深い「NullPointerException」、通称「ヌルポ」です。ログを分析し、原因と対策を解説します。

### エラーの原因
スタックトレースの以下の行が原因を特定する上で最も重要です。
`java.lang.NullPointerException: Cannot invoke "com.growthtech.saas.entity.User.getName()" because "user" is null at com.growthtech.saas.service.UserService.getUserProfile(UserService.java:45)`

これは、`UserService.java`の45行目で、`user`という変数が`null`（つまり、空っぽの状態）にもかかわらず、その`user`の`getName()`メソッドを呼び出そうとしたために発生しています。存在しないものから名前を取ろうとして、エラーになっているわけです。

### 具体的な修正案
`UserService.java`の45行目付近を、以下のように修正することを推奨します。`getName()`を呼び出す前に、`user`オブジェクトが`null`でないことを確認する、いわゆる「nullチェック」を追加します。

**修正前:**

// UserService.java:45
String userName = user.getName();

**修正後:**

// UserService.java:45
String userName = "Default Name"; // デフォルト値を設定
if (user != null) {
    userName = user.getName();
}
// この後、userName変数を使って処理を続ける


もしくは、そもそもなぜ`user`が`null`になるのか、その前の処理（例: データベースからのユーザー取得処理）を見直すことが、より根本的な解決に繋がります。
```


