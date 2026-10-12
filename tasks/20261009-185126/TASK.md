# Tatr ref does not run properly when used from a task file

- STATUS: CLOSED
- PRIORITY: 100
- TAGS:

When I try to run `:Tatr ref` without any arguments in the cmdline from any `TASK.md` file
I get the following error message:

```bash
[ERROR] You are not inside any task folder. Pass the ID of a task as an argument to search for referers of that task.
```

Consequentially this will affect also commands like:
- `Tatr find`

---

We could also try to support something like `Tatr ref %` so we look for the given file the user is in
