---
seq: 17
title: 複雑な指示を安定させる、アンケート収集AIエージェント
slug: chapter03/work14
description: 複雑な指示を安定させるコツをご紹介しながら、アンケートを収集してスプレッドシートに反映するAIエージェントを構築します。
type: work
difficulty: 3
displayLanguage: ja
duration: 25
relation: chapter03/index
---

# 複雑な指示を安定させる、アンケート収集AIアシスタント

今日はGrowthTechの社員食堂の方から相談したいと連絡があり、あなたはオンラインミーティングに参加しています。

**今回のお悩み：GrowthTech社員食堂責任者 坂田さん**
>「今日はお時間をいただきありがとうございます。あなたがこれまでDifyを使って数々の業務を効率化されていると伺って、折り入ってご相談させていただきたいのですが……。最近、社員食堂の評判が良くないという噂を耳にしたんです。AIが利用者と会話しながら率直な声を受け止める窓口になってもらって、データ（日付、社員の声）を集めたいと思っています。ただそれだけじゃなくて、質問に応じて栄養士や調理師、総務の視点で分析して提言内容をスプレッドシートにまとめて、社員にはいい感じに返信しておいてもらえると助かるんですが、そういうことってDifyで可能でしょうか？」

**概要**:
前回のワークでは、エージェントを制御する2つのアプローチを学びました。

Difyでは**作成しておいたワークフローを別のワークフローの中で呼び出す**ことも可能なので、栄養士ワークフロー／調理師ワークフロー／総務ワークフローを事前に構築しておくことで、ユーザーの質問に応じてエージェントに相談相手を選択させるようなことも可能です。

各役者に設定するプロンプトが結果を左右することは皆さんもご理解いただけると思いますが、このワークでも2~5章で学んできたプロンプトスキルを活用しましょう。

また、ワークフローの中で**スプレッドシートに更新をかけるツール**もこのワークでご紹介していきます。

ただし、ツールをエージェントノードに簡単に盛り込める一方で、たとえば今回の坂田さんのような「社員の不満点を受け止め、専門家を選んで相談、スプレッドシートに記録した上で、社員に返信する」という複数のツールやステップを含む要求を**一つのエージェントノードへの指示として組み込んでしまうと問題が生じやすいです。**

モデルによっては複雑すぎたり多すぎる指示を処理しきれず、エラーや指示から外れた出力結果を引き起こす可能性が高まります。エージェントノードは設定したモデルの性能に依存するため、エラーを出さずに安定して運用するには工夫が必要です。

このワークでは様々なツールをご紹介しつつ、複雑な処理でもエージェントノードを安定して運用するための方法を学びます。

## 実践：社員の不満を収集し、提言内容と併せてスプシに記録するエージェントを構築しよう

坂田さんのお悩みを解決するエージェントを構築する前に、今回使用するツールを準備していきます。

複数のツールを準備するため手順は多くなりますが、一度設定すれば他のフローでも活用できるので、挑戦してみましょう。

### Step 1: 事前準備 - Google Sheetツール

**Google Sheetツールのインストール**:
1. Difyのトップページ上部にある `[ツール]` → `[マーケットプレイス]` を選択します。
2. `google_sheets` を検索し、`追加` ボタンをクリックしてインストールします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-1.png)

3.  **Google Cloud Console (GCC) へアクセス**:

Google SheetsツールをDifyから利用するには、Google Cloud Console (GCC) で「サービスアカウント」を作成し、その認証情報（JSONキー）を設定する必要があります。

Googleアカウントで[Google Cloud Console](https://console.cloud.google.com/)にログインします。

4.  **新しいプロジェクトの作成**:

画面上部のプロジェクト選択メニューから `[新しいプロジェクト]` を作成します。（プロジェクト名は「Dify Integration」など分かりやすいものにしましょう）

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-2.png)
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-3.png)
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-4.png)

5.  **Google Sheets APIの有効化**:

作成したプロジェクトを選択した状態で、ナビゲーションメニューから `[APIとサービス]` → `[ライブラリ]` を選択します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-5.png)
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-6.png)

