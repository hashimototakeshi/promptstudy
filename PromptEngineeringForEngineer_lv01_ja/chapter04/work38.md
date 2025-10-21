---
seq: 43
title: 設計書作成 
slug: chapter04/work38
description: AIを活用した効率的な設計書作成のテクニックを学ぶ
type: exercise
relation: chapter04_for_Engineers/index,chapter04_for_Engineers/work1
difficulty: 3
displayLanguage: ja
duration: 30
---
# 設計書作成

## 練習問題
:::exercise

**【シチュエーション】**

高橋さんはAIが作成した設計書の草案をチームリーダーに見せたところ、「良い出発点だね。ただ、どの翻訳APIを使ったのか記録しておかないと、将来的に別のAPIを追加した時に分析できないよ。あと、APIは文字数で課金されるから、コスト管理のために翻訳した文字数も記録しておこう」というフィードバックをもらいました。

さあ、AIへの指示を修正して、**このフィードバックを反映したデータベーステーブル設計**を再度作成させてみましょう。
:::

:::hint
AIとの対話は一回で終わりではありません。第2章で学んだように、**最初の出力に対して追加の要件や修正点を具体的にフィードバックする** ことで、設計をより洗練させることができます。「先ほどのテーブル設計に、〇〇と△△のカラムを追加して」のように、変更点を明確に指示するのがコツです。
:::

<details>
<summary>練習問題 プロンプト例</summary>

```markdown
あなたは、先ほど「リアルタイム翻訳機能」の設計を行ったソフトウェアアーキテクトです。
先ほどの`translation_logs`テーブルの設計に、以下の2つの要件を追加で反映させて、更新版のテーブル設計をMarkdown形式で作成してください。

# 追加要件
1.  **使用した翻訳サービスを記録する**: 将来的に複数の翻訳APIを使い分ける可能性を考慮し、どのサービス（例: 'DeepL', 'Google'）を利用したかを保存するカラムを追加してください。
2.  **翻訳文字数を記録する**: コスト管理のため、翻訳した原文の文字数を保存するカラムを追加してください。
```

### AI回答出力例

（AIによる回答のイメージ）

```markdown

承知いたしました。フィードバックを反映し、`translation_logs`テーブルの設計を更新します。

**テーブル名: `translation_logs` (v2)**

| カラム名            | データ型         | 制約                  | 説明                                   |
| ------------------- | ---------------- | --------------------- | -------------------------------------- |
| `id`                | `BIGINT`         | `PRIMARY KEY`, `AUTO_INCREMENT` | ログの一意なID                         |
| `user_id`           | `BIGINT`         | `NOT NULL`, `FOREIGN KEY`       | 翻訳機能を利用したユーザーのID         |
| `original_text`     | `TEXT`           | `NOT NULL`            | 翻訳元のテキスト                       |
| `translated_text`   | `TEXT`           | `NOT NULL`            | 翻訳後のテキスト                       |
| `source_language`   | `VARCHAR(10)`    | `NOT NULL`            | 翻訳元の言語コード（例: `JA`）         |
| `target_language`   | `VARCHAR(10)`    | `NOT NULL`            | 翻訳先の言語コード（例: `EN`）         |
| `service_provider`  | `VARCHAR(50)`    | `NOT NULL`            | 利用した翻訳サービス名（例: `DeepL`）  |
| `character_count`   | `INT`            | `NOT NULL`            | 翻訳した原文の文字数                   |
| `created_at`        | `TIMESTAMP`      | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | ログの作成日時                         |

```

</details>

