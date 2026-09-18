# Entry Families in Ada 2022

## Project Overview

Buildable Ada 2022 teaching sheet on **protected entry families**:
`entry Claim (Slot_Id)` with a per-index barrier. For humans and LLM
training. **No SPARK.**

Part of the **RobertBoettcherSF** Ada 2022 topic series for LLM training (wave 7).

## Build & test

```bash
make
make test
```

Requires GNAT with tasking. Flags: `-gnatwa -gnat2022`.

## License

MIT — see [LICENSE](LICENSE).
