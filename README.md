# grd -- Learning D by Writing A Command Line App.

Small grep clone, ported from `Learning Rust by Writing A command Line App`.

## How to run

```console
$ dub run -- <pattern> <path>
```

For example,

```console
$ dub run -- main src/app.d
(...)
    void main() {}
int main(string[] args)
```

## Testing

### Running unit tests

```console
$ dub test
```

### Running integration tests

```console
$ dub test --main-file tests/cli.d
```