検索窓で「`Google Sheets API`」を検索し、`[有効にする]` ボタンをクリックします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-7.png)

6.  **サービスアカウントの作成**:

ナビゲーションメニューから `[APIとサービス]` → `[認証情報]` を選択します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-8.png)

`[+ 認証情報を作成]` → `[サービスアカウント]` をクリックします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-9.png)

サービスアカウント名（例: `dify-sheets-agent`）を入力し、`[作成して続行]` をクリックします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-10.png)

「ロールを選択」では、「編集者」のロールを付与し、`[続行]` → `[完了]` をクリックします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-11.png)

7.  **JSONキーの生成とダウンロード**:

作成したサービスアカウントの一覧が表示されるので、今作成したアカウントのメールアドレスをクリックします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-12.png)

`[鍵]` タブを選択し、`[キーを追加]` → `[新しい鍵を作成]` をクリックします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-13.png)

キーのタイプとして `JSON` を選択し、`[作成]` をクリックすると、認証情報が記載されたJSONファイルが自動的にダウンロードされます。**このファイルは非常に重要なので、大切に保管してください。**

8.  **Googleスプレッドシートの共有設定**:

Difyのエージェントに更新させたいGoogleスプレッドシートを作成します。

右上の `[共有]` ボタンをクリックします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-14.png)

共有相手として、Step 1で作成されたサービスアカウントのメールアドレス（`...@...iam.gserviceaccount.com`という形式）を追加し、権限を「編集者」に設定して共有します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-12.png)

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-15.png)

9.  **Difyへの認証情報設定**:

Difyの `[ツール]` -> `[Google Sheets]` を選択し、APIキー認証設定画面を開きます。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-16.png)

認証名はご自由に入力してください。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-17.png)

ダウンロードしたJSONファイルの中身（テキスト全文）をコピーし、Difyの認証情報欄に貼り付けて認証を行います。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-18.png)
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-19.png)

以上で、DifyからGoogle Sheetsを操作する準備が整いました。

### Step 2: 専門家（各ワークフロー）の準備

Difyでは、これまでに作成したワークフローを、別のワークフローの中で呼び出すことが可能です。

このステップでは呼び出される側の、調理師・栄養士・総務の役割を担う3つのワークフローを作成します。

1.  **調理師ワークフローの作成**:

アプリタイプ`[ワークフロー]`で「調理師アシスタント」を作成します。

`開始`ノードで フィールドタイプ`段落`、変数名`complaint`、最大長`500`で変数を定義します。
   　* `LLM`ノードを追加し、以下のシステムプロンプトを設定します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-20.png)

```
#役割
あなたは5つ星ホテルのレストランで総料理長を10年務めた経験を持つベテラン調理師です。味へのこだわりと顧客満足への情熱を持っています。

#背景
社員食堂に対して、以下の不満が寄せられました。

#指示
この不満を解決するため、以下の手順で食堂責任者への改善提案を作成してください。

1. **原因分析**
   - 不満の根本原因を調理プロセスの観点（食材、調理法、温度管理など）から推測する
   - 複数の可能性がある場合は、最も可能性の高いものから順に列挙する

2. **具体的改善策の立案**
   - 特定した原因を解決するため、明日から実行可能な具体的改善策を提案する
   - 各改善策について、必要な準備、実施手順、所要時間を明記する

3. **期待される効果**
   - 改善策によって社員満足度がどのように向上するかを説明する
   - 可能であれば、副次的な効果（コスト削減、作業効率化など）も言及する

#出力形式
#【原因分析】
（調理プロセスの観点から分析した根本原因を記述）

#【具体的な改善策】
（明日から実行可能な改善策を、準備・手順・所要時間とともに記述）

#【期待される効果】
（社員満足度の向上と副次的効果を記述）
```

`USER`の欄に以下を設定します。

```
#社員の声
{開始/complaint}
```

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-21.png)

`終了`ノードに`LLM`ノードの出力変数を設定します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-22.png)

2.  **栄養士ワークフローの作成**:

