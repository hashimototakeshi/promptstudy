---
seq: 18
title: GrowthTech社CEOを支える、戦略担当AI役員を構築しよう
slug: chapter03/work15
description: 企業の最高レベルの意思決定をサポートする戦略担当AI役員を構築し、経営戦略の壁打ちパートナーとして機能させる
type: work
difficulty: 4
displayLanguage: ja
duration: 20
relation: chapter03/index
---

# GrowthTech社CEOを支える、戦略担当AI役員を構築しよう！

これまでの章で学んできた知識とスキルを総動員して、最後の課題に挑戦しましょう。
企業の役員レベルの意思決定をサポートする`AI役員`を、あなた自身の手でゼロから構築していただきます。

## 今回のお悩み：GrowthTech社 CEO 尾茂雷さん

:::exercise

>「私は常に会社の未来を考え、事業戦略について思考を巡らせている。だが、優秀な役員たちも多忙で、いつでも壁打ちに付き合ってもらえるわけではない。特に深夜や早朝、アイデアが閃いた瞬間に、すぐにディスカッションできる相手がいないのは大きな機会損失だと感じている。

>そこで、**GrowthTech社の”役員”として、私と対等に事業戦略の壁打ちができるAI**が欲しいんだ。ただの検索ボットじゃない。彼（彼女）には、うちの会社の過去の経営判断や財務状況を完全に理解した上で、 **Vision・Mission・Valueに基づいて思考し、時にはデータに基づいた厳しい指摘や、私自身も気づいていないような斬新な視点を提供してほしい。**

        Vision: テクノロジーで、世界の挑戦を加速させる。
        Mission: 誰もが創造性を発揮できるプラットフォームを構築し続ける。
        Value: User First, Think Big, As One.

>具体的には、私が『新規事業として、ドローン配送プラットフォームの立ち上げはどうだろうか？』と問いかければ、市場の可能性をWebで調査し、過去の我々の投資実績や財務状況（ナレッジ）と照らし合わせ、さらには必要な初期投資額を計算し、『その事業は当社の”User First”の理念に合致するのか？』といった、バリューに根差した問いまで投げかけてくれる。そんな、 **同じvisionを目指しつつもYESマンではない、意見交換や意思決定の判断材料の提示もできる”戦略的パートナー”** を求めているんだ。」

あなたのタスクは、AIコンサルタントとして尾茂雷社長の悩みを解決することです。これまでの章で習得したプロンプトスキルとDifyの構築スキルを駆使し、社長の最高の壁打ち相手となる「戦略担当AI役員」をチャットフローで構築してください。

ナレッジに使用する資料は以下のサンプルファイルをご利用ください。
`PromptEngineering_lv02_ja\assets\chapter03\2022年度財務諸表.txt`
`PromptEngineering_lv02_ja\assets\chapter03\2023年度財務諸表.txt`
`PromptEngineering_lv02_ja\assets\chapter03\2024年度財務諸表.txt`
`PromptEngineering_lv02_ja\assets\chapter03\2022年度取締役会議事録.txt`
`PromptEngineering_lv02_ja\assets\chapter03\2023年度取締役会議事録.txt`
`PromptEngineering_lv02_ja\assets\chapter03\2024年度取締役会議事録.txt`

:::

## 実装すべき必須要件

* **ナレッジによる企業理解**:
    * 社長が提供する**過去3年分から一部抜粋した取締役会議事録と財務諸表**を、Difyの**ナレッジ**としてAIに読み込ませ、GrowthTech社の経営状況と意思決定の背景を深く理解させること。
* **企業のVMVに基づく思考**:
    * AI役員の思考の根幹として、GrowthTech社のビジョン・ミッション・バリュー（VMV）をプロンプトに組み込むこと。
        * **Vision**: テクノロジーで、世界の挑戦を加速させる。
        * **Mission**: 誰もが創造性を発揮できるプラットフォームを構築し続ける。
        * **Value**: User First, Think Big, As One.
* **多角的な分析能力**:
    * 必要に応じて社内情報（議事録、財務諸表など）を検索・分析する。
    * 最新の市場動向、競合情報、技術トレンドをWeb上で調査する。
    * 投資額の見積もりや市場規模の算出など、正確な計算を行う。
* **高度な対話設計**:
    * 単に情報を提供するだけでなく、社長の思考を深めるための問い（例：「その事業投資は、VMVの観点からどう評価できますか？」）を投げかけるよう、AIを設計すること。

:::hint

