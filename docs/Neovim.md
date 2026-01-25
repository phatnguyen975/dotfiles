<div align="center">
  <h1>Neovim Cheat Sheet</h1>
  <sub>
    Author: Nguyễn Tấn Phát <br>
    April 30, 2025
  </sub>
</div>

## 1. Fundamentals

So you have made the decision to jump into Neovim, and looking for a place to get started. Like any new skill, learning the first few basics can seem challenging, but once you get past them you will become proficient with Neovim in no time. At that point, the adrenaline rush that comes with Neovim proficiency leaves us wanting more, and at this critical juncture new users can take one of two paths:

- The first path looks a bit like this:
  <ol type="1">
    <li>Search the internet to see all of the cool configurations people show off</li>
    <li>Install a bunch of popular plugins</li>
    <li>Copy and paste snippets of code into their configuration file</li>
    <li>Get frustrated because things stop working as expected</li>
    <li>Conclude that Neovim is difficult</li>
  </ol>
- The second path looks a bit like this:
  <ol type="1">
    <li>Learn stock Neovim to understand the basics of using the editor</li>
    <li>Identify specific improvements that can be made to suit your workflow</li>
    <li>Assess a few potential solutions then select the solution that works the best for you</li>
    <li>Continue working until another improvement is identified</li>
    <li>Iterate as your skill level and needs evolve over time</li>
  </ol>

In other words, mastering Neovim is more of a marathon than a sprint. It helps to start by understanding what you want to achieve with Neovim. Are you looking for a full IDE, or a text editor? Are you drawn to Neovim for its speed and efficiency, or do you plan to configure every last aspect of how it works? Each of us will have slightly different answers.

As such, we rely on Neovim as an excellent text editor, then use other tools to manage our git repositories, etc. When it makes sense to do so, we can create a thin wrapper within Neovim to provide just the functionality that we need within Neovim. We generally limit our plugins to only those that truly provide unique functionality that we can't achieve with stock Neovim or with our own personal plugins or user-commands.

Regardless of your philosophy, our goal is to start from the basics and slowly build proficiency with Neovim, then progress to more advanced topics such as configuration and plugins.

### Starting Neovim

Neovim supports a variety of options that can be used to define how Neovim starts up. These options can be used to define the initial buffer content, which configuration file to load, and many others.

The most basic option is to invoke Neovim directly:

```sh
nvim
```

When called with no arguments, Neovim starts up with default configuration, and with an empty buffer. Let's look at a few of the other options that are available.

**Starting with Files Loaded into Buffers**

When called with no arguments, Neovim starts up with an empty buffer. To start Neovim with an existing loaded into a buffer simply add the file's path as an argument:

```sh
nvim [path/to/file]
```

Neovim also supports opening multiple files, by specifying the paths to each of them:

```sh
nvim [path/to/file/one] [path/to/file/two] ...
```

