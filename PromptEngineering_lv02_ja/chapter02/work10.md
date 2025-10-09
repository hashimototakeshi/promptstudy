---
seq: 12
title: ツールの連携による自動化の拡張
slug: chapter02/work10
description: Difyのツール連携機能を活用し、要件定義書を元にした調査と設計書作成の自動化パイプラインを構築する
type: work
difficulty: 3
displayLanguage: ja
duration: 30
relation: chapter02/index,chapter02/work09
---

# ツールの連携による自動化の拡張

先ほどのワークでは、ワークフローの基本構造を学びました。しかし、実際の業務では単にAIに文章を生成させるだけでなく、外部の情報（ファイルやWebサイト）を参照したり、他のツールと連携して出力するなど、外部ツールを併用する業務が多くあります。

このワークでは、ワークフローで自動化できる範囲を広げるために「**ツール連携**」に焦点を当てます。高橋さんの「要件定義書をもとにWebで自動調査して、設計書まで自動で作成してくれるツールがほしい」というお悩みの解決に挑戦していきます。

## Difyのツール連携を理解しよう

Difyのチャットフローやワークフローの真価は、LLMだけでなく、様々な「ツール」をパイプラインに組み込める点にあります。

### ツールとは？

Difyにおける「ツール」とは、特定の機能を持つノードです。これらをマーケットプレイスから追加しパイプラインに組み込むことで、あなたの自動化アプリケーションは単なる文章生成アプリから、多機能な業務システムへと進化します。

マーケットプレイスには、以下のような様々なカテゴリーのツールがあります。

* **Web情報収集ツール**: **Tavily**や*Google*など。言語モデルでの利用に最適化された検索結果や、Webページの内容を取得します。
* **生産性向上ツール連携**: **Slack**, **Notion**, **Google Workspace**など。日々の業務で使うツールに通知を送ったり、会議の議事録を自動で書き込んだりします。
* **マルチモーダルAIツール**: **Stable Diffusion**(画像生成) や **ElevenLabs**(音声合成) など。テキストだけでなく、画像や音声も扱えるようになります。
* **カスタムAPIツール**: **外部API呼び出し**ツールなど。社内システムや外部の様々なサービス（例：天気予報API、株価API）と連携し、自動化の可能性を無限に広げます。

これらのツールをLLMと組み合わせることで、「**Webで技術情報を収集し → LLMに分析・要約させ → 結果を設計書としてまとめる**」といった、人間が実際に行う業務を模倣した複雑な自動化が実現可能になるのです。

## 実践：要件から技術調査を行い、結果をフィルタリング&整形するワークフローを作成する

これから1つのワークフローを前編と後編のワークに分けて構築していきます。
おおまかなフローの全体像は以下の通りですが、このワークでは1から3までを実装します。

このワークで構築するフローのステップ

```
1. ユーザーがアップロードした「要件定義書」をAIに渡し、調査すべき問いをいくつかの観点で**考える**。

2. その問いをもとに**Tavily**ツールを使ってWeb上で**技術調査を行う**。

3. コード実行ノードを用いて検索結果をスコアでフィルタリングし、後続ノードに渡すデータを**整形する**。
```
次のワークで構築するフローのステップ
```
4. 「要件定義書」と「Web検索の結果」を精査し、設計書を作成するために必要不可欠な技術的ポイント、採用すべきアーキテクチャのパターン、潜在的なリスクなどを**分析**する。

5. 設計書の執筆と修正を**ループ実行する**。
```

### ✅ 実践の前に：Tavilyツールの準備をしよう 🔧

このワークでは **Tavily**ツール を使用します。これは外部のサービスと連携するため、APIキーの設定が必要です。

**Tavily APIキーの取得方法:**

1.  [Tavily公式サイト](https://tavily.com)にアクセスし、アカウントを作成します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-1.png)

2.  ログイン後、ダッシュボードでAPIキーをコピーし、安全な場所にコピーしておきます。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-2.png)