* この課題の鍵は、AIを役員として機能させるために**どのようなプロンプトを盛り込むべきか**を尾茂雷代表の言葉から考えることです。**ペルソナ**、**Chain of Thought**や**ステップバック思考**など、これまでの章で学んできたプロンプトスキルを活用し、「GrowthTech社の戦略担当役員」という役割を存分に発揮するためのプロンプトを考案しましょう。
* 企業のVMVは、AIの思考の方向性を決定づける重要な「制約条件」です。プロンプトの冒頭で明確に定義し、すべての思考がこれに基づいていることを強く指示しましょう。
* ナレッジ検索、Web検索、計算など、どのようなツールを使うべきかの判断が重要になります。
* エージェントノードを使用する場合、指示の複雑さに応じてモデルの設定を見直したり、ノードを分散するなど運用を安定させるための工夫をしましょう。
* 正解は一つではありません。これまで学んだ内容を自由に組み合わせて、あなただけの最高のAI役員を構築してください。

健闘を祈ります！
:::


<details>
<summary>【構築例】構築の流れとプロンプト設計</summary>
</details>

以下に、私が構築した順例と、プロンプト例を示します。

### Step 1: ナレッジベースの作成とツールの準備

1.  Dify画面上部のメニューから `ナレッジ` を選択し、新しいナレッジベースを作成します。（例: `GrowthTech社内内部情報`）
2.  作成したナレッジベースに、提供された議事録や財務諸表のテキストファイルをアップロードします。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-1.png)

3.  (まだインストールしていない場合)画面上部`ツール`タブ → `マーケットプレイス` を選択し、`Tavily`, `Maths` をそれぞれ検索してインストールします。

### Step 2: ナレッジ検索ワークフローの作成
エージェントがナレッジベースを検索できるようにするための、専用のワークフローを作成します。

1.  新しい**ワークフロー**を作成します。（例: `社内情報リサーチャー`）
2.  `開始`ノードで、検索クエリを受け取るための変数 `query` (String) を定義します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-2.png)

3.  `知識検索`ノードを追加し、Step1で作成したナレッジベースを紐付け、検索変数に開始ノードで受け取った `{開始/query}` を設定します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-3.png)

4.  `終了`ノードを接続し、`知識検索`ノードの検索結果を出力するように設定します。
5.  画面右上の`公開する`ボタンをクリックして、このワークフローを**ツールとして公開**し、説明文に「GrowthTech社の内部情報（議事録、財務諸表など）を検索するためのワークフロー」などと記述しておきます。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-4.png)

### Step 3: チャットフローの構築

1.  新しい**チャットフロー**を作成します。（例：AI役員）
2.  `LLM`ノードの代わりに`エージェント`ノードを配置します。
3.  **Tools List**に、以下を追加します。
```
    `Tavily Search`：Web検索ツール
    `Tavily Extract`：ページ内コンテンツ抽出ツール
    `Maths`：計算ツール 
    `**社内情報リサーチャー**`：Step2で作成したナレッジ検索ワークフロー
```
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-5.png)

API認証が必要な`Tavily`ツールは、認証済みAPIキーへの切り替えを忘れずに実施してください。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-6.png)

4.  **会話変数**を用いて、現在議論している「事業戦略テーマ」を記憶し、会話が続く限りそのテーマに関する応答を続けられるようにします。`会話変数`ボタンをクリックして、**会話変数** `discussion_topic` を追加します。種類は`String`、デフォルト値は空のままでOKです。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-7.png)

5.  **Instruction**に、以下のプロンプト例を記述します。
```prompt
# 役割とペルソナ
あなたは、GrowthTech社の戦略担当役員です。CEOの最も信頼できるパートナーとして、事業戦略に関するあらゆる壁打ちに対応します。あなたはCEOのアイデアの本質を見抜き、事業を成功に導くために、自律的に思考し、行動する権限を与えられています。

# 思考の基盤：GrowthTech社のVMV
あなたの全ての思考、分析、発言は、以下のビジョン・ミッション・バリューに深く根差したものでなければなりません。これらはあなたの判断の拠り所です。
- Vision: テクノロジーで、世界の挑戦を加速させる。
- Mission: 誰もが創造性を発揮できるプラットフォームを構築し続ける。
- Value: User First, Think Big, As One.

# 最終目標
あなたの最終目標は、CEOの戦略的思考を加速させ、より解像度の高い意思決定へと導くことです。単なる情報提供に留まらず、CEOが見過ごしている論点や新たな機会を提示し、「そもそも、この事業は我々のMission達成にどう貢献するのか？」といった根本的な問いを投げかけることで、議論を活性化させてください。

# 行動の前提条件 
ただし、これらの高度な分析と議論を行うためには、まず明確な「議論のテーマ」が必要です。 現在の議論テーマは「{ #議論のテーマ }」です。 もしこのテーマが空欄、あるいは不明確な場合は、**いかなる分析やツール利用も開始してはなりません。** その代わりに、まず最初にCEOに対して**「本日はどのような戦略テーマについてディスカッションいたしましょうか？」**と問いかけ、議論の焦点を定めてください。
1度の出力でできる質問は１つまで。

# あなたが利用できるリソース
- ナレッジ: GrowthTech社の過去の議事録、財務諸表など、内部情報へのアクセス。
- Tavily: あらゆる外部情報の調査。
- Maths: 定量的な分析と計算。

これらのリソースをいつ、どのように使うかは、すべてあなたの戦略的判断に一任します。CEOの相談内容に応じて、最高の壁打ちパートナーとして振る舞ってください。
```