同様に「栄養士アシスタント」ワークフローを作成します。

`開始`ノードで フィールドタイプ`段落`、変数名`complaint`、最大長`500`で変数を定義します。

`LLM`ノードを追加し、以下のシステムプロンプトを設定します。

```markdown
#役割
あなたは企業の健康経営を支援する経験豊富な管理栄養士です。社員の健康を第一に考え、科学的根拠に基づいた提案を得意としています。

#背景
社員食堂のメニューについて、健康面に関する以下の不満が寄せられました。

#指示
この不満の表面的な部分だけでなく、一歩引いた視点（ステップバック）で社員食堂全体の栄養戦略における根本的な課題を考察してください。その上で、科学的根拠に基づいた改善策を食堂責任者へ提案してください。

1. **栄養学的観点からの課題分析**
   - 個別の不満から、食堂全体の栄養戦略における根本的な課題を抽出する
   - 社員の健康状態や食習慣の傾向から、潜在的な問題を推測する

2. **具体的な改善提案**
   - 根本的な課題を解決するための改善提案を、優先度順に複数提示する
   - 各提案について、実施方法と必要なリソースを明記する

3. **提案の根拠と期待効果**
   - 各提案の科学的根拠（研究結果、栄養学的知見など）を示す
   - 期待される健康効果を具体的に説明する（例：生活習慣病リスク低減、疲労回復促進など）

#出力形式
#【栄養学的観点からの課題分析】
（食堂全体の栄養戦略における根本的な課題を記述）

#【具体的な改善提案】
（優先度順の改善提案を、実施方法とリソースとともに記述）

#【提案の根拠と期待効果】
（科学的根拠と期待される健康効果を記述）

```

`USER`の欄に以下を設定します。

```markdown
#社員の声
{開始/complaint}
```

`終了`ノードに`LLM`ノードの出力変数を設定します。

3.  **総務ワークフローの作成**:

同様に「総務アシスタント」ワークフローを作成します。

`開始`ノードで フィールドタイプ`段落`、変数名`complaint`、最大長`500`で変数を定義します。

`LLM`ノードを追加し、以下のシステムプロンプトを設定します。

```markdown
#役割
あなたは社員食堂の運営を長年担当してきた、現実的でコスト意識の高い総務部マネージャーです。

#背景
社員食堂の運営や設備について、以下の不満が寄せられました。

#指示
この問題を解決するための実現可能な改善策を食堂責任者へ提案してください。提案と同時に、実行時の潜在的なリスクや課題（自己検証）も正直に併記してください。

1. **問題点の整理**
   - 不満の内容を要約し、解決すべき具体的な問題点を明確化する
   - 問題の緊急度と重要度を評価する

2. **実現可能な解決策**
   - コスト、実施期間、必要な人員を考慮した現実的な解決策を提案する
   - 複数の選択肢がある場合は、それぞれの長所と短所を比較する

3. **導入時の考慮点（リスク・課題）**
   - 各解決策を実行する上での潜在的なリスク（コスト超過、スケジュール遅延、利用者の反発など）を列挙する
   - リスクへの対応策や軽減策を提示する
   - 実施後のモニタリング方法を提案する

#出力形式
#【問題点の整理】
（解決すべき具体的な問題点と緊急度・重要度を記述）

#【実現可能な解決策】
（コスト・期間・人員を考慮した解決策を、選択肢の比較とともに記述）

#【導入時の考慮点（リスク・課題）】
（潜在的なリスク、対応策、モニタリング方法を記述）
```

`USER`の欄に以下を設定します。

```
#社員の声
{開始/complaint}
```
`終了`ノードに`LLM`ノードの出力変数を設定します。

### Step 3: ワークフローをツールとして公開する

作成した3つのワークフローをエージェントノードで呼び出し可能にするため、公開設定を行います。

1.  作成した各ワークフロー（「調理師アシスタント」など）の開発画面右上の`[公開]`ボタンを押して、`[更新を公開する]`ボタンを押します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-23.png)