3.  執筆時点(2025年9月)では、月1,000回までのAPIコールは**無料**で利用できます。

**Difyへのツール追加:**

1.  Dify画面上部のメニューから `ツール` を選択します。
2.  `マーケットプレイス` で `Tavily` を検索し、`インストール` をクリックします。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-3.png)
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-4.png)

3.  `ツール` タブに戻り、`Tavily` の `認証を設定` をクリックします。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-5.png)

4.  先ほど取得した **APIキー**を入力して保存します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-6.png)

これで、ワークフローでTavilyツールを呼び出せるようになりました。

### Step 1: ワークフローの準備と開始ノードの設定

このワークで構築する
「**Webで技術情報を収集し → LLMに分析・要約させ → 結果を設計書としてまとめる**」

まず、ユーザーが要件定義書をアップロードするための入り口（トリガー）を作ります。

1.  ワークフローを新規に作成します。（アプリ名：自動調査&設計書作成）
2.  `開始` ノードをクリックし、ファイルアップロード用の変数を1つ作成します。
    * **フィールドタイプ**: `単一ファイル`, **変数名**: `requirements_doc`, **ラベル名**: `要件定義書`, **サポートされたファイルタイプ**: `ドキュメント`に✅, **必須**: ON
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-7.png)

### Step 2: ドキュメントからテキストを抽出する（テキスト抽出ノード）

**【解説】**
開始ノードでアップロードされたファイルをLLMノードに直接渡すと、Difyの内部的なファイル処理が原因で予期せぬエラーが発生することがあります。この問題を回避するため、Difyに**デフォルトで搭載されている「テキスト抽出」ノード**を使い、アップロードされたファイルから安全にテキスト情報だけを抜き出します。

1.  `開始` ノードの次に、`ツール`カテゴリの中にある `テキスト抽出` ノードを追加します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-8.png)

2.  `入力変数` の欄に、開始ノードのファイル変数 `{{開始/requirements_doc}}` を設定します。このノードは、PDFやDOCX、TXTなど様々な形式のファイルからテキストを抽出し、文字列として出力して別のノードに渡すことができます。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-9.png)

### Step 3: 検索クエリ配列を生成する（LLMノード）

要件定義書のどのような情報をもとにWebを検索するべきか、つまり「**調査すべき核心的な問い**」をAIに考えさせます。

1.  `開始` ノードの次に `LLM` ノードを追加します。
2.  `システムプロンプト` に、以下の指示を貼り付けます。ここでは第5章で学んだステップバック思考を指示に含めることで、一歩引いて俯瞰した立場でAIに考えてもらいましょう。

```markdown
# 役割
あなたは、大規模Webサービスの開発経験が豊富な、世界トップクラスのシステムアーキテクトです。同時に、技術的な課題を解決するために、最も効果的な検索クエリを組み立てることに長けた熟練のリサーチャーでもあります。

# 背景
渡された要件定義書は、これから開発する新機能の概要です。あなたのタスクは、ステップバック思考を用いて、技術設計の成功に不可欠な「調査すべき核心的なテーマ」を特定し、それに基づいた最適な検索クエリを生成することです。

# 指示
以下の要件定義書の内容を深く分析し、この機能の技術設計を行う上で調査・検証すべき最も重要なテーマを5つ特定してください。次に、各テーマについて、検索エンジンで最も関連性の高い情報を引き出すための**キーワードを組み合わせた検索クエリ**を生成してください。

# 制約条件
- 各クエリは、具体的な技術選定、アーキテクチャパターン、セキュリティリスク、スケーラビリティに関する内容を含むこと。
- **完全な自然言語の文章ではなく、検索エンジンに最適化された3〜5個程度の重要なキーワードの組み合わせを生成してください。**
- **出力は検索クエリの文字列を要素とするJSON配列のみ**とし、マークダウンや説明文など余計な情報は絶対に含めないでください。

# 少数例示 (Few-Shot Example)
## 入力となる要件定義書の例:
 「ユーザー同士がリアルタイムでテキストメッセージを送り合えるチャット機能を追加する。オンラインステータスの表示も必要。」

## 期待する出力形式例 (JSON):
[
"real-time chat WebSocket SSE scalability comparison",
"WebSocket security best practices hijacking injection",
"chat user presence online status scalable architecture",
"chat message broker AWS SQS RabbitMQ comparison",
"chat message history database performance millions"
]
```
出力形式ですが、後の`イテレーション`ノードで使えるように**JSON配列形式**で出力させています。

