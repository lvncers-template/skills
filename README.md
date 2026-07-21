# skills

`lvncers-template/ai-configs`（Claude Code ハーネス）向けの Skills 本体を管理するリポジトリ。

`ai-configs` 側の `.claude/skills-lock.json` からこのリポジトリを参照し、`npx skills add lvncers-template/skills -s <name> -a claude-code --copy -y` でローカルに取り込む。
移行の背景・全体像は [ai-configs の documents/SKILLS_MIGRATION.md](https://github.com/lvncers-template/ai-configs/blob/main/documents/SKILLS_MIGRATION.md) を参照。

## Skills 一覧

| skill                        | パス                                                | フェーズ | disable-model-invocation |
| ----------------------------- | ---------------------------------------------------- | -------- | ------------------------- |
| `worktree-list`                | `skills/worktree/worktree-list/SKILL.md`             | P1       | 未指定（自動起動可）      |
| `pr-review`                    | `skills/github/pr-review/SKILL.md`                   | P1       | 未指定（自動起動可）      |
| `pr-review-commit-driven`      | `skills/github/pr-review-commit-driven/SKILL.md`     | P1       | 未指定（自動起動可）      |
| `test-run`                     | `skills/testing/test-run/SKILL.md`                   | P2       | 未指定（自動起動可）      |
| `test-write`                   | `skills/testing/test-write/SKILL.md`                 | P2       | 未指定（自動起動可）      |
| `commit`                       | `skills/git/commit/SKILL.md`                         | P2       | `true`                    |
| `git-sync`                     | `skills/git/git-sync/SKILL.md`                       | P3       | `true`                    |
| `branch`                       | `skills/git/branch/SKILL.md`                         | P3       | `true`                    |
| `issue-create`                 | `skills/github/issue-create/SKILL.md`                | P3       | `true`                    |
| `pr-create`                    | `skills/github/pr-create/SKILL.md`                   | P3       | `true`                    |
| `worktree-create-new-branch`   | `skills/worktree/worktree-create-new-branch/SKILL.md`| P3       | `true`                    |
| `worktree-create-already-onremote` | `skills/worktree/worktree-create-already-onremote/SKILL.md` | P3 | `true`               |
| `worktree-remove`              | `skills/worktree/worktree-remove/SKILL.md`           | P3       | `true`                    |
| `setup-init-bare`              | `skills/worktree/setup-init-bare/SKILL.md` (+ `scripts/`) | P3  | `true`                    |
| `submodule-remove`             | `skills/git/submodule-remove/SKILL.md`               | P3       | `true`                    |
| `slide-draft`                  | `skills/slides/slide-draft/SKILL.md`                 | -        | 未指定（自動起動可）      |
| `slide-slidev`                 | `skills/slides/slide-slidev/SKILL.md`                | -        | 未指定（自動起動可）      |
