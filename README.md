# Claude Code Status Line Configuration

  A ready-to-use custom status line for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that displays
  real-time session info directly in your terminal.

  ## What it shows

  `main | myproject | Sonnet 4.6 | ctx: 42% | $0.35 | 5h: 18% (3h24m) | week: 5%`

  - **Git branch** — current worktree branch
  - **Directory** — basename of working directory
  - **Model** — active model display name
  - **Context usage** — how full your context window is
  - **Session cost** — total USD spent this session
  - **5-hour rate limit** — usage percentage + time until reset
  - **Weekly rate limit** — 7-day usage percentage

  ## Installation

  1. Clone this repo:
     ```bash
     git clone https://github.com/JavidanValiyev/claude-code-statusline

  2. Copy `settings.json` and `statusline-command.sh` files to your Claude Code config directory (~/.claude/):
  
  3. Restart Claude Code. The status line appears at the bottom of your terminal.

  Customization

  Ask claude code that you want to costumize you statusline and follow the instraction.

  Colors use standard ANSI escape codes and can be changed at the top of the script.

  Requirements

  - Claude Code (https://docs.anthropic.com/en/docs/claude-code) CLI
  - Bash (Git Bash on Windows)

  Keywords

  claude code, claude code status bar, claude code statusline, claude cli, anthropic cli, claude code terminal, claude
  code configuration, claude code settings, claude code rate limit, claude code context usage, claude code session cost

  **GitHub topics to add:** `claude-code`, `claude`, `anthropic`, `cli`, `terminal`, `statusline`, `developer-tools`

  Keywords section at bottom helps Google index. Topics help GitHub search. Repo description covers main search queries
  people would type.
