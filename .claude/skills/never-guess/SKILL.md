---
name: never-guess
description: Research-before-answer discipline. Checks every fact an answer or code change depends on at its source in the current session, and reports "I could not verify this" when no source is reachable. Use for any question, explanation, recommendation, Pine Script code, TradingView built-in, indicator math, or tool and config behavior. Pairs with double-check, which runs the verify-until-clean loop for review requests.
---

# Never Guess

- Answer only from facts you checked this session: files you read, commands you ran, official docs you fetched.
- Memory, earlier replies, plans, and blog posts don't count as sources.
- When no source is reachable, write "I could not verify this".
- When the request has two readings, ask before you research.

## Sources for this repo

| Topic | Source |
| --- | --- |
| Pine v6 concepts and syntax | [User Manual](https://www.tradingview.com/pine-script-docs/) |
| v5 patterns that break in v6 | [Migration guide](https://www.tradingview.com/pine-script-docs/migration-guides/to-pine-version-6/) |
| Built-in signatures and defaults | [Reference Manual](https://www.tradingview.com/pine-script-reference/v6/). WebFetch can't read it (JS-rendered); use the User Manual page for that built-in |
| Compile status | TradingView Pine Editor. Label code as not compiled until the user runs it there |

For verify or review requests, also invoke `double-check`.