Neovim also supports [globbing](<https://en.wikipedia.org/wiki/Glob_(programming)>), which allows multiple files to be opened on startup by specifying a "blog" pattern. For example, to open all python files located in the current directory, simply type:

```sh
nvim *.py
```

**Specifying a Configuration File**

Neovim follows the [XDG Base Directory](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) specification, which defines a group of environment variables that specify where applications load and store configuration files and other information. This topic is discussed in detail in the configuration section.

However, there are various times when you might want to specify a specific configuration file. For example, this can be helpful while you are debugging your configuration or developing a plugin. You can direct Neovim to load a specific configuration file on startup by specifying the `-u` option:

```sh
nvim -u [path/to/file]
```

**Read-Only Mode**

There are many cases where we want to open and inspect a file, but make sure that we make no changes to it. This is a common command-line action using a "pager" utility, such as [less](<https://en.wikipedia.org/wiki/Less_(Unix)>), except provides the benefit of supporting your Neovim configuration, such as your personal keymaps.

Start Neovim in read-only mode by specifying the `-R` option and a path to a file:

```sh
nvim -R [path/to/tile]
```

After doing so you will be able to review and navigate through the file, but while you can still make change's you will get warnings, and you won't be able to save those changes (unless you take extra steps to override the read-only feature).

**Piping Standard Input to Neovim**

Although we tend to think of Neovim as a full-blown application, it is after still a command-line command and can be executed as such. For example, we can create pipelines that read from an input source, transform it in some way, then pipe it into Neovim over stdin so that the buffer contains the transformed content, which can be leveraged to create some very powerful workflows.

As a simple example, let's echo some simple text to stdin, pipe it into Neovim, then save the result to a file. This can all be done with the following command:

```sh
echo "Hello World!" | nvim - +':wq output.txt'
```

The key think here is to use Neovim's `-` option to tell it to listen on stdin, then its `+` option that tells Neovim to execute a command (`:wq` in this case) after loading its input. Executing this script produces the following `output.txt` file:

```text
Hello World!
```

**Executing Lua Scripts**

Neovim has integrated a Lua interpreter, which is used for configuration and plugins, but this allows Neovim to be used as a Lua execution environment. To demonstrate let's look at a simple script:

```lua
vim.print("Hello World!")
```

Which executes, prints a message to stderr, then exits:

```text
Hello World!
```

**Other Options & Getting Help**

Neovim supports a wide range of options to control how it starts and which features are enabled. While they may not all be used on a daily basis, it is good to know that they exist and how to find them. You can list some of the common options from the terminal with the command:

```sh
nvim --help
```

or visit the [Neovim docs](https://neovim.io/doc/user/starting.html#starting) for the complete list.

### Modes

**Normal Mode**

One of the defining features of Neovim is that it is a "modal" editor, meaning that its behavior and features are defined by the current mode. Neovim starts in `normal` mode, which is the primary mode for navigating documents and running commands, and where users typically spend most of their time.

In `normal` mode, key-presses don't add text to the editor. Instead, they perform actions, such as moving the cursor, executing commands, or switching buffers, which we will review in the coming sections.

In most cases, when working with other modes one starts in `normal` mode, switches to another mode to perform a task, then returns to `normal` mode. The following table lists the most common modes in Neovim, including a brief cheatsheet for how to enter each mode from `normal` mode. To return to `normal` mode from the other modes, simply hit `Esc`.

|          Mode          | Short Name | Enter Mode |
| :--------------------: | :--------: | :--------: |
|      Insert Mode       |    `i`     |    `i`     |
|      Replace Mode      |    `R`     |    `R`     |
|      Visual Mode       |    `v`     |    `v`     |
|    Visual-Line Mode    |    `V`     |    `V`     |
|   Visual-Block Mode    |   `C-v`    |   `C-v`    |
|   Command-Line Mode    |    `c`     |    `:`     |
| Returns to Normal Mode |    `n`     |   `Esc`    |

For a full list of Neovim modes, simply type `:h mode()`.

**Insert Mode**

As you might guess, `insert` mode is used to insert text into the buffer.

The most common way to switch from `normal` mode to `insert` mode is to type `i`, but this is such a common operation that Vim provides a variety of commands that fine-tune how it does so. Additionally, each of these commands accepts an optional `count`:

| Command |                                                        Action                                                        |
| :-----: | :------------------------------------------------------------------------------------------------------------------: |
|   `i`   |                                       Insert text before the cursor `N` times                                        |
|   `a`   |                                        Append text after the cursor `N` times                                        |
|   `s`   |                       (substitute) Delete `N` characters [into register `x`] and start insert                        |
|   `I`   |                              Insert text before the first `CHAR` on the line `N` times                               |
|   `A`   |                                   Append text after the end of the line `N` times                                    |
|   `S`   |                       Delete `N` lines [into register `x`] and start insert; synonym for `cc`                        |
|   `C`   | Change from the cursor position to the end of the line, and `N - 1` more lines [into register `x`]; synonym for `c$` |

As shown in the table above, each of these commands has a "capitalized" version that has a similar behavior, but performed on the line-level. It can be a big benefit to practice each of these and commit them to muscle memory.

**Replace Mode**

Neovim's `replace` mode is similar to `insert` mode, except typing characters replaces any existing characters, rather than inserting them. When typing reaches the end of a line, `replace` mode simply inserts the new characters.

You can find more details about `replace` mode in the [Neovim docs](https://neovim.io/doc/user/insert.html#Insert).

**Visual Mode**

Neovim's visual modes are used to "visually select" content within a buffer. Vim has three different variations of visual modes, where each option interprets the selection region slightly differently from the others.

- The first mode is simply called `visual` mode. Enter `visual` mode by pressing `v`.
- The second of Vim's visual modes is called `visual-line` mode. Enter `visual-line` mode by pressing `V`.
- The last of Vim's visual modes is called `visual-block` mode. Enter `visual-block` mode by pressing `C-v`.

The key observations are:

- The selection starts from the upper-most cursor location (the cursor location when the editor entered `visual` mode), and includes all content to the right of the starting cursor location.
- The selection ends at the lower-most cursor location (the current cursor location), and includes all content to the left of the ending cursor location.
- All lines between the two cursor locations (if present) are included in the selection.

**Command-Line Mode**

Enter `command-line` mode from `normal` mode by typing `:`, which opens the command line at the bottom of the screen, and awaits further input.

You are actually already familiar with many `command-line` mode commands. For example, when we write to a file `:w` we are using `command-line` mode to interact with the filesystem.

### Buffers

A buffer is an in-memory representation of text that can be edited. A buffer can be empty, or it can contain the content of a file. When a buffer contains the content of a file, it contains a copy of that content; edits made in the buffer do not change the original file, unless the buffer contents are saved back to the original file.

Buffers can exist in several states, where the most common are:

|                                                                                                                                        Active                                                                                                                                        |                                                          Hidden                                                           |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------: |
| A buffer that is displayed in a window. If this buffer is associated with a file, its content has been read into the buffer, and the buffer is given the name of that file. If the buffer has been modified since the file was read its content may different from that of the file. | A buffer that is not currently displayed. Hidden buffers are the same as active buffers, they are just currently visible. |

Buffers are held in a buffer list, where each buffer is assigned a unique number that persists throughout a session and can be used to identify and navigate between buffers.

**Note:** Neovim will not allow you to exit if there is a buffer that is both hidden and modified, which can cause confusion with new users and has led to various memes. This is done to protect you from losing edits, if you try to exit when there are unsaved edits Neovim will raise a warning and activate that buffer so that that you can choose to save that content or throw it away with the `:quit!` command.

**Creating Buffers**

You can open files and create buffers using a variety of commands:

| Command |           Action           |        Pattern         |
| :-----: | :------------------------: | :--------------------: |
| `:edit` |        Edit a file         | `:edit [path/to/file]` |
| `:read` |  Read file into the text   | `:read [path/to/file]` |
| `:new`  | Create a new empty window  |                        |
| `:enew` | Edit a new, unnamed buffer |                        |

Commands that take paths generally accept both relative and absolute paths.

The commands summarized above each perform similar tasks, but the `:read` command offers and extra bit of functionality that can be useful in some situations: in addition to accepting a path as an argument, `:read` can also insert the output of shell commands into the current buffer. For example, to insert the current time into Vim one might execute:

```sh
:read !date '%T'
```

which inserts the current time at the current cursor location.

You might have noticed that when a file is loaded into a buffer, the buffer takes the name of the file. So what happens when an empty buffer is opened? In that case, the buffer is called a **no-name** buffer. No-name buffers are just like any other buffers, and the content can be saved to a file or simply thrown away. No-Name buffers convert to regular when they are saved, at which point they take the name of the file to which they were saved.

**Navigating Buffers**

An editing session often requires having several buffers open simultaneously, which may or may not be contained in separate windows. Neovim provides a variety of ways to navigate between buffers, allowing one to edit multiple buffers efficiently.

Here is a quick summary of some of the command-line commands that can be used to navigate between buffers:

|   Command    |                           Action                            |      Pattern       |
| :----------: | :---------------------------------------------------------: | :----------------: |
|    `:ls`     |                      List all buffers                       |                    |
|  `:bfirst`   |            Go to first buffer in the buffer list            |       `:bf`        |
| `:bprevious` |          Go to previous buffer in the buffer list           |       `:bp`        |
|   `:bnext`   |            Go to next buffer in the buffer list             |       `:bn`        |
|   `:blast`   |            Go to last buffer in the buffer list             |       `:bl`        |
| `:bmodified` | Go to next buffer in the buffer list that has been modified |       `:bm`        |
|  `:buffer#`  |                 Switch to alternate buffer                  |       `:b#`        |
|  `:bdelete`  |            Remove a buffer from the buffer list             |       `:bd`        |
|  `:bdelete`  |            Remove a buffer from the buffer list             |  `:bd [buf name]`  |
|  `:bdelete`  |            Remove a buffer from the buffer list             | `:bd [buf number]` |

where:

- `[buf name]` represents the name of a buffer,
- `[buf number]` represents a buffer number, and
- no qualifier represents the present buffer

These commands are often bound to keymaps to provide convenient access to them, allowing buffers to be navigated efficiently.

**Saving Buffers**

Edits to buffer text need to be saved to disk to make them persistent. Neovim provides a few ways to save buffer content, and even portions of buffer content, to files.

The most common way to save buffer contents is the following:

| Command  |     Action      |          Pattern          |
| :------: | :-------------: | :-----------------------: |
| `:write` | Write to a file | `:w[rite] [path/to/file]` |

To save the content from a **no-name** buffer to a file, simply add a filename to the `:write` command:

```sh
write /path/to/file
```

This saves the current buffer content into the specified path, then updates the buffer to reflect the filename.

Although not particularly useful in most cases, it is still useful to note that ranges can be applied to saving files. For example, if we had a file with 10 lines of content and in which every line was modified in some way, we could choose to write only the changes on lines 5–9, by using the following command:

```sh
:5,9w!
```

### Windows

If buffers refer to the file contents stored in memory, then windows are the viewport through which the buffer content is viewed.

**Splitting Windows**

To demonstrate splits, open a relatively long file into a buffer then execute `C-w s`, which creates a **horizontal split** dividing the current window into upper and lower sections.

Now, type `i` to enter insert mode then type a few characters. These edits appear simultaneously in both split windows, which indicates that both windows provide views to the same buffer content.

Next, return to normal mode by hitting `Esc`, then hit `G` to move the cursor to the bottom of the buffer. Although each window shows the same document, but each can view (and edit) a different part of the document at the same time.

Finally, execute the `C-w v` command to **vertically split** the current window into two side-by-side windows, providing a third view to the current buffer.

Vim also allows one to open a file into a buffer, then display it in either a horizontal or vertical split. These are performed using the `:split` and `:vsplit` command-line commands:

```sh
:split path/to/file
:vsplit path/to/file
```

**Note:** If the paths are omitted these commands show the current buffer in the new splits, which is the same functionality of the `C-w s` and `C-w v` commands.

**Navigating Windows**

Now that we have a few splits open, lets review basic navigation between windows. Window navigation combines the `C-w` prefix with the familiar `h`, `j`, `k`, `l` pattern:

| Command |                    Action                    |
| :-----: | :------------------------------------------: |
| `C-w j` |   Go N windows down (stop at last window)    |
| `C-w k` |    Go N windows up (stop at first window)    |
| `C-w h` | Go to Nth left window (stop at first window) |
| `C-w l` | Go to Nth right window (stop at last window) |

**Closing Windows**

Now that we have created a few splits and learned how to navigate between them, let's close them. Execute `C-w c` to close the current split window, then execute `C-w c` a second time to get back to our original view, containing a single window.

### Tabs

Up to now, we have known that buffers are in-memory representations of files, and windows provide viewports that allow one or more buffers to be viewed at a time in splits. Thinking back to our discussion about windows, we started with a single window, then added a few splits to create a layout. The collection of windows in the layout fills up the screen, and the full screen could be considered a page of windows. Neovim allows you to define and switch between multiple pages of windows by organizing them into tabs.

Here is a list of some of the more common tab-related commands.

|    Command     |                     Action                     |
| :------------: | :--------------------------------------------: |
|   `:tabnew`    |         Edit a file in a new tab page          |
|     `:tab`     |     Create new tab when opening new window     |
|    `:tabs`     |    List the tab pages and what they contain    |
|  `:tabclose`   |             Close current tab page             |
|   `:tabonly`   |   Close all tab pages except the current one   |
| `:tabprevious` |            Go to previous tab page             |
|   `:tabnext`   |              Go to next tab page               |
|   `:tabNext`   |            Go to previous tab page             |
|   `:tabmove`   |        Move tab page to other position         |
|  `:tabfirst`   |              Go to first tab page              |
|   `:tablast`   |              Go to last tab page               |
|   `:tabfind`   | Find file in `path`, edit it in a new tab page |

### Commands

Interacting with content in Vim is generally performed using commands. Command is a fairly broad term in Vim, and applies to a wide variety of commands, used for navigation, editing, etc. Commands can take several forms depending on the context such as the current mode:

- In normal mode, commands are made up of one or more operators, counts, motions, and text objects, and general follow one of the following patterns:

```sh
[count]{operator}{[count]motion}
[count]{operator}{text object}
```

- In command-line mode, commands are issued in the command-line, and are typically of the form:

```sh
:[range]{command} [args]
```

Commands are less-common in insert mode, but those that are available are typically of the form:

```sh
<C-{operator}>
```

This format is also common for commands that affect menus and the like.

**Operators**

Within the command, the operator defines the action to be taken, which generally involved changing of deleting text in some way. Here is a quick summary of the available operators:

| Command |                       Action                        |
| :-----: | :-------------------------------------------------: |
|   `c`   |                   Change operator                   |
|   `d`   |                   Delete operator                   |
|   `y`   |                    Yank operator                    |
|   `~`   |           Swap case (if `tildeop` is set)           |
|  `g~`   |                      Swap case                      |
|  `gu`   |                 Change to lowercase                 |
|  `gU`   |                 Change to uppercase                 |
|   `!`   |         Filter through an external program          |
|   `=`   | Filter through `equalprg` or `C-indenting` if empty |
|  `gq`   |                   Text formatting                   |
|  `gw`   |       Text formatting with no cursor movement       |
|  `g?`   |                   ROT13 encoding                    |
|   `>`   |                  Shift text right                   |
|   `<`   |                   Shift text left                   |
|  `zf`   |                    Define a fold                    |

Some operators are so commonly used that Vim allows an entire command to be comprised of just the operator. When an operator is repeated twice, then that operation is performed over the current line of text. Here are few common examples:

| Command |                     Action                     |
| :-----: | :--------------------------------------------: |
|  `yy`   |             Yank the current line              |
|  `cc`   | Delete the current line then enter insert mode |
|  `dd`   |            Delete the current line             |

**Motions**

Motions, on the other hand, define the direction or movement over which that action will take effect. Some motions can take effect without an operator. For example, in normal mode the `j` and `k` motions move the cursor up and down. In general, however, an operator is required for the motion to take effect.

- **Line-wise motions** are those that effect an entire line. Line-wise motions are inclusive, meaning that they always include the lines that contain the start and end positions.
- **Character-wise motions** operate on characters within a line. Examples of character-wise motions are the horizontal motions. Character-wise motions are further split into two sub-types:
  - Inclusive character motions are those that include the start and end positions in the text over which the operator operates.
  - Exclusive motions are those that exclude the end position (the character that is closest to the end of the buffer) from the text over which the operator operates.

You can convert a line-wise motion to a character-wise motion, or vice-verse by inserting one of the following characters after the operator, and before the motion:

| Command |              Action              |
| :-----: | :------------------------------: |
|   `v`   | Force operator to work charwise  |
|   `V`   | Force operator to work linewise  |
|  `C-v`  | Force operator to work blockwise |

Additionally, if `v` is used with a character-wise motion, it changes inclusive motions to exclusive motions, and vice-versa.

**Counts**

Counts have two jobs in commands, based upon where they are located in the command.

- When placed in front of the motion counts are multipliers of that motion. For example, to delete a word one can use `dw` (short for delete word). To delete multiple words, we can add a count in front of the motion. For example, let's try executing `d4w` (literally, delete 4 words).
- When placed in front of the entire command, it means repeat the entire command count times. So, let's try executing `4dw`, which means delete a word, repeating 4 times.
- Counts can also be located in both places. For example, we can achieve the same result a 3rd way using `2d2w`, which means delete two words, repeating twice.

### Ranges

**Simple Ranges**

Commands that run in command-line mode often accept a range, which specifies which line(s) of the current buffer are to be used as input for the command. The general pattern for specifying a range is:

```sh
:[from],[to]{command}
```

where `from` and `to` specify the start and end of the range, respectively, and `{command}` is the name of the command to be executed on those lines.

For example, to yank lines 2 through 5 to register `a`, one could specify:

```sh
:2,5y a
```

We already saw the most simple case, where `from` and `to` are defined as static line numbers. The next set of range expressions evaluate to dynamically specify lines in the buffer:

| Expression |           Meaning           |
| :--------: | :-------------------------: |
|    `$`     | The last line of the buffer |
|    `.`     |      The current line       |

These expressions can be used directly in place of line numbers in the range. For example, the following range expression defines a range that contains all lines in the buffer:

```sh
:1,$
```

This range is so common that there is an expression for that too, `%`. For example, to yank the entire buffer into register `a`, the following are equivalent:

```sh
:1,$y a
:%y a
```

**Ranges with Offsets**

Range expressions can contain offsets, which define the number of lines above or below the preceding expression. If no expression is given, then the offset is taken relative to the current line. Offsets are specified using either `+` or `-` followed by an optional number indicating the number of lines to add or subtract. If no number is specified, then 1 line is assumed.

The range of lines from 2 rows above the current line, to 3 lines below it:

```sh
:-2,+3
```

Offsets can also be combined with other expressions. For example, the range containing all lines between the current line to the 1 line from the bottom:

```sh
:.,$-1
```

**Visual Ranges**

If there is a visual mode or visual-line mode selection when entering command-line mode Neovim will insert the marks referencing it (`<`,`>`) before the cursor, so you can simply enter the desired command.

Neovim also remembers the previous visual selection, which can be referenced using `*`. For example, select some text, then hit `Esc` to return to normal mode. Move the cursor to another location in the buffer, then copy the previously-selected text to the cursor line using:

```sh
:*y b
```

**Ranges with Marks**

Since marks reference a location in the buffer, they can be used in range expressions too. For example, in the example mark `x` is defined in line 2. The range of lines from mark `x` to the current line is therefore given by:

```sh
:'x,.
```

or to select lines from the current line to the end of the current paragraph:

```sh
:.,'}
```

Marks can also be combined with offsets. To select lines from the current paragraph except for the first and last:

```sh
:'{+1,'}-1
```

**Ranges with Searches**

Range expressions can also reference lines that match a specified pattern. As with searching in other contexts, `/` is used for forward search, and `?` is used for backwards searches. Use patterns with the format:

```sh
[line]/{pattern}/
[line]?{pattern}?
```

where `line` specifies which line to start searching from (default the current line), and `{pattern}` is the pattern to search for. When specified, `line` can be an absolute number, or another expression that evaluates to a line number.

For example, the range of lines between the first line that matches `/find/` and line 5 is given by:

```sh
:/find/,5
```

Suppose we wanted to skip a few lines of text before starting the search. For example, if we are editing a markdown document that contains meta information at the top of the file we may want to skip that content then search only the body text. If we know that the meta information is 3 lines long, the following range expression could be used:

```sh
:4/find/,$
```

Rather than starting the search from a fixed line, we can specify the starting line as a pattern as well. This allows us to search the buffer for a specific condition, then search for the pattern that will start the range, then proceed to the end of the range. For example, to start from the line matching `/anything/`, then search for the first line matching `/obsessed/` and include lines until the first line matching `/venerable/` we could use the following:

```sh
:/anything//obsessed/,/venerable/
```

You can also search backwards from the line containing the cursor. For example, if the cursor is on line 4 and you want the range of lines between the first preceding line that matches `?search?` and the current line:

```sh
:?search?,.
```

and finally, the range of lines between the first preceding line that matches `?search?` and the next line that matches `/venerable/`:

```sh
:?search?,/venerable/
```

### Help

Neovim includes an extensive help system, which provides a significant amount of detail about virtually any vim-related topic. To open the help system, from normal mode enter the command:

```sh
:help
```

The help contents for a specific topic or command by adding the topic or command when invoking the help system. For example, to review the documentation for the help system itself:

```sh
:help help
```

Help contents often contain links to other help topics. To review the linked content, move the cursor over the link and type `C-]`.

Once in the help system you can manually jump to other topics using the `tag` command:

```sh
:tag [topic]
```

where `topic` refers to the help topic you want to jump to.

Return to the previous help topic by invoking `C-t`.

Exit the help window and return to the original window by typing `C-w c` or `:quit`.

### Exiting

Although the various ways to exit Vim might not be obvious to new users, it is actually quite simple. The basic command for exiting is `:quit`, which has several variations, summarized in the table below:

| Command  |                     Action                     | Alias  |
| :------: | :--------------------------------------------: | :----: |
| `:quit`  | Quit current window (when one window quit Vim) |  `:q`  |
| `:quit`  | Quit current window (when one window quit Vim) | `:q!`  |
|   `ZQ`   |          Close window without writing          |        |
|  `:wq`   |     Write to a file and quit window or Vim     |        |
|   `ZZ`   |    Write if buffer changed and close window    |        |
| `:wqall` |     Write all changed buffers and quit Vim     | `:wqa` |

## 2. Navigating

### Basics

The most basic cursor movements (known as motions in Vim) are those used to move the cursor in small increments within a buffer. Most Vim distributions also support using the arrow keys for simple cursor movements, but it is good practice to ignore the arrows and get used to using these:

| Command |            Action             |
| :-----: | :---------------------------: |
|   `h`   | Cursor `N` chars to the left  |
|   `l`   | Cursor `N` chars to the right |
|   `j`   |   Cursor `N` lines downward   |
|   `k`   |    Cursor `N` lines upward    |

Now, suppose you want to move the cursor 4 columns to the right. One option is to type `l` 4 times, but Vim provides a better way, called counts. Vim motions accept a count, which precedes the motion and specifies how many times to repeat the motion, following the basic pattern:

```sh
[count][motion]
```

So, rather than hitting `l l l l`, one can simply type `4l`.

### Navigating Horizontally

**Within a Line**

Horizontal motions move the cursor in the same line that is being edited. These are the motions that are used while actively editing text or code, and therefore are some of the most commonly used motions.

We start with a few motions that move the cursor to absolute positions with the current line:

| Command  |                   Action                    |
| :------: | :-----------------------------------------: |
|   `0`    |    Cursor to the first char of the line     |
| `<Home>` |                 Same as `0`                 |
|   `^`    |    Cursor to the first CHAR of the line     |
|   `\|`   |            Cursor to column `N`             |
|   `gM`   | Go to character at middle of the text line  |
|   `g_`   | Cursor to the last CHAR `N - 1` lines lower |
|   `$`    |     Cursor to the end of Nth next line      |
| `<End>`  |                 Same as `$`                 |

The following motions are similar to those above, but move the cursor to absolute positions within the current (visible) screen:

| Command |                                                                                     Action                                                                                     |
| :-----: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|  `g0`   |           When `wrap` off go to leftmost character of the current line that is on the screen; when `wrap` on go to the leftmost character of the current screen line           |
|  `g^`   | When `wrap` off go to leftmost non-white character of the current line that is on the screen; when `wrap` on go to the leftmost non-white character of the current screen line |
|  `gm`   |                                                                  Go to character at middle of the screenline                                                                   |
|  `g$`   |          When `wrap` off go to rightmost character of the current line that is on the screen; when `wrap` on go to the rightmost character of the current screen line          |

For those of you not yet familiar with patterns, `$` in a pattern refers to the end of the pattern, which provides a useful mnemonic for remembering how to get to the end of the current line. `$` and `<End>` are equivalent, so use whichever feels most natural.

`$` (as well as `g_`) also accepts a count. When a count is used, Vim first moves the cursor down `[count - 1]` lines, then moves the cursor to the end of that line.

Similar to `$`, in patterns `^` refers to the start of the pattern, so makes a nice mnemonic to remember moving to the start of the line. `^` and `<Home>` are equivalent, so use whichever feels most natural.

Next, move the cursor to the middle of the current line. This could have also been accomplished using `|`. In general, `gM` provides a quick jump to the middle of the line, while `|` is useful when more precision is required.

**By Character**

### Navigating Vertically

### Folds

### Marks

### Jump List

### Change List

### Searching

### Command Line
