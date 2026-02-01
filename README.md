# Claude Code Configuration Examples

For an introduction to Claude Code features, visit [www.elliotjreed.com/ai/claude-code-guide-and-tips](https://www.elliotjreed.com/ai/claude-code-guide-and-tips).

This repository contains example configuration files for [Claude Code](https://claude.com/product/claude-code), demonstrating how to customise and extend the CLI tool.

## Configuration Files

### CLAUDE.md

The `CLAUDE.md` file provides instructions to Claude Code.

A `CLAUDE.md` file is normally per-project, but you can also have a user-level `CLAUDE.md` file to provide general instructions across multiple project.

The [`CLAUDE.md`](CLAUDE.md) file in this repository is an example of a user-level one to be located at `~/.claude/CLAUDE.md`.

In it is outlined:
- **Context**: Operating system and location details, compliance requirements (e.g., GDPR)
- **Workflow**: Planning requirements for features and changes
- **Style**: Code style preferences (self-documenting code, clean architecture, British English spelling)
- **Considerations**: Security priorities (OWASP Top 10, secure coding practices)
- **Tool Usage**: Restrictions on tool usage (e.g., read-only git commands)

### settings.json

Claude Code's main configuration file located at `~/.claude/settings.json`. This example demonstrates:

- **Environment Variables**: Disable telemetry or set custom environment variables
- **Authentication**: Force specific login methods (`claudeai` or `anthropic`)
- **Model Selection**: Choose default model (`opusplan`, `sonnet`, `opus`, `haiku`)
- **Permissions System**: Fine-grained control over Claude's actions
  - `allow`: Commands that run without prompting (file operations, package managers, git read operations)
  - `deny`: Blocked operations (e.g., reading sensitive files like `.env`)
  - `ask`: Commands requiring explicit user approval (destructive operations, network requests, git write operations)
- **Status Line**: Configure the status line display (see `statusline-command.sh`)

The permissions system uses pattern matching: `Bash(command:*)` matches any bash command starting with `command`.

### statusline-command.sh

Custom status line script that displays contextual information in the Claude Code interface. This example shows:

- **Session Information**: Abbreviated session ID
- **Workspace Details**: Current directory name
- **Git Integration**: Current branch, uncommitted changes indicator
- **Model Information**: Active model name
- **Context Window**: Visual progress bar and percentage showing remaining context
- **Colour Coding**: Dynamic colours based on context remaining (green > 50%, yellow > 25%, red ≤ 25%)

Configure the status line in `settings.json` with:
```json
{
  "statusLine": {
    "type": "command",
    "command": "/path/to/statusline-command.sh",
    "padding": 0
  }
}
```

The script receives JSON input via stdin containing session and workspace information.

### skills/

Directory containing custom skill definitions. Skills extend Claude Code with specialised behaviours:

- **copy-checker/**: Reviews written content for British English spelling, grammar, and clarity
- **react-optimiser/**: Optimises React components and code (example skill)

Each skill contains a `SKILL.md` file defining:
- Skill name and description
- When to invoke the skill
- Behaviour and capabilities
- Usage examples

Skills are stored globally at `~/.claude/skills/` or per-project at `./.claude/skills/`.

## Usage

1. **Global Configuration**: Place files in `~/.claude/`
   - `~/.claude/settings.json`
   - `~/.claude/CLAUDE.md`
   - `~/.claude/skills/`

2. **Project Configuration**: Place files in your project
   - `./CLAUDE.md` (committed to version control)
   - `./.claude/settings.json` (project-specific overrides)
   - `./.claude/skills/` (project-specific skills)

3. **Customisation**: Copy these examples and modify them to suit your workflow

## Resources

- [Claude Code Tips and Tricks](https://www.elliotjreed.com/ai/claude-code-guide-and-tips)
- [Claude Code Documentation](https://code.claude.com/docs/en)
- [Claude Code Settings Reference](https://code.claude.com/docs/en/settings)
- [General AI Promptin Guide](https://www.elliotjreed.com/ai/ai-prompt-engineering-guide)
- [CAFE Promting Framework](https://www.elliotjreed.com/ai/cafe-ai-prompt-framework)