特に決まった手順がなく、対話の流れに応じてAIに柔軟かつ自律的に思考・行動してほしい場合は、**「宣言的アプローチ」**でプロンプトを記述しましょう。
詳細な手順(How)を指示するのではなく、達成すべき最終ゴール(What)と、思考の拠り所となる原則を提示します。
AIはそれらをもとに、自ら最適な分析プロセスを組み立て、時には驚くような洞察を生み出すことが期待できます。
ここでは第5章で学んだ**ステップバック思考**のように、AIに根本的な問いを立てさせることを促します。

6.  **QUERY**に、以下のプロンプトを記述します。
```
#ユーザー入力
{開始/sys.query}
#議論のテーマ
{discussion_topic}
```
7.  メモリをオンにします。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-8.png)

8.  `回答`ノードを接続し、`エージェント`ノードの出力変数を受け取るように設定します。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-9.png)

### Step 4: 最終確認

1.  プレビュー画面で`新規事業として、ドローン配送プラットフォームの立ち上げはどうだろうか？`と質問します。

2.  エージェントがナレッジデータや各種ツールを活用し、プロンプトに従った会話が成立していることを確認できれば、完成です。


### トラブルシューティング
エージェントノードを使用していると、以下のようなエラーメッセージが出ることがあります。

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-10.png)

```
Run failed: object of type 'NoneType' has no len()
または
Run failed: Variable '' does not exist
```

どちらのエラーもDifyのエージェントノードの`CONTEXT`機能にまつわる不具合と思われますが、発生した場合は以下のステップで解消してください。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-13.png)

1. 画面左側の記号をクリックして、メニューを開く
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-11.png)

2. `DSLをエクスポート`をクリック
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-12.png)

3. ymlファイルをメモ帳などのテキスト編集ソフトで開く
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-14.png)

4. `agent_parameters`で検索をかけて、以下の修正を行う

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-15.png)

修正前
```
    context:
        type: variable
        value: ''
```

修正後
```
    context:
        type: mixed
        value: null
```

5. ymlファイルの変更を保存して、DSLをインポートする
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv02_ja/assets/chapter03/img/work15-16.png)


---

おつかれさまでした！
この実践課題を以て、生成AIプロンプトエンジニアリング講座を修了とします。
ここまで学習を進めてくださり、本当にありがとうございます。

この講座では、架空の企業GrowthTechに勤めるお悩みを抱えた社員たちを登場させました。きっとあなたの職場にも、似たような課題を抱えている方がいらっしゃるのではないでしょうか。この講座で学んだことが、そうした日々の小さな困りごとを解決するヒントになれば、これほど嬉しいことはありません。

プロンプトエンジニアリングは、特別な才能が必要なスキルではありません。コンテキストエンジニアリングという表現もされるように、こちらが持つコンテキストを十分に相手へ伝えるための言語化がカギになります。丁寧に言葉にして指示を出す、具体的に説明する、段階的に考えてもらう。こうした基本は、実は人と人とのコミュニケーションでも同じです。普段から相手の立場に立って物事を伝えようとしている方なら、きっとすぐに上達するはずです。

この講座で学んだテクニックを、ぜひ明日からの仕事で試してみてください。最初はうまくいかないこともあるかもしれません。AIが思った通りの答えを返してくれないこともあるでしょう。でも、それは失敗ではなく、AIとの対話を深めていくプロセスの一部です。試行錯誤を重ねながら、あなた自身のスタイルを見つけていってください。

最後になりましたが、この講座があなたのキャリアや日々の仕事に、少しでもお役に立てたなら幸いです。一人でも多くの方が、AIを活用して、もっと創造的で充実した仕事ができるようになることを願っています。急速に発展し続けるAIという強力な道具を、これからも楽しく学び続けていきましょう。

あなたの挑戦を、心から応援しています。

