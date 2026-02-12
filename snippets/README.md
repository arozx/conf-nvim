# Custom Snippets for Neovim

This directory contains custom snippets that are automatically loaded by LuaSnip in VSCode JSON format.

## How It Works

The snippets are loaded via the `friendly-snippets` configuration in `init.lua`. The following line loads all `.json` files from this directory:

```lua
require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }
```

## Directory Structure

```
snippets/
├── README.md          # This file
├── lua.json           # Lua snippets
├── python.json        # Python snippets
├── go.json            # Go snippets
├── javascript.json    # JavaScript snippets
├── java.json          # Java snippets
└── [language].json    # Add more languages as needed
```

## Snippet File Format

Each snippet file follows the VSCode snippet JSON format:

```json
{
  "Snippet Name": {
    "prefix": "trigger",
    "body": [
      "line 1",
      "line 2 with ${1:placeholder}",
      "line 3 with ${0:final cursor position}"
    ],
    "description": "What this snippet does"
  }
}
```

### Key Components:

- **prefix**: The trigger text you type to activate the snippet
- **body**: Array of lines (or single string) that will be inserted
- **description**: Shows up in the completion menu
- **Placeholders**: `${1:default}`, `${2:next}`, etc. - Use Tab to jump between them
- **Final position**: `${0}` marks where the cursor ends up

## Using Snippets

1. **In Insert Mode**: Type the snippet prefix and you'll see it in the completion menu
2. **Select**: Use `<C-n>` and `<C-p>` to navigate, or continue typing
3. **Confirm**: Press `<C-y>` to insert the snippet
4. **Navigate Placeholders**: Use `<C-l>` to jump forward, `<C-h>` to jump backward through placeholders
5. **Edit**: Type your content at each placeholder

### Example Workflow:

In a Python file:
1. Type `def` → snippet appears in completion menu
2. Press `<C-y>` to confirm
3. Type the function name → Press `<C-l>`
4. Type the arguments → Press `<C-l>`
5. Type the docstring → Press `<C-l>`
6. Cursor is now in the function body

## Adding New Snippets

### Method 1: Add to Existing File

Edit the appropriate language file (e.g., `python.json`):

```json
{
  "Your Snippet Name": {
    "prefix": "yourprefix",
    "body": [
      "your code here",
      "${1:first placeholder}",
      "${0:final position}"
    ],
    "description": "Description here"
  }
}
```

### Method 2: Create New Language File

Create a new file named `[filetype].json` (e.g., `rust.json`, `cpp.json`):

```json
{
  "First Snippet": {
    "prefix": "trigger1",
    "body": "snippet content",
    "description": "What it does"
  },
  "Second Snippet": {
    "prefix": "trigger2",
    "body": ["line 1", "line 2"],
    "description": "Another snippet"
  }
}
```

**Important**: The filename must match the Neovim filetype (check with `:set filetype?`)

### Method 3: Global Snippets (All Files)

Create `all.json` or `global.json` for snippets that work in any filetype:

```json
{
  "TODO Comment": {
    "prefix": "todo",
    "body": "// TODO: ${0:description}",
    "description": "Add TODO comment"
  }
}
```

## Advanced Snippet Features

### Variables

You can use VSCode snippet variables:

- `$TM_FILENAME` - Current filename
- `$TM_FILENAME_BASE` - Filename without extension
- `$TM_DIRECTORY` - Current directory
- `$CURRENT_YEAR` - Current year
- `$CURRENT_DATE` - Current date

Example:
```json
{
  "File Header": {
    "prefix": "header",
    "body": [
      "/**",
      " * File: $TM_FILENAME",
      " * Author: Your Name",
      " * Date: $CURRENT_DATE",
      " */",
      "",
      "${0}"
    ],
    "description": "Add file header"
  }
}
```

### Choice Placeholders

Provide multiple options:

```json
{
  "Log Level": {
    "prefix": "log",
    "body": "logger.${1|debug,info,warn,error|}('${2:message}')",
    "description": "Logger with level choice"
  }
}
```

### Transformations

Transform placeholder text:

```json
{
  "Class with Constructor": {
    "prefix": "classc",
    "body": [
      "class ${1:ClassName}:",
      "    def __init__(self):",
      "        \"\"\"Initialize ${1/(.*)/${1:/downcase}/}.\"\"\"",
      "        ${0:pass}"
    ],
    "description": "Class with constructor and transformed docstring"
  }
}
```

## Reloading Snippets

After editing snippet files, reload them with:

```vim
:LuaSnipUnlinkCurrent
:source $MYVIMRC
```

Or simply restart Neovim.

## Troubleshooting

### Snippets Not Showing Up

1. Check filetype: `:set filetype?`
2. Ensure JSON is valid (use a JSON validator)
3. Restart Neovim: `:qa` then reopen
4. Check for errors: `:messages`

### Wrong Filetype

If snippets aren't loading for a language, check the filetype with `:set filetype?` and ensure your JSON file matches that name.

### Snippet Conflicts

If multiple snippets have the same prefix, they'll all appear in the completion menu. Use more specific prefixes to avoid conflicts.

## Example Snippets Included

- **Lua**: Functions, requires, loops
- **Python**: Functions, classes, main block, try/except
- **Go**: Functions, methods, structs, error handling
- **JavaScript**: Arrow functions, promises, async/await
- **Java**: Classes, methods, loops

## Resources

- [LuaSnip Documentation](https://github.com/L3MON4D3/LuaSnip)
- [VSCode Snippet Syntax](https://code.visualstudio.com/docs/editor/userdefinedsnippets)
- [Friendly Snippets](https://github.com/rafamadriz/friendly-snippets)

