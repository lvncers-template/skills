# skills

`lvncers-template/ai-configs`（Claude Code ハーネス）向けの Skills 本体を管理するリポジトリ。

`ai-configs` 側の `.claude/skills-lock.json` からこのリポジトリを参照し、`npx skills experimental_install` でローカルに取り込む。
移行の背景・全体像は [ai-configs の documents/SKILLS_MIGRATION.md](https://github.com/lvncers-template/ai-configs/blob/main/documents/SKILLS_MIGRATION.md) を参照。

## Skills 一覧

| skill                       | パス                                          | フェーズ | disable-model-invocation |
| ---------------------------- | --------------------------------------------- | -------- | ------------------------- |
| `grill-with-docs`            | `skills/planning/grill-with-docs/SKILL.md`    | P1       | 未指定（自動起動可）      |
| `worktree-list`               | `skills/worktree/worktree-list/SKILL.md`      | P1       | 未指定（自動起動可）      |
| `pr-review`                   | `skills/github/pr-review/SKILL.md`            | P1       | 未指定（自動起動可）      |
| `pr-review-commit-driven`     | `skills/github/pr-review-commit-driven/SKILL.md` | P1    | 未指定（自動起動可）      |
