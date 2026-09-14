---
name: pine-code-review
description: Reviews Pine Script changes in this repo along two axes. Standards checks the code against CLAUDE.md conventions, the Pine style guide, v6 rules, repainting causes, and Pine limits. Spec checks the detection logic against the pattern the user described. Runs both reviews in parallel sub-agents and reports them side by side. Use when the user asks to review an indicator, a diff, uncommitted work, or changes since a commit.
---

# Pine Code Review

Review the changes since a fixed point, or the indicator files the user names, on two axes:

- **Standards**: does the code follow this repo's conventions and Pine's rules?
- **Spec**: does the code detect the pattern the user asked for?

Run each axis in its own sub-agent, then report both.

## 1. Pin the fixed point

If the user names an indicator or file instead of a fixed point, review those files in full and skip the rest of this step.

Use the commit, branch, or tag the user names. If they name none, use `HEAD`.

- Confirm it resolves: `git rev-parse <fixed-point>`.
- Diff: `git diff <fixed-point>`. This form includes uncommitted edits.
- Commits: `git log <fixed-point>..HEAD --oneline`.
- Untracked files: `git status --short`. `git diff` never shows untracked files, so pass every untracked `.pine` file to the sub-agents in full.

Stop and tell the user if the ref doesn't resolve, or if the diff and the untracked `.pine` files are both empty.

## 2. Find the spec

Look in this order:

1. The pattern description the user gave in this conversation.
2. Screenshots in the indicator's folder, `indicators/<indicator_name>/`.
3. Ask the user. If no spec exists, skip the Spec sub-agent and say so in the report.

## 3. Collect the standards

- `CLAUDE.md`: the "Code conventions" and "Project structure" sections.
- The [Pine Script style guide](https://www.tradingview.com/pine-script-docs/writing/style-guide/).
- The Pine checks and smell baseline below.

No compiler or linter runs in this repo, so report anything the compiler would reject.

A CLAUDE.md convention overrides a smell. Report each smell as a judgement call ("possible Data Clumps"), never as a violation.

### Pine checks

| Check | Flag | Source |
| --- | --- | --- |
| v6 rules | `bool` values passed to `na()`, `nz()`, or `fixnan()`; `transp` arguments (use `color.new()`); timeframe strings like `"D"` instead of `"1D"`; `ta.*()` calls inside `and`/`or` conditions, which lazy evaluation can skip; `[]` on literals or built-in constants | [v6 migration guide](https://www.tradingview.com/pine-script-docs/migration-guides/to-pine-version-6/) |
| Repainting | signals from unconfirmed realtime values; `request.security()` without both `expression[1]` and `lookahead = barmerge.lookahead_on`; `varip`; `timenow`; `barstate.isnew`; signals plotted on past bars | [Repainting](https://www.tradingview.com/pine-script-docs/concepts/repainting/) |
| Limits | more than 40 unique `request.*()` calls (64 on the Ultimate plan); more than 64 plot counts; more than 500 lines, labels, or boxes each; history references past 5,000 bars on most series | [Limitations](https://www.tradingview.com/pine-script-docs/writing/limitations/) |

### Smell baseline

- **Mysterious Name**: a variable, function, or type whose name hides what it holds or does. Fix: rename it per the style guide.
- **Duplicated Code**: the same logic appears twice. Fix: inside one script, extract a function. Across indicators, flag it only; Pine scripts can't import local files.
- **Data Clumps**: the same values travel together through several calls. Fix: bundle them in a user-defined type.
- **Primitive Obsession**: a string or int stands in for a fixed set of choices or a domain concept. Fix: use an enum or a user-defined type.
- **Repeated Switches**: the same `switch` or `if` chain on the same value appears more than once. Fix: move it into one function both sites call.
- **Speculative Generality**: inputs, parameters, or functions the spec doesn't need. Fix: delete them.

## 4. Spawn both sub-agents in parallel

Sub-agents can't see this conversation, so paste everything they need.

**Standards sub-agent**, include:

- The review target from step 1: the diff command, the commit list, and the untracked `.pine` file paths, or the named file paths.
- The CLAUDE.md sections, the style guide URL, the Pine checks table, and the smell baseline, in full.
- The brief: "For each file, report: (a) each break of a CLAUDE.md convention or style guide rule, citing the rule; (b) each Pine check hit, citing the source URL; (c) each smell, named, with the code quoted. Mark (a), v6 rule breaks, and limit breaks as violations. Mark repainting risks and smells as judgement calls. Report anything the compiler would reject. Under 400 words."

**Spec sub-agent**, include:

- The review target from step 1.
- The spec: the user's pattern description, verbatim, and the screenshot paths.
- The brief: "Compare each detection condition with the pattern, candle by candle. Report: (a) pattern rules the code misses or covers partly; (b) conditions the pattern doesn't call for; (c) conditions that test the wrong thing, such as the wrong bar offset or comparison. Quote the pattern rule for each finding. Under 400 words."

## 5. Report

Show the two reports under `## Standards` and `## Spec`, verbatim or lightly cleaned. Keep the axes separate: code can follow every convention and detect the wrong pattern, or the reverse.

End with one line: the finding count per axis and the worst finding within each axis.