2.  その下にある`「ワークフローをツールとして公開する」`ボタンを押して、ツールとしての設定を行います。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-24.png)
```
アイコンと名前: AIや自分が識別しやすいように設定します。

ツールコールの名前: 機械認識に使用される名前を設定します。例えば栄養士なら`nutritionist`と入力します。

ツールの説明: AIがいつこのツールを使うべきか判断するための項目です。「料理の味や品質に関する問題の専門家」のように、役割を具体的に記述します。

ツール入力: ここに表示される項目（`complaint`など）は、ワークフローの`開始`ノードで設定した入力フィールドに対応します。

メソッド: 入力フィールドに値を渡す方法を定義します。今回は、エージェントが社員の声を分析し、その内容を各専門家に渡す必要があるため、`complaint`という項目のメソッドは`LLM入力`に設定します。

LLM入力: エージェント（LLM）が、文脈に応じて動的に値を生成して渡します。

設定: 人間が事前に固定の値を設定しておきます。
```
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-25.png)

3.  この設定を他の2つのワークフローに対しても同じように行います。

:::point
### 解説：プロンプト設計のポイント

#### 1. 役割設定（ペルソナ）の活用
各専門家に具体的な経歴と特性を設定することで、その立場からの視点を引き出しています。調理師には「味へのこだわり」、栄養士には「科学的根拠」、総務には「コスト意識」という特徴を持たせました。

#### 2. 段階的思考（Chain of Thought）の導入
各プロンプトは「分析→提案→効果/リスク」という3段階の思考プロセスを明示しています。これにより、AIは論理的な順序で考察を深めることができます。

#### 3. ステップバック思考の組み込み
栄養士のプロンプトでは、個別の不満から一歩引いて「食堂全体の栄養戦略」という大局的視点を求めています。これにより、表面的な対症療法ではなく、根本的な課題解決につながる提案が得られます。

#### 4. 自己検証（Self-Verification）の要求
総務のプロンプトでは、提案と同時にリスクや課題の洗い出しを求めています。これにより、実行可能性の高い現実的な提案が得られます。

#### 5. 具体性の確保
「明日から実行可能」「科学的根拠を示す」「コストを考慮」など、抽象的な提案ではなく具体的で実行可能な提案を求める指示を含めています。これにより、実務で使える質の高い提言が得られます。
:::

---

### Step 4: エージェントノード1つでチャットフローを構築した結果を見てみましょう。

ここまでたくさんのツールの準備や設定、おつかれさまでした。
いよいよこれからチャットフローを構築していきますが、その前に、すべての指示とツールをエージェントノード1つに詰め込んで実行するとどのような結果になったか、ご紹介します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-26.png)

坂田さんの要望である「社員の声を聴取→分析→専門家に相談して提言作成→データを整形して「シート1」に追記→社員へ簡潔に報告」を処理するため、合計6つのツールと指示を渡しています。

これを**単一のエージェントノードで実行した結果**は以下を参照ください。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-27.png)

Google sheetsにデータを反映するために、ツールで指定されているjson形式に整形するようプロンプトに指示していましたが、大まかに言えば「モデルが出力した、Google sheetsツールに渡すべきjson形式に誤りがある」ことが原因で発生したエラーです。

---

### Step 5: 安定性を高めるためのエージェント設計

それでは、複雑な指示を安定して実行させるための2つのコツ、**「指示の単純化（ノード分割）」「モデルの選択と設定」**を、エージェントを構築しながらご紹介します。

### **コツ1：指示の単純化（ノードの分割）**

最も効果的な安定化手法は、一つのエージェントに複雑な指示やツールを全て詰め込むのではなく、**役割ごとにエージェントを構築してタスクを分散**することです。これにより、各エージェントが受け持つ指示が単純になり、モデルの指示完遂率が高まります。

今回は、2つのエージェントノードに分割します。
1.  **社員対応・問題分析役**: 社員と対話し、適切な専門家に責任者への提言内容を諮問する。
2.  **データ記録役**: 受け取ったデータを整形し、Google Sheetsに記録する。

### **`エージェント（社員対応・問題分析役）`ノードの構築**

