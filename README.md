# tatr.nvim

This project is a simple wrapper for [tatr](https://github.com/tsoding/tatr) with the goal to be even easier to create/manage
tasks in the project within neovim.

## Instalation

- using lazy.nvim

```
return {
    "eoBattisti/tatr.nvim",
}
```

## Usage

```
:Tatr <SUBCMD> [ARGS]
```

### List of subcommands

- `Tatr find <HUID> [OPTIONS]`
- `Tatr init [OPTIONS]`
- `Tatr ls [OPTIONS] [QUERY]`
- `Tatr new [OPTIONS] [TITLE]`
- `Tatr ref [HUID]`
- `Tatr summary [OPTIONS]`
- `Tatr untag [OPTIONS] [QUERY]`


## License

This project is licensed under the MIT License.
