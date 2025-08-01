# ワーク1: 情報整理の自動化 - 要約・議事録・FAQ作成

## サンプル課題

あなたは、あるプロジェクトの定例会議に参加しました。以下は、その会議の音声認識ツールが書き起こしたテキストです。
この書き起こしテキストを元に、AIを使って以下の3つの成果物を作成させるプロンプトを考えてください。

1.  会議全体の要約（300字以内）
2.  構造化された議事録（決定事項とToDoリストを含む）
3.  プロジェクトメンバー向けの想定FAQ

---
**【会議の書き起こしテキスト】**

「えー、皆さんお集まりいただきありがとうございます。本日のアジェンダは、新製品『AIアシストペン』のプロモーション計画についてです。まず、現状の進捗ですが、田中さんからお願いします。」
「はい、田中です。プロモーションサイトのワイヤーフレームが昨日完成しました。デザインチームからは、来週の水曜日までには初稿が上がってくるとのことです。ターゲット層は主に大学生と若手ビジネスパーソンを想定しています。」
「ありがとうございます。ターゲット層へのアプローチとして、何か具体的なアイデアはありますか？鈴木さん。」
「はい、鈴木です。大学生向けには、大学の生協と連携したキャンペーンや、人気YouTuberによるレビュー動画を考えています。特に教育系のYouTuberとのタイアップは効果が高いと見ています。ビジネスパーソン向けには、主要なビジネス系ニュースサイトへのプレスリリース配信と、SNS広告を強化したいです。特にLinkedIn広告が有効かと。」
「なるほど。YouTuberの選定とプレスリリースの準備は急ぎたいですね。では、YouTuberのリストアップと連絡は鈴木さんにお願いできますか？期限は来週末までで。」
「承知しました。リストアップ進めます。」
「プレスリリースについては、私がドラフトを作成し、来週月曜に皆さんに共有します。それを元に、佐藤さんが内容をブラッシュアップして、最終稿を来週金曜までに完成させる、という流れでいかがでしょうか。」
「佐藤です。承知いたしました。ドラフトお待ちしております。」
「ありがとうございます。他に何か懸念点はありますか？…なさそうですね。では、本日の会議は以上とします。次回は再来週の月曜10時からです。各自、ToDoを進めておいてください。お疲れ様でした。」

---

## 解説

### AIは情報整理の達人

大規模言語モデル（LLM）は、人間が書いた膨大な量のテキストを学習しているため、文章の構造や要点を把握するのが非常に得意です。この能力を活かせば、長文の要約、議事録の整理、FAQの作成といった、時間がかかりがちな情報整理タスクを劇的に効率化できます。

成功の鍵は、第2章で学んだ「構造化プロンプト」です。AIにどのような役割を期待し（**役割**）、何をインプットとして（**入力テキスト**）、どのようなルールで処理し（**指示**）、どのような形式で出力してほしいか（**出力形式**）を明確に伝えることで、期待通りの成果物を得ることができます。

:::_ Point
**情報整理を依頼する際の4つの要素**

1.  **役割 (Persona)**: 「優秀なビジネスアシスタント」「経験豊富な編集者」など、タスクに合った役割を与える。
2.  **入力テキスト**: 整理したい文章（議事録、記事、レポートなど）を明確に提示する。
3.  **指示 (Instructions)**: 「要約して」「構造化して」「ToDoを抽出して」など、具体的なアクションを指示する。文字数制限や必須項目などの制約条件も加える。
4.  **出力形式 (Output Format)**: Markdown、箇条書き、表形式など、希望するフォーマットを指定する。
:::

## サンプル課題解答

```markdown
あなたは、非常に優秀なビジネスアシスタントです。
以下の会議の書き起こしテキストを読み、指定された形式で情報を整理してください。

# 会議の書き起こしテキスト
（ここに上記の書き起こしテキストを貼り付ける）

# 指示
1.  会議の内容を300字以内で要約してください。
2.  以下の項目を含む議事録を作成してください。
    - 会議名: 新製品『AIアシストペン』プロモーション計画会議
    - 日時: (不明なため「不明」と記載)
    - 出席者: 田中、鈴木、佐藤、他 (不明な発言者)
    - 決定事項:
    - ToDoリスト: (項目、担当者、期限を明確に記載)
    - 次回会議予定:
3.  この議事録を読んだプロジェクトメンバーから出そうな質問を3つ想定し、FAQ形式で回答を作成してください。

# 出力形式
- 全体をMarkdown形式で記述してください。
- 各セクション（要約、議事録、FAQ）は見出し（`##`）で区切ってください。
```

### AIによる出力例

## 要約
新製品『AIアシストペン』のプロモーション計画に関する会議。プロモーションサイトのワイヤーフレームは完成し、来週水曜にデザイン初稿が上がる予定。ターゲット層である大学生へはYouTuberとのタイアップ、若手ビジネスパーソンへはプレスリリースとSNS広告でアプローチする方針が決定した。具体的なアクションとして、担当者と期限付きのToDoが設定され、次回会議は再来週月曜10時からとされた。

## 議事録
- **会議名**: 新製品『AIアシストペン』プロモーション計画会議
- **日時**: 不明
- **出席者**: 田中、鈴木、佐藤、他 (不明な発言者)
- **決定事項**:
    - ターゲット層（大学生、若手ビジネスパーソン）へのプロモーション方針を決定。
    - 大学生向け: YouTuberとのタイアップを実施。
    - ビジネスパーソン向け: ビジネス系ニュースサイトへのプレスリリース配信とSNS広告（特にLinkedIn）を強化。
- **ToDoリスト**:
    - 【項目】YouTuberのリストアップと連絡　【担当者】鈴木さん　【期限】来週末
    - 【項目】プレスリリースのドラフト作成・共有　【担当者】発言者(私)　【期限】来週月曜
    - 【項目】プレスリリースのブラッシュアップと最終稿作成　【担当者】佐藤さん　【期限】来週金曜
- **次回会議予定**:
    - 再来週の月曜日 10:00〜

## FAQ
**Q1. YouTuberタイアップの具体的な候補はもう決まっていますか？**
A1. 現時点ではリストアップ段階です。来週末までに鈴木さんが候補をリストアップし、連絡を取る予定です。

**Q2. プロモーションサイトのデザインは誰が確認するのですか？**
A2. 今回の議事録では言及されていませんが、デザイン初稿が来週水曜に完成予定のため、次回の会議までに確認プロセスを決定する必要があると考えられます。

**Q3. プレスリリースの配信先はいつ決まりますか？**
A3. 来週月曜に共有されるドラフトを元に、佐藤さんが内容をブラッシュアップする過程で、配信先の選定も進められると想定されます。最終稿が完成する来週金曜までには決定される見込みです。