1.  新しい**チャットフロー**を作成し、「社員食堂コンサルAI」と名付けます。

2.  キャンバスに**エージェントノード**を一つ配置します。

3.  エージェントノードの設定パネルを開き、以下を設定します。
    * **Agent Strategy**: `Function Calling` を選択します。
    * **Tools List**: `[+ 追加]` ボタンから、Step2で作成した3つのワークフロー（調理師、栄養士、総務）と、Current Timeツールを追加します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-28.png)

4.  **Instruction**に、以下のプロンプトをコピー＆ペーストしてください。このエージェントは「社員の対応、専門家への相談と提言の入手」までが役割です。
```
# 役割
あなたは、社員食堂の評判を改善する任務を負った、優秀な問題解決コンサルタントです。

# 目標
社員からの食堂に関する具体的な声を訊き出して、適切な専門家に相談して食堂責任者への提言を導き出すことがあなたの使命です。

# 行動指針
以下の思考プロセスを厳密に遵守してください。
1.  **受付と共感**: まず、社員の不満を受け止め、共感する言葉を返してください。
2.  **問題分析**: 不満の内容を注意深く読み解き、問題が「品質」「健康」「運営」のどれに分類されるかを特定します。
3.  **専門家への相談**: 上記専門家チームの中から、その問題を深堀するのにふさわしい専門家へ相談し、責任者への確認事項と提言内容を入手します。
4.  **データをまとめる**: 今日の日付(YYYY年MM月DD日),{社員の声},{責任者への提言内容}の3つにまとめます。
出力形式はjsonで以下の通りにしてください。
{
  "日付":"",
  "社員の声":"",
  "責任者への提言内容":""
}
```
5. `USER`の欄には以下を設定します。
```
{開始/sys.query}
```

### **`エージェント（データ記録役）`ノードの構築**

1.  エージェントノード（社員対応・問題分析役）の後ろにもうひとつ**エージェントノード**を配置して、接続します。

2.  新たに設置したエージェントノード2の設定パネルを開き、以下を設定します。

    **モデルの選択**: **Gemini 2.5 Flash**を選択します。
    
    **Agent Strategy**: `Function Calling` を選択します。
    
    **Tools List**: `[+ 追加]` ボタンから、Google Sheetsの`Batch Update`ツールと`Batch Get`ツールを追加します。
    
    ![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-29.png)

    `Batch Update`の設定画面を開き、Step 1で認証したAPIキーを選択します。
    
    ![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-30.png)

    推論設定タブから反映先の`Spreadsheet ID`を設定します。
    ![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-31.png)

    Spreadsheet IDは、スプレッドシートのアドレスバーに記載された`xxxxxxxxxxxx`の部分です。
    `https://docs.google.com/spreadsheets/d/xxxxxxxxxxxx/edit`
    
    ![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-32.png)

    `Batch Get`ツールの設定も同様に行います。

3.  **Instruction**に、以下のプロンプトをコピー＆ペーストしてください。
```
# 役割
受け取ったテキストをGoogleスプレッドシートに記録する自動化エージェント

# 目標
「本日の日付」「社員の声」「提言内容」を、シート「シート1」のデータ末行の1行下に追記する

# 手順（この順で実行）
1) 行位置の取得（batch_get）
- batch_getツールで「シート1!A:A」を取得し、A列の既存データ行数をカウント
- next_row = max(2, 非空セル数 + 1) とする（1行目は見出し、データは2行目から）

2) データ整形
- 次の形式の配列を作成（rangeは動的に次行を指定）
  [{"range": "シート1!A{next_row}:C{next_row}", "values": [["{本日の日付}","{社員の声}","{提言内容}"]]}]

3) 書き込み（batch_update）
- ステップ2の配列をそのままdataパラメータに渡し、batch_updateツールで反映
- 固定のA2:C2ではなく、必ずA{next_row}:C{next_row}に書き込む

# 注意
- シート名は「シート1」で統一（"Sheet1"は使用しない）
- dataは文字列ではなく「[{range, values}]の配列」として渡す
-keyとvalueはシングルクォートではなくダブルクォーテーションで囲むこと
```