3.  `+メッセージ追加`ボタンをクリックして、`USER`欄に以下を設定することで、テキスト抽出ノードの出力結果を要件定義書として渡します。
```
#要件定義書
{{テキスト抽出/text}}
```
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-10.png)

### Step 4: 検索クエリの文字列を配列型に変換する (コード実行ノード)

**【解説】**
LLMノードが出力したのは、あくまでJSON形式の「**文字列**」です。一方で、次のイテレーションノードが処理できるのは、「**配列(Array)型**」のデータのみです。このため、間にコード実行ノードを挟んで、文字列から配列型へとデータ形式を変換してあげる必要があります。
:::hint
「コードの書き方がわからない！」という方でも安心してください。ChatGPTやGeminiのブラウザページに行き、何が欲しいかを自然言語で指示する（たとえば以下のようなプロンプトを書いて質問する）と、ソースコードも出力してくれます。

```
以下のコード例と条件をもとに、pythonコードを作成してください。

#コードの例
def main(arg1: str, arg2: str) -> dict:
    return {
        "result": arg1 + arg2,
    }

#条件
処理：入力変数llm_output_stringで渡されたJSON文字列をリスト化して、配列変数queries_arrayに詰めて返すこと。
```
第1章でご紹介したように、執筆時点(2025年9月)におけるベンチマークのコーディングスコアを見ると、ChatGPT5にコーディングさせることをおススメします。
:::

1.  `LLM` ノードの次に `コード実行` ノードを追加します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-11.png)

2.  入力変数 `llm_output_string` に `{{#LLM/text#}}` を設定します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-12.png)

3.  以下のPythonコードを貼り付けて、JSON文字列をPythonのリスト（配列型に対応）に変換します。

```python
import json

def main(llm_output_string: str) -> dict:
    """
    LLMが出力したJSON文字列をパースし、
    文字列のリスト、またはオブジェクトのリストのどちらにも対応して、
    最終的に文字列のリストを返す。
    """
    try:
        data = json.loads(llm_output_string)
        
        # データがリスト形式でなければ、空のリストを返す
        if not isinstance(data, list):
            return {"queries_array": []}
            
        queries_list = []
        for item in data:
            # ケース1: リストの要素が辞書の場合（例: {"query": "..."}）
            if isinstance(item, dict):
                # "query" キーの値を取得。存在しない場合は空文字
                query_text = item.get("query", "")
                if query_text: # 空文字でなければ追加
                    queries_list.append(query_text)
            # ケース2: リストの要素が既に文字列の場合
            elif isinstance(item, str):
                queries_list.append(item)
                
        return {"queries_array": queries_list}

    except (json.JSONDecodeError, TypeError):
        # 変換に失敗した場合は空のリストを返す
        return {"queries_array": []}

```

4.  出力変数 `queries_array` を `Array(String)` 型として設定します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-13.png)

### Step 5: 複数の検索クエリを並列実行する (イテレーションノード & Tavilyツール)

`イテレーション（反復処理）` ノードは、配列で渡された全てのデータに対して同じステップを複数回実行し、すべての結果を出力することができます。

このワークでは配列型に変換された複数の検索クエリを一つずつ、かつ高速に実行するため、`イテレーション`ノードを活用します。

