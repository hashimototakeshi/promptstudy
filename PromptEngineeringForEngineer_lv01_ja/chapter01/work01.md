---
seq: 3
title: まずは触ってみよう
slug: chapter01/work01
description: 生成AIの基本的な仕組みと特性を理解し、日常業務での活用イメージを持つ
type: work
relation: 
difficulty: 1
displayLanguage: ja
duration: 10
---

# まずは触ってみよう - ChatGPT、Gemini、Claudeを実際に使い比べ

**学習目標**: 生成AIの基本的な仕組みと特性を理解し、日常業務での活用イメージを持つ

## はじめに：3つの生成AIを体験してみよう

さっそく、主要な3つの生成AIモデル「ChatGPT-5」「Gemini 2.5 Pro」「Claude Sonnet 4」を実際に使い比べてみましょう。
各モデルへのアクセス方法（すべて無料で利用可能です）：

### **ChatGPT-5**: OpenAIのウェブサイト [chat.openai.com](https://chatgpt.com/)

![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv01_ja/img/ch1_w1_gpt1.png "")

サインアップまたはログインすると、プロンプト入力画面に遷移します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv01_ja/img/ch1_w1_gpt2.png "")

### **Gemini 2.5 Pro**: GoogleのGeminiウェブサイト [gemini.google.com](https://gemini.google.com/app?hl=ja)

Googleアカウントでログインすることでプロンプト入力画面に遷移します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv01_ja/img/ch1_w1_gemini.png "")

### **Claude Sonnet 4**: AnthropicのClaudeウェブサイト[claude.ai](https://claude.ai/new)
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv01_ja/img/ch1_w1_claude1.png "")

サインアップまたはログインすると、プロンプト入力画面に遷移します。
![](https://chataniakinori-no1s.github.io/prompt_engineering/PromptEngineering_lv01_ja/img/ch1_w1_claude2.png "")

## 3つのモデルの開発理念と特徴

**ChatGPT-5 (OpenAI)**
- 開発理念: AGI（汎用人工知能）の実現と、その恩恵を広く社会に提供すること
- 特徴: 幅広いタスクに対応できる汎用性の高さ。論理的推論、創造的な文章生成、コーディング支援など、多様な用途で高い性能を発揮

**Gemini 2.5 Pro (Google)**
- 開発理念: Googleの検索技術とデータ基盤を活用した、マルチモーダル対応の高度なAI
- 特徴: 大規模なコンテキスト処理能力（100万トークン）と、最新の情報（2025年1月末まで）を反映した知識ベース

**Claude Sonnet 4 (Anthropic)**
- 開発理念: Constitutional AI（憲法AI）による安全性と有用性の両立
- 特徴: 倫理的配慮と安全性を重視した設計。自然で読みやすい日本語表現が得意で、ビジネス文書作成において高品質な出力を生成

## サンプル課題
:::sample-quiz
各モデルのウェブサイトにアクセスし、以下の質問を投げかけてみましょう：
```
日本企業の生産性を向上させるための具体的な施策を3つ提案してください
```

3つのモデルすべてに同じ質問をして、回答の違いを観察してください。
- 回答が始まるまでの時間
- 文章の書き方や構成
- 提案内容の具体性
- 日本語の自然さ
:::

## 解説：なぜモデルごとに回答が違うのか

同じ質問でもモデルごとに異なる回答が返ってくる理由は、主に以下の3つの要因によるものです：

1. **学習データ**: 各モデルが学習した膨大なテキストデータの種類や量の違い。ChatGPT-5は2024年9月まで、Gemini 2.5 Proは2025年1月末までの情報を学習しています。

2. **追加学習 (RLHF)**: 人間からのフィードバックを元に、より望ましい応答をするように調整される過程の違い。各社が重視する価値観が反映されています。

3. **システムプロンプト**: AI開発者によってあらかじめ設定された、AIの振る舞いを決めるための「隠れた指示」の違い。安全性、創造性、正確性などのバランスが異なります。

また、以下のベンチマーク表にある通り各モデルの性能によっても違いが出てきます。

## 主要生成AIモデルの性能比較（2025年最新ベンチマーク）

| 比較項目 | ChatGPT-5 | Gemini 2.5 Pro | Claude Sonnet 4 | 備考 |
|---------|-----------|----------------|-----------------|------|
| **総合知能指数** | 66% | 60% | 44% | Artificial Analysis Intelligence Index（高いほど優秀） |
| **コンテキストウィンドウ** | 入力400Kトークン/出力128Kトークン | 入力1Mトークン/出力6.5Kトークン | 入力200Kトークン/出力128Kトークン | 一度に処理できる情報量 |
| **ナレッジカットオフ** | 2024-09-30 | 2025-01-31 | - | 学習データの最終更新日 |
| **応答速度** | 100.0 tokens/秒 | 85 tokens/秒 | 42 tokens/秒 | 出力の速さ（高いほど速い） |
| **数学 (AIME 2025)** | 94.6% | 83.0% | 70.5% | 高校数学競技レベルの問題 |
| **コーディング (SWE-bench)** | 74.9% | 63.2% | 72.7% | ソフトウェア開発の問題解決能力 |
| **推論能力 (GPQA)** | 85.7% | 83.0% | 75.4% | 大学院レベルの推論テスト |
| **一般知識 (MMLU)** | 84.2% | 79.6% | 74.4% | 幅広い分野の知識テスト |
| **API料金 ($/1M tokens)** | 入力$1.25/出力$10 | 入力$1.25-2.50/出力$10-15 | 入力$3/出力$15 | 100万トークンあたりの価格 |

出典：Artificial Analysis

## 目的別・最適モデル選択ガイド

用途に応じた最適モデル選択例は以下の通りです。
「とりあえず有名なモデルを使う」よりも、自分の目的や業務に合ったモデルを選ぶことが、生産性を大きく左右します。
特に、ビジネス用途での利用を想定する場合には、価格やセキュリティ、データの取り扱い方針を含めた慎重な選定が重要です。

* **高度な推論・数学的問題**: ChatGPT-5（総合知能指数66%、数学AIME 94.6%）
* **コーディング支援**: ChatGPT-5（SWE-bench 74.9%）、次点でClaude Sonnet 4（72.7%）
* **大規模文書の処理**: Gemini 2.5 Pro（1Mトークン入力対応）
* **高速な大量文章生成**: ChatGPT-5（100 tokens/秒）
* **読みやすい日本語文書作成**: Claude Sonnet 4（自然な日本語表現）
