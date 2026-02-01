---
name: copy-checker
description: Reviews and corrects textual copy in code files (blog posts, articles, guides, prose) for British English spelling, grammar, clarity, and consistency. Use when reviewing written content, checking articles, or when the user asks to proofread copy.
---

## Purpose

Check textual copy embedded in code files for:
- British English spelling and grammar
- Clarity and readability
- Consistency in tone, terminology, and style
- Proper punctuation and sentence structure

## Workflow

If $ARGUMENTS is a file or directory path, check the copy in the file specified, or the files in the specified directory. If $ARGUMENTS is not set, ask what file or directory to check.

### 1. Initial Review
First, read through the copy and identify issues:
- Spelling errors (ensure British English: "colour" not "color", "organise" not "organize")
- Grammar mistakes
- Unclear or awkward phrasing
- Inconsistent terminology or tone
- Punctuation errors
- Overly complex sentences that could be simplified

### 2. Present Findings
Summarise issues found by category:
- **Spelling**: List American spellings or typos
- **Grammar**: Highlight grammatical errors
- **Clarity**: Note confusing or wordy sections
- **Consistency**: Point out terminology or tone variations
- **Style**: Suggest improvements for readability

Provide specific examples with line numbers or context.

### 3. Suggest Improvements
For each issue, suggest the correction:
- Show the current text
- Explain the problem
- Provide the improved version
- Justify why the change improves the copy

### 4. Offer Implementation
After presenting suggestions, offer to implement the changes.

If approved, make the changes whilst preserving:
- Code structure and formatting
- Indentation and whitespace
- Any template syntax or variables
- Comments (unless they're part of the copy being reviewed)

## Key Principles
- **British English first**: Default to British spellings, date formats (DD/MM/YYYY), and conventions
- **Clarity over cleverness**: Prefer simple, direct language
- **Consistency matters**: Maintain uniform terminology and tone throughout
- **Respect the author's voice**: Improve without completely rewriting unless requested
- **Context awareness**: Consider the intended audience and purpose

## Common British English Spellings
- -ise endings: realise, organise, recognise (not -ize)
- -our endings: colour, favour, behaviour
- -re endings: centre, metre, theatre
- Double consonants: travelling, cancelled, focussed
- Other: grey (not gray), programme (not program, except computing)

## Formatting Checks
- Consistent heading hierarchy
- Proper use of quotation marks and apostrophes
- Consistent list formatting (bullets, numbering)
- Appropriate paragraph breaks