1.  `コード実行` ノードの次に `イテレーション` ノードを追加します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-14.png)

2.  `イテレーション`ノードの設定で、入力欄に **Step 3のコード実行ノードが出力した配列**`{コード実行/queries_array}}` を指定し、`パラレルモード` を **ON**にします。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-15.png)

3.  `イテレーション`ノード内の `+ブロックを追加` をクリックし、`ツール` タブから `Tavily Search` ノードを配置します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-16.png)

4.  `Tavily Search` の `ワークスペースのデフォルト` をクリックして、Tavilyツール準備時に認証したAPIキーに切り替えます。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-17.png)

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-18.png)

5.  `Tavily Search` の入力変数 `Query` に `{イテレーション/item}` を設定します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-19.png)

:::point
## パラレルモードの利点と注意点

#### 利点
パラレルモードをONにすると、複数の検索（APIコール）が同時に実行されます。例えば5つの検索クエリがあり、1回の検索に3秒かかるとします。通常（逐次実行）では 3秒 × 5回 = 15秒 かかりますが、パラレルモードでは理論上は約3秒で完了します。このように、API連携など待ち時間が発生する処理を複数回行う場合に、ワークフロー全体の実行時間を大幅に短縮できるのが最大のメリットです。

#### 課題
非常に便利な機能ですが、Difyのバージョンや実行環境によっては、同時に完了した各処理の結果を正しく一つに集約できない場合があります。その結果、「最後のキーワードの検索結果しか次のノードに渡されない」といったデータ欠損の問題が発生することがあります。

#### 回避策
もし後続のステップでデータが不足しているなどの問題が発生した場合は、まずパラレルモードをOFFにして、逐次実行（一つずつ順番に実行）で試すのが最も確実な解決策です。 逐次実行は時間はかかりますが、各ステップの結果を確実につなぐことができます。
:::

### Step 6: 検索結果をスコアでフィルタリングし、整形する (コード実行ノード @イテレーション内部)

Tavily Searchの初期機能として、検索結果に関連性スコアが含まれています。スコアが低い結果を除外する処理を組み込むことで、後続のノードに質の高い情報のみを渡すことができます。

また、検索結果は「**配列の配列**」（例: `[[検索1の結果], [検索2の結果], ...]`) というネストした構造になります。このままでは後続のLLMが扱いにくいため、オブジェクトの配列をLLMが読みやすい単一の文字列に変換する処理も同時に実行します。

1.  イテレーションノード内の `Tavily Search` ノードの次に `コード実行` ノードを追加します。

2.  コードノードの入力変数 `arg1` に `{{TavilySearch/json}}` を設定します。
3.  以下のPythonコードを貼り付け、関連スコアが `0.5` 以上の結果のみを抽出して整形します。

```python
def main(arg1: list) -> dict:
    
    threshold = 0.5  # 関連性スコアの閾値

    # --- STEP 0: 入力正規化 ---
    results: list[dict] = []
    try:
        if isinstance(arg1, list) and arg1:
            # 標準: [ { "results": [...] } ]
            if isinstance(arg1[0], dict) and "results" in arg1[0]:
                for item in arg1[0].get("results", []):
                    if isinstance(item, dict):
                        results.append(item)
            # フラット: [ {title,url,content,score}, ... ]
            elif all(isinstance(x, dict) for x in arg1):
                results = arg1[:]
            # まれにネスト: [ [ {...}, ... ], [ {...} ] ]
            elif isinstance(arg1[0], list):
                for sublist in arg1:
                    if isinstance(sublist, list):
                        for item in sublist:
                            if isinstance(item, dict):
                                results.append(item)
    except Exception:
        # 予期しない形状の場合は空として扱う
        results = []

    # --- STEP 1: スコアでフィルタリング ---
    filtered_results: list[dict] = []
    for r in results:
        raw_score = r.get("score", 0)
        try:
            score = float(raw_score)
        except (TypeError, ValueError):
            score = 0.0

        if score >= threshold:
            filtered_results.append({
                "title": r.get("title"),
                "url": r.get("url"),
                "content": r.get("content"),
                "score": score,
            })

    # --- STEP 2: マークダウン文字列に整形 ---
    if not filtered_results:
        final_string = "関連する検索結果は見つかりませんでした。"
    else:
        chunks = []
        for i, result in enumerate(filtered_results, start=1):
            title = result.get("title", "タイトルなし")
            url = result.get("url", "URLなし")
            content = result.get("content", "内容なし")
            score = result.get("score", 0.0)
            chunk = (
                f"## 検索結果 {i}\n\n"
                f"### タイトル: {title}\n"
                f"**URL:**{url}\n"
                f"**関連スコア:**{score:.4f}\n\n"
                f"**内容:**\n{content}\n"
            )
            chunks.append(chunk)
        final_string = "\n---\n\n".join(chunks)

    # final_search_results を返却
    return {"final_search_results": final_string}

```

