---
name: setup-init-bare
description: 新規プロジェクトを bare リポジトリ + worktree 構成でセットアップする。ワークスペースの新規作成という大きな操作のため、ユーザーが明示的に依頼したときに使う。
disable-model-invocation: true
---

# bare リポジトリでの初期セットアップ

## 概要

新規プロジェクトを bare リポジトリ + worktree 構成でセットアップする。
ワークスペースルートに `.claude/` `.cursor/` `CLAUDE.md` `.mcp.json` `skills-lock.json` を配置し、bare clone、skills インストール、`main` worktree 作成までを一括で行う。

`.claude` が無い場所でこのスキル自体は呼べない（配布の鶏卵問題）。すでに `.claude` が使えるディレクトリ（別プロジェクトの workspace-root や、このリポジトリ自身）から実行し、隣に新しいワークスペースを作る運用を想定する。

## 完成形

```txt
<workspace-root>/
├── .claude/              # ai-configs から配布
├── .cursor/               # ai-configs から配布
├── .agents/                # skills インストール後に自動生成
├── CLAUDE.md
├── .mcp.json
├── skills-lock.json
├── <project>.git/        # bare clone したリポジトリ
└── main/                   # main ブランチの worktree
```

## 入力

| input          | required | 内容                                                              |
| -------------- | -------- | ------------------------------------------------------------------ |
| repo_url       | true     | bare clone するリポジトリの URL                                   |
| workspace_root |          | ワークスペースルートのパス（未指定ならカレントディレクトリ）      |
| project_name   |          | bare リポジトリのディレクトリ名（未指定なら `repo_url` から推測） |

## 手順

手順が多く一つずつ手打ちすると事故りやすいため、同梱スクリプトを使う。

```sh
bash scripts/init-bare-workspace.sh <repo_url> [workspace_root] [project_name]
```

スクリプトは以下を順に行う。

1. ワークスペースルートを作成し、`repo_url` を bare clone する
2. `remote.origin.fetch` を設定し、`refs/remotes/origin/*` を補う（`git clone --bare` は素の状態だとこれを作らないため）
3. ai-configs テンプレートから `.claude` `.cursor` `CLAUDE.md` `.mcp.json` を取得する
4. `.cursor/skills-lock.json` を `./skills-lock.json` にコピーし、`npx skills experimental_install` を実行する
5. `main` ブランチの worktree を作成する
6. `git worktree list` と `ls -la` で結果を表示する

実行後、`.claude` `.cursor` `.agents` `CLAUDE.md` `.mcp.json` `skills-lock.json` `<project_name>.git` `main` が揃っていることを報告する。

対象は新規ワークスペースなので上書きガードは組み込んでいない（既存ワークスペースへの再配布は `documents/SETUP.md` を使う）。

## gitignore（配布先リポジトリ側）

`documents/SETUP.md` の tarball / clone パターンと同様、`main` worktree 内の `.gitignore` に追記する。

```gitignore
.claude/
.cursor/
.agents/
CLAUDE.md
skills-lock.json
```

`.mcp.json` はプレースホルダを埋めた実体をコミット管理するため gitignore しない。