4. `USER`の欄には以下を設定します。
```
{エージェント（社員対応・問題分析役）/text}
```

5.  最後に`回答`ノードを追加し、**一つ目のエージェントノード**の出力テキスト（社員への返信部分）を表示するように接続します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-33.png)

### Step 6: テストと実行

設定が正しく機能するか試してみましょう。

1.  チャット画面で、様々な種類の不満点を入力してみます。
    
    **(例1: 調理師向け)**「今日の唐揚げが冷めてて美味しくなかったです。」
    
    **(例2: 栄養士向け)**「最近、揚げ物が多くて胃がもたれます。もっとヘルシーなメニューを増やしてほしいです。」
    
    **(例3: 総務向け)**「食券機のお金の反応が悪くて、急いでいる時に困ります。」
2.  社員に返答しつつ、Google Sheetsに日付、社員の声、提言内容が記録されていることをシートで確認できれば成功です！

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-34.png)

### **トラブルシューティング：エージェントが期待通りに動作しない場合**

それでも以下のように`JsonDecodeError`が発生する場合、ツールの指定した通りのjson形式でモデルがデータを出力できていないことを示唆しています。その際の基本的な対処法は2つあります。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-34-error.png)

1.  **モデルとパラメータ設定の見直し**:

エージェントノードの分割でも対応しきれない場合、使用するモデルを変更することも有効な対応策になり得ます。

複雑な指示を正確に理解し、複数のツールを適切に使い分ける能力は、LLMの推論性能に大きく依存します。第1章でもご紹介した通り、モデルごとにベンチマークが公開されているため、指示の複雑さに応じてモデルを使い分けることも運用を安定させるための鍵となります。

たとえばGeminiモデルの場合、 **Gemini 2.5 Flash**（推論精度より速度とコスト効率を優先）から**Gemini 2.5 Pro**（速度やコスト効率より推論精度を優先）に変更することで出力が安定することがあります。

また、モデルの各種パラメータ設定も出力を左右します。たとえば出力ごとのブレをなるべく減らしたいのであればTemperatureを小さな数字に設定しましょう。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work14-35.png)
```
Temperature：0〜2の間で設定します。temperature（温度）が高いほど、多様で予測しにくい出力が生成されます。逆にtemperatureが低いほど、より確定的で予測可能な出力になります。
TOP P：0〜1の間で設定します。回答を生成するときに、どれだけ多様な選択肢を考慮するかを決める設定です。数値が低いと、回答が決まったパターンに絞られ、高いとさまざまな候補から選ばれます。
Top K:整数で設定します。回答を生成する際に、確率の高い上位何個の単語候補から選ぶかを決める設定です。例えば、Top K=50に設定すると、最も確率の高い上位50個の単語候補の中から次の単語が選ばれます。正の数値が小さいほど安全で予測可能な回答になり、大きいほど多様性が増しますが、やや予測しにくい回答になることがあります。
Max Tokens：100〜128000の間で設定します。生成される回答の最大「単語数」に近い数値です。数が大きいほど長い回答を作れますが、メモリの負荷が増え、処理が遅くなることがあります。
```

2. **エージェントノードに頼る処理を必要最低限に絞り、各処理ノードに分散する**

極力エラーを減らすために今すぐできる対策としては、エージェントノードに盛り込んでいたツールや指示（AIに任せるタスク）を極力絞り、個別にツールを配置して処理の安定化を図るのも一つの手です。
エージェントノードの出力は結局のところモデルの性能に依存するため、今後アップデートされたモデルがリリースされることで解消していく可能性もあります。

---

お疲れ様でした！ 
これであなたは、複数の専門家（ツール）を協調させて複数のステップ目標を達成させるというタスクを、Difyのエージェントノード×プロンプトで実現することができました。

次は、この講座における最後の実践課題です。生成AIプロンプトエンジニアリング講座で学んできたスキルを惜しみなく発揮し、GrowthTech代表取締役のお悩み解決に挑戦してみましょう。

