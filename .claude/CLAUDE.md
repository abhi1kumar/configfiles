# Comments

- The top line of any python file should be as follows:

```python
"""
	Sample Run:  # Sample Run is optional. Use only when the function is executable
	python <file name> --input_arg1 arg1 --output_arg arg2

	The arg1 should be small as possible to accomodate multiple arguments
	python test/export_mesh_blender.py --input input/obja_mesh.glb
	instead of
	python test/export_mesh_blender.py --input input/Objaverse-v1_49/000-050/9b99d900f8004fbe88bb5c3f08ded4de.glb
	
	<Function Description> This function does this this and this
	<4 space> Option1 - Concise Explanation
	<4 space> Option2 - Concise Explanation
	...
	
	Abhinav Kumar, <Date>
"""
```

- Write function comments as

```python
def foo():
<4 space>"""
<4 space><4 space>Function Description
<4 space>"""
```

In other words, the function description should be 4 characters further inside the triple quotes block

- The triple quotes should be aligned with the `f` of `foo`.


# Spacings

- Put space between return and last line
- Make function arguments on one line similar def name(a: torch. Tensor, b: torch.Tensor) -> torch.Float. When they exceed the limit of 100 characters, move the remaining arguments down.
- No space between `# ---------------------------------------------------------------------------` and function line
- Fix space between functions as 1 line
- Fix space between functions as 1 line after return

# Argparse arguments

- Provide a default value for all arguments
- Provide a small explanation of all arguments
- Do not use `required=True` unless absolutely necessary
- Do not overflow argparse args to 2 lines unless necessary
