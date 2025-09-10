# ワーク3: ログ解析・デバッグ支援

## サンプル課題

システムの設計・実装を進めるソフトウェアエンジニアの高橋さん。テスト中に、どうやら実装中のシステムで予期せぬエラーが発生していることに気づきました。

> **高橋さんのお悩み:**
> 「実装中のシステムでエラーが発生した！開発環境のログは何千行もあって、どこから見ればいいか分からない。この大量のログの中から、エラーの原因を素早く特定して、すぐに対処法を見つけ出したいんだけど、時間がかかりそうだ…。」

このような、大量の非構造化データ（ログ）から特定の情報を探し出し、原因を推測するタスクは、AIの強力な言語理解能力が光る場面です。AIを使って、高橋さんのデバッグ作業を支援しましょう。

## 解説

### AIはログ解析の「高速アナリスト」

AI、特にLLMは、大量のテキストデータの中からパターンを見つけ出し、文脈を理解するのが得意です。この能力は、エラーログの解析において絶大な効果を発揮します。

* **原因の迅速な特定**: エラーメッセージとスタックトレースをAIに与えることで、エラーの直接的な原因となっているコードの箇所や、その理由を瞬時に特定させることができます。
* **解決策の提案**: エラーの原因に基づき、考えられる修正コードの案や、関連する技術ドキュメントへのリンクを提示させることができます。
* **傾向分析**: 大量のログをまとめて分析させ、特定のエラーがどのくらいの頻度で、どのような状況で発生しているのかを要約させ、問題の全体像を把握するのに役立ちます。

成功の鍵は、AIに**エラーログの断片**だけでなく、**「どんなアプリケーションで」「何をしている時に」**発生したエラーなのか、といった**周辺のコンテキスト**を可能な限り与えることです。

:::_ Point(ログをAIに渡す際の注意点)
エラーログには、個人情報やIPアドレス、APIキーといった機密情報が含まれている可能性があります。特に本番環境のログを扱う際は細心の注意が必要ですが、実装環境のログであっても、AIに渡す前に必ずマスキング（`XXX`などで置き換え）や削除を行う習慣をつけましょう。機密情報の漏洩は、重大なセキュリティインシデントに繋がります。
:::

#### Warning

AIが提案する解決策は、あくまで一般的なベストプラクティスに基づいたものであり、あなたのシステムの複雑な事情を完全に理解しているわけではありません。提案されたコードを鵜呑みにせず、必ず内容を理解・検証した上で、自己の責任において適用してください。

### サンプル課題解答

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

**▼ プロンプト例**
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
```
承知いたしました。このエラーは、Java開発者にとって馴染み深い「NullPointerException」、通称「ヌルポ」です。ログを分析し、原因と対策を解説します。

### エラーの原因
スタックトレースの以下の行が原因を特定する上で最も重要です。
`java.lang.NullPointerException: Cannot invoke "com.growthtech.saas.entity.User.getName()" because "user" is null at com.growthtech.saas.service.UserService.getUserProfile(UserService.java:45)`

これは、`UserService.java`の45行目で、`user`という変数が`null`（つまり、空っぽの状態）にもかかわらず、その`user`の`getName()`メソッドを呼び出そうとしたために発生しています。存在しないものから名前を取ろうとして、エラーになっているわけです。

### 具体的な修正案
`UserService.java`の45行目付近を、以下のように修正することを推奨します。`getName()`を呼び出す前に、`user`オブジェクトが`null`でないことを確認する、いわゆる「nullチェック」を追加します。

**修正前:**
```java
// UserService.java:45
String userName = user.getName();
```

**修正後:**
```java
// UserService.java:45
String userName = "Default Name"; // デフォルト値を設定
if (user != null) {
    userName = user.getName();
}
// この後、userName変数を使って処理を続ける
```

もしくは、そもそもなぜ`user`が`null`になるのか、その前の処理（例: データベースからのユーザー取得処理）を見直すことが、より根本的な解決に繋がります。
```

---
### 練習問題1
**【シチュエーション】**
高橋さんは、別のアラートに対応しています。今度は、断続的に複数の種類のエラーがログに出力されているようです。彼は、個別のエラーを追う前に、まず**「どのようなエラーが」「どのくらいの頻度で」**発生しているのか、全体像を把握したいと考えています。彼が確認しているログの抜粋は以下の通りです。

**▼ ログ抜粋**
```
INFO: 2025-07-31 10:00:01 - User login successful. userId=123
ERROR: 2025-07-31 10:01:15 - java.sql.SQLException: Connection timed out
INFO: 2025-07-31 10:02:05 - File upload started.
ERROR: 2025-07-31 10:03:20 - java.io.FileNotFoundException: /tmp/uploads/file.txt (No such file or directory)
ERROR: 2025-07-31 10:05:45 - java.sql.SQLException: Connection timed out
INFO: 2025-07-31 10:06:00 - User logout. userId=123
ERROR: 2025-07-31 10:08:10 - java.sql.SQLException: Connection timed out
```
さあ、AIにこの**ログ**を分析させ、**エラーの内容や原因を特定させる**ような、より実践的なプロンプトを作成してみましょう。

### Hint
AIは、ログ全体からエラーのパターンを読み取り、それぞれの根本原因を推測するのが得意です。プロンプトでは、単にエラーを数えさせるだけでなく、「このエラーは何を意味するのか」「考えられる原因は何か」といった、一歩踏み込んだ分析をさせるのが現実的な使い方です。

