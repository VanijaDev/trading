<!-- CLAUDE.md is a markdown file you add to your project root that Claude Code reads at the start of every session. Use it to set coding standards, architecture decisions, preferred libraries, and review checklists. Claude also builds auto memory as it works, saving learnings across sessions without you writing anything. -->

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Development and testing of indicators using Pine Script for TradingView.

## Language

- Write Pine Script v6 (`//@version=6`).
- Check syntax and built-ins against the v6 User Manual: https://www.tradingview.com/pine-script-docs/

## Skills

Invoke the `stop-slop` skill (`.claude/skills/stop-slop/SKILL.md`) before you draft, edit, or review any prose, including:

- Markdown docs: `CLAUDE.md`, README, other `.md` files
- Pine code comments and UI strings: indicator titles, input titles and tooltips, alert messages
- Commit messages and PR bodies
- Your chat replies