#### スクリプト解説:
    本スクリプトは、各クエリごとに「高スコアの検索結果のみ」を取り出し、その場でLLMが読みやすいマークダウン文字列へ変換して返します。

    入力想定（Tavily Searchの出力を想定。多少の揺れに対応）:
      1) 標準形: [ { "results": [ { "title": ..., "url": ..., "content": ..., "score": ... }, ... ] } ]
      2) フラット: [ { "title": ..., "url": ..., "content": ..., "score": ... }, ... ]
      3) まれにネスト: [ [ { ... }, { ... } ], [ { ... } ] ]

    処理手順:
      - STEP 0: 入力正規化
                入力の形状に依存せず、結果辞書の一次元リストに正規化します。
      - STEP 1: スコアフィルタリング
                score >= 0.5 の結果のみ残します（型が不定でも安全にfloat化）。
      - STEP 2: マークダウン整形
                フィルタ済み結果を、タイトル/URL/スコア/内容のブロックとして結合します。
                該当がない場合は、その旨のメッセージを返します。

    出力:
      - final_search_results: str
          → マークダウン整形済みの単一文字列のみを返します

4.  コードノードの出力変数 `final_search_results` を `String` 型として設定します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-20.png)

5.  イテレーションノードの `出力` に、このコードノードの出力 `{{コード実行/final_search_results}}` を設定します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-21.png)

これで、複数の検索クエリで検索したスコアの高い結果だけが次のノードに渡せるようになりました。

### Step 7: 終了ノードで最終結果を確認する

整形された最終的な検索結果をワークフローの出力として設定します。

1.  **イテレーションノード**の出力を `終了` ノードに接続します。
2.  `終了` ノードでイテレーションノードの出力 `{イテレーション/output}` を選択します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-22.png)

### Step 8: テストと実行

実行画面で、パイプラインが正しく動作するか確認しましょう。

まず、フォルダパス`PromptEngineering_lv02_ja\assets\chapter02`配下に配置された`リアルタイム翻訳スマホアプリ要件定義書.docx`ファイルをダウンロードしておきましょう。

1.  画面右上の `実行` をクリックします。
2.  `要件定義書` のフォームに`配下に配置された`リアルタイム翻訳スマホアプリ要件定義書.docx`をアップロードし、`実行` します。
3.  最終的な出力として、AIが生成した**検索クエリ**に基づき、Tavilyで並列検索・スコアフィルタリングされ、**整形された質の高い検索結果**のリストがJSON形式で表示されれば成功です。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter02/img/work10-23.png)

お疲れ様でした！ これでワークフローの前半部分が完成しました。
ファイルから情報を読み込み、**ステップバック思考**で検索クエリを作成し、自律的に質の高いWeb調査を行うパイプラインです。

次のワークでは、この調査結果を分析・要約し、設計書を出力するまでのフローを構築します。