### 練習問題1プロンプト例
```
あなたは、システムの安定性を監視するSRE（Site Reliability Engineer）です。
以下のログの抜粋から、発生しているエラーを分析してください。

# ログ抜粋
INFO: 2025-07-31 10:00:01 - User login successful. userId=123
ERROR: 2025-07-31 10:01:15 - java.sql.SQLException: Connection timed out
INFO: 2025-07-31 10:02:05 - File upload started.
ERROR: 2025-07-31 10:03:20 - java.io.FileNotFoundException: /tmp/uploads/file.txt (No such file or directory)
ERROR: 2025-07-31 10:05:45 - java.sql.SQLException: Connection timed out
INFO: 2025-07-31 10:06:00 - User logout. userId=123
ERROR: 2025-07-31 10:08:10 - java.sql.SQLException: Connection timed out

# 指示
1.  ログに含まれる2種類のエラーメッセージを特定してください。
2.  それぞれのエラーについて、メッセージから直接的に分かる原因を説明してください。
3.  特に`java.sql.SQLException: Connection timed out`について、システムレベルで考えられる根本的な原因を3つ推測してください。
```

### 練習問題1AI回答出力例
（AIによる回答のイメージ）
```
承知いたしました。ログを分析し、レポートします。

### 1. エラーメッセージの特定
ログからは、以下の2種類のエラーが確認できます。
* `java.sql.SQLException: Connection timed out`
* `java.io.FileNotFoundException: /tmp/uploads/file.txt (No such file or directory)`

### 2. 各エラーの直接的な原因
* **`FileNotFoundException`**: 指定されたパス `/tmp/uploads/file.txt` にファイルが存在しないため、読み込みまたは書き込みに失敗しています。
* **`SQLException: Connection timed out`**: アプリケーションがデータベースに接続しようとした際、一定時間内に応答がなかったことを示します。

### 3. `Connection timed out`の根本原因の推測
このエラーの根本的な原因としては、以下のようなシステムレベルの問題が考えられます。
1.  **データベースサーバーの高負荷**: 多数のクエリが集中するなどしてデータベースの負荷が高まり、新しい接続に応答できなくなっている。
2.  **ネットワークの問題**: アプリケーションサーバーとデータベースサーバー間のネットワーク経路で、遅延やパケットロスが発生している。
3.  **設定の不備**: アプリケーションのデータベース接続プールの設定（最大接続数など）が不適切で、コネクションが枯渇している。
```

---
### 練習問題2
**【シチュエーション】**
高橋さんは、ある特定のエラーについて、ログの情報だけでは原因が特定できずに困っています。テスト中にAPIを呼び出したところ、以下のエラーレスポンスが返ってきました。

**▼ エラーレスポンス**
```json
{
  "timestamp": "2025-07-31T14:30:00.123Z",
  "status": 403,
  "error": "Forbidden",
  "message": "Access Denied"
}
```
なぜアクセスが拒否されたのか、具体的な理由が分かりません。彼は、このAPIが**「社内ネットワークからのみアクセス可能」**で、**「リクエストヘッダーに有効な`X-Auth-Token`を含める必要がある」**という仕様であることを知っています。

さあ、AIにこの**エラーメッセージ**と、高橋さんが知っている**システムの仕様（コンテキスト）**の両方を与えて、**考えられる原因を複数推測させる**プロンプトを作成してみましょう。

### Hint
AIは、関連性の高い背景情報（コンテキスト）を具体的に与えるほど、精度の高い推論を行います。「このエラーメッセージは何？」と聞くだけでなく、「こういう仕様のシステムで、このエラーが出た。原因として何が考えられる？」と、背景情報を加えることが非常に重要です。

### 練習問題2プロンプト例
```
あなたは、API連携に関する問題解決の専門家です。
あるAPIを呼び出した際に、以下のエラーレスポンスが返ってきました。
このエラーの原因として考えられることを、箇条書きで複数挙げてください。

# エラーレスポンス
```json
{
  "timestamp": "2025-07-31T14:30:00.123Z",
  "status": 403,
  "error": "Forbidden",
  "message": "Access Denied"
}
```

# 前提知識（コンテキスト）
* このAPIは、社内ネットワークからのみアクセスが許可されている。
* APIを呼び出す際、HTTPリクエストヘッダーに有効な`X-Auth-Token`を含める必要がある。
```

### 練習問題2AI回答出力例
（AIによる回答のイメージ）
```
承知いたしました。`403 Forbidden`エラーについて、与えられたコンテキストを基に考えられる原因を推測します。

* **原因1: `X-Auth-Token`の不備**
    * リクエストヘッダーに`X-Auth-Token`が含まれていない。
    * `X-Auth-Token`の値が間違っている、または有効期限が切れている。
* **原因2: 不正なアクセス元IPアドレス**
    * APIを呼び出しているサーバーが、許可された社内ネットワークのIPアドレス範囲外にある。例えば、開発環境から誤って本番APIを呼び出しているケースなどが考えられます。
* **原因3: 権限不足**
    * `X-Auth-Token`は有効だが、そのトークンに紐づくユーザーやサービスアカウントが、呼び出そうとしているAPIのエンドポイントに対する実行権限を持っていない。
```

---
お疲れ様でした。これでワーク3は終了です。
次のセクションでは、この章で学んだスキルを試すための実践課題に挑戦しましょう。
