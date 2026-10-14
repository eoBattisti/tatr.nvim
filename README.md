# tatr.nvim

This project is a simple wrapper for [tatr](https://github.com/tsoding/tatr), basic an issue tracker inside the repository itself,
the goal for this plugin is to make it easier to create, handle and interact with tasks within Neovim.

This is done simply with a command named `Tatr` and its subcmds alongside with the Neovim's builtin quickfix mode.

## Design Decisions

#### Why using qflist intead of other plugin pickers

While developing this plugin I wanted it to be small, human maintainable and with as fewer dependencies as possible.
Altough it's true that having pickers would be really convienient, I feel that Neovim's builtin quickfix list can serve
this pourpose very well.

## Instalation

- using lazy.nvim

```
return {
    event = "CmdlineEnter"
    "eoBattistti/tatr.nvim",
}
```

# Usage

```
:Tatr <SUBCMD> [ARGS]
```

## List of subcommands

- `Tatr find <HUID> [OPTIONS]`
- `Tatr init [OPTIONS]`
- `Tatr ls [OPTIONS] [QUERY]`
- `Tatr new [OPTIONS] [TITLE]`
- `Tatr ref <HUID>`
- `Tatr summary [OPTIONS]`
- `Tatr untag [OPTIONS] [QUERY]`

## Tatr find
This subcommand can be used to find the TASK.md file of any task
and it can be done in two different ways:

Options:

- `-path-only`: print only path to the TASK.md;

1. Entering cmdline and typing the task huid:
```
:Tatr find 20260101-000000
```

2. Entering visual mode and then entering the command mode from the selected huid:
```
:'<'>Tatr find
```

## Tatr init
This subcommand creates the `tasks` directory to start creating tasks and managing it.

Options:

- `-no-readme`: Do not create default `README.md` in the `./tasks/` folder.

Example:

- `:Tatr init -no-readme`

## Tatr ls
This subcommand can be used to list all `OPEN` tasks in the repository,
the output will be displayed in the quickfix list,

Options:

- `-c`: list closed tasks;
- `-a`: list tasks in ascending order;
- `-id`: sort tasks by id;

## Tatr new
This subcommand is used to create new tasks in the repository.

Options:

- `-t`: Tags to add to the new task;
- `-p`: Priority of the new task;
- `-s`: Task ID optional suffix;

Examples:

- `:Tatr new my simple task`
- `:Tatr new -t mytag a second task`
- `:Tatr new -t mytag -t myothertag third task`
- `:Tatr new -p 1 a fourth task with big priority`
- `:Tatr new -s myusername a fifth task`

## Tatr ref
This subcommand can be used to list all references in the codebase of a given task.
This is useful to quickly scan the codebase and identify where/what the task affects.

Examples:

- `:Tatr ref 20260101-000000`

But the most useful way to identify all refs of a task in the codebase is to navigate
to the `TASK.md` file and entering the cmdline:

- `:Tatr ref` or `:Tatr ref %`

## Tatr summary
This subcommand summarizes the information about the tasks in the repository.

Options:

- `-c`: List closed tasks;

Examples:

Running: `:Tatr summary` will display a similar output to:
```
STATUS:   OPEN
TOTAL:    4
TAGGED:
    mytag =>   2
    myothertag =>   2
```

## Tatr untag
This subcommand is useful to remove tags from one or many `TASK.md` files.

Options:

- `-t`: Tags to remove from the tasks;
- `-c`: List closed tasks;

Examples:

- `:Tatr untag -t mytag :tag`



#### Subcommands output table

| Subcommand | Output |
|------------|--------|
|`find`|`quickfix`|
|`init`|`print`|
|`ls`|`quickfix`|
|`new`|`quickfix`|
|`ref`|`print`|
|`untag`|`print`|


Note: All commands that have its output to `quickfix` will open up the quickfix automatically.

<!-- 20261013-183939: section: possible keymappings -->

# License
This project is licensed under the MIT License.
