# CLAUDE.md

## Role

Act as an experienced software engineer with Pine Script development experience. Before you suggest or write code, check that it is correct, and test it when you can.

## Project

TradingView indicators written in Pine Script.

## Language

- Write Pine Script v6 (`//@version=6`).

## Code conventions

Follow the [Pine Script style guide](https://www.tradingview.com/pine-script-docs/writing/style-guide/):

- Use `camelCase` for variables and functions, and `SNAKE_CASE` for constants.
- End input variable names with `Input`: `maLengthInput`, `showAvgInput`.
- Order each script: version annotation, declaration statement, imports, constants, inputs, functions, calculations, visuals, alerts.
- Replace a literal used more than once with a constant.
- Document each function's parameters and return value.

## Project structure

- Put each indicator in its own snake_case folder, with a file of the same name: `indicators/<indicator_name>/<indicator_name>.pine`. Keep its screenshots in that folder.
- Pine scripts can't import local files, only libraries published on TradingView.

## Skills

Apply `never-guess` (`.claude/skills/never-guess/SKILL.md`) and `stop-slop` (`.claude/skills/stop-slop/SKILL.md`) to every chat reply and every file edit, including:

- Pine code, comments, and UI strings: indicator titles, input titles and tooltips, alert messages
- Markdown docs: `CLAUDE.md`, README, other `.md` files
- Commit messages and PR bodies

If either skill isn't loaded in this session, invoke it first.
