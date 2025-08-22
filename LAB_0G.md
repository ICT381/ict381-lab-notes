# Lab - Markdown Tutorial

## Introduction
Markdown is a lightweight markup language for formatting plaintext. It's widely used for writing documentation, blog posts and README files due to its simplicity and readability. This lab covers the basic syntax that you will most likely use while creating your own README file.

## Why Use Markdown?
-   **Simple Syntax**: Easy to learn and write.
-   **Platform Independent**: Can create markdown formatted text on any device running any operating system.
-   **Readable Source**: Markdown files are human readable even though it is not rendered.


## Getting Started
To write Markdown, you can use text editor (eg. VSCode). Save the file with a `.md` extension. You can try online editor like [Markdown Live Preview](https://markdownlivepreview.com/) for real-time previews.


## Basic Syntax

### Headings
Use `#` to create headings (1 to 6 levels):
```markdown
# Heading 1
## Heading 2
### Heading 3
```
**Output**:

# Heading 1
## Heading 2
### Heading 3

### Paragraphs
Write text naturally. Separate paragraphs with a blank line:
```markdown
This is a paragraph.

This is another paragraph.
```

### Emphasis
Use `*` or `_` for italic and bold text:
```markdown
*Italic* or _Italic_
**Bold** or __Bold__
```
**Output**: *Italic* or **Bold**

### Lists
#### Unordered Lists
Use `-`, `*`, or `+` for bullet points:
```markdown
- Item 1
- Item 2
  - Subitem
```
**Output**:
- Item 1
- Item 2
    - Subitem

#### Ordered Lists
Use numbers followed by a period:
```markdown
1. First item
2. Second item
```
**Output**:
1. First item
2. Second item

### Links
Create links with `[text](URL)`:
```markdown
[Google](https://www.google.com)
```
**Output**: [Google](https://www.google.com)

### Images
Add images with `![alt text](URL)`:
```markdown
![Markdown Logo](https://markdown-here.com/img/icon32.png)
```
**Output**: 

![Markdown Logo](https://markdown-here.com/img/icon32.png)

### Code
Inline code uses backticks (`):
```markdown
Use `print("Hello")` in Python.
```
**Output**: Use `print("Hello")` in Python.

Code blocks use triple backticks (```):
```python
def hello():
    print("Hello, Markdown!")
```

### Tables
Create tables with pipes (`|`) and dashes (`-`):
```markdown
| Name  | Age |
|-------|-----|
| Alice | 25  |
| Bob   | 30  |
```
**Output**:
| Name  | Age |
|-------|-----|
| Alice | 25  |
| Bob   | 30  |


### Blockquotes
Use `>` for quotes:
```markdown
> This is a blockquote.
```
**Output**:
> This is a blockquote.

---

### Preview in VScode
*   When you are writing Markdown in VSCode, you can click on **Open Preview to the Side** button to display the preview on your right. The button is visible on the top right of the editor bar. It resembes a document with a magnifying glass.

### References:

1. [The Only Markdown Crash Course You Will Ever Need](https://www.youtube.com/watch?v=_PPWWRV6gbA)
2. [Markdown Guide Basic Synax](https://www.markdownguide.org/basic-syntax/)
3. [GitHub Basic Formatting Syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

---

**Congratulations!** You should have mastered the basics of writing Markdown.
