# ugrep pattern match testing and validation

## Setup

Compile two small utilities `pick` and `trickle` to support the tests:
```console
$ ./setup.sh
```

## Run

```console
$ ./run.sh
...
OK
```
Reports `OK` or halts when an error is detected, where `temp_words.txt` is the set of words seaarched as a pattern and `temp_results.txt` is the output with a problem.

## Data

- `words` extracted from `enwik8` with `ugrep -iwo '[a-z]+' enwik8 | sort -u > words`
- `enwik8` 100MB Wikipedia file

Note: we pick words of a specific byte length or within a byte length range to test with.  Therefore, we test with ASCII words only to match byte lengths.  This has no impact on validation of the internal byte-based pattern match methods that don't care what bytes represent, i.e. ASCII or UTF-8 or raw binary.
