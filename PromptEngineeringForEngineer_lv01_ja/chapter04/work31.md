---
seq: 44
title: ログ解析・デバッグ支援
slug: chapter04/work31
description: AIを活用した効率的なログ解析とデバッグのテクニックを学ぶ
type: work
relation: chapter04_for_Engineers/index,chapter04_for_Engineers/work2
difficulty: 3
displayLanguage: ja
duration: 30
---
# ログ解析・デバッグ支援
:::exercise
## 練習問題

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
:::

:::hint
AIは、ログ全体からエラーのパターンを読み取り、それぞれの根本原因を推測するのが得意です。プロンプトでは、単にエラーを数えさせるだけでなく、「このエラーは何を意味するのか」「考えられる原因は何か」といった、一歩踏み込んだ分析をさせるのが現実的な使い方です。
:::

<details>
<summary>練習問題1プロンプト例</summary>

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

</summary>

