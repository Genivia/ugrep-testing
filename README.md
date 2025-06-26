# ugrep pattern match testing and validation

## Setup

Compile two small utilities `pick` and `trickle` to support the tests:
```console
$ ./setup.sh
```

## Run

Run the extensive barrage of tests, which can take hours to complete:
```console
$ ./run.sh
...
OK
```
Reports `OK` or halts when an error is detected, where `temp_words.txt` is the set of words seaarched as a pattern and `temp_results.txt` is the output with a problem.

The bulk of the tests are designed go through all possible pattern match methods and optimizations.  This is independent of the ugrep command line options.  The SIMD optimizations with which ugrep was compiled are tested, when SIMD is enabled, which is one of SSE2, AVX2, AVX512BW, NEON, or AArch64.

## Data

- `words` extracted from `enwik8` with `ugrep -iwo '[a-z]+' enwik8 | sort -u > words`
- `enwik8` 100MB Wikipedia file

Note: we pick words of a specific byte length or within a byte length range to test with.  Therefore, we test with ASCII words only to match byte lengths.  This has no impact on validation of the internal byte-based pattern match methods that don't care what bytes represent, i.e. ASCII or UTF-8 or raw binary.
