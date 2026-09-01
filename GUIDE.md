# Running Computational Philosophy

## Prerequisites

You need SWI-Prolog installed. Get it here: https://www.swi-prolog.org/

```bash
# macOS (via Homebrew)
brew install swi-prolog

# Ubuntu/Debian
sudo apt-get install swi-prolog

# Windows
# Download installer from https://www.swi-prolog.org/download/stable
```

## Run the engine

```bash
swipl computational_philosophy.pl
```

You should see:

```
--- INITIAL CONSENSUS ---
auntу_dot disagrees with david
auntу_dot disagrees with emma
david disagrees with emma

--- MATHEMATICAL REVISIONS ---
david processed the evidence through NAND: false -> true
auntу_dot processed the evidence through NAND: true -> false

--- INNER OWLS ---
auntу_dot's Inner Owl state (false):
    ,__,
    (-,-)  <- "Hoot... I do not buy it."
    /)
   ""  ""

david's Inner Owl state (true):
    ,__,
    (O,O)  <- "Hoot! The truth is out there!"
    /)
   ""  ""

emma's Inner Owl state (unknown):
    ,__,
    (O,-)  <- "Hoot? Who knows?"
    /)
   ""  ""
```

## What happened?

1. **Initial state**: Three people, three beliefs
2. **Evidence arrives**: Strange smell observed by Aunty Dot and David (but not Emma)
3. **NAND gate processes**: Each person's belief is updated through `nand(initial_belief, evidence, new_belief)`
4. **Minds change**: 
   - David was skeptical (false) but saw evidence → now believes (true)
   - Aunty Dot believed (true) but saw evidence → now skeptical (false)
   - Emma never observed → stays unknown
5. **Inner owls speak**: Each person's final belief state is drawn as an owl

## Modify the system

Try changing:

- **Initial beliefs**: Edit the `believes/3` facts
- **Observations**: Add or remove `observes/2` facts
- **Consensus rules**: Modify `agrees/2` and `disagrees/2`
- **The NAND gate**: Change the `nand/3` truth table (but this breaks the physics!)

## Questions to explore

- What happens if Emma observes the smell too?
- What if we use a different logic gate (AND, OR, XOR)?
- Can we add more people? More ghosts?
- What if some people are lying about their observations?

🦉✨
