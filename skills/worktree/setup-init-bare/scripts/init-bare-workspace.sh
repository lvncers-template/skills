#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "usage: $0 <repo_url> [workspace_root] [project_name]" >&2
  exit 1
fi

repo_url="$1"
workspace_root="${2:-.}"
project_name="${3:-$(basename "$repo_url" .git)}"

mkdir -p "$workspace_root"
cd "$workspace_root"

echo "==> bare clone: $repo_url -> $workspace_root/$project_name.git"
git clone --bare "$repo_url" "$workspace_root/$project_name.git"

echo "==> configuring remote-tracking refs"
git --git-dir="$workspace_root/$project_name.git" config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
git --git-dir="$workspace_root/$project_name.git" fetch --prune origin

echo "==> fetching ai-configs harness (.claude / .cursor)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

git clone --depth 1 -b main git@github.com:lvncers-template/ai-configs.git "$tmp_dir/ai-configs"

cp -R "$tmp_dir/ai-configs/.claude" "$workspace_root/.claude"
cp -R "$tmp_dir/ai-configs/.cursor" "$workspace_root/.cursor"
cp "$tmp_dir/ai-configs/.claude/CLAUDE.md" "$workspace_root/CLAUDE.md"
cp "$tmp_dir/ai-configs/.mcp.json" "$workspace_root/.mcp.json"

echo "==> installing skills"
cd "$workspace_root"
rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install

echo "==> creating main worktree"
git --git-dir="$workspace_root/$project_name.git" worktree add "$workspace_root/main" main

echo "==> done"
git --git-dir="$workspace_root/$project_name.git" worktree list
ls -la "$workspace_root"
