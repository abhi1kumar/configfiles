# General

- Always display the command you are running
- Ask clarifying questions.
- Do not git push or delete without asking.

---

# Python

## Comments

- The top line of any python file should be as follows:

```python
"""
<4 space>Sample Run:  # Sample Run is optional. Use only when the function is executable
<4 space>python <file name> --input_arg1 arg1 --output_arg arg2

<4 space>The arg1 should be small as possible to accomodate multiple arguments
<4 space>python test/export_mesh_blender.py --input input/obja_mesh.glb
<4 space>instead of
<4 space>python test/export_mesh_blender.py --input input/Objaverse-v1_49/000-050/9b99d900f8004fbe88bb5c3f08ded4de.glb
	
<4 space><Function Description> This function does this this and this. If this is a multi-stage pipeline, use → to show the major blocks. If there is any alternative pipeline, show the alternative pathway with dashes.
<8 space> Option1 - Concise Explanation
<8 space> Option2 - Concise Explanation
<4 space>...

<4 space>Abhinav Kumar, <Date>
"""
```

- Write function comments as

```python
def foo():
<4 space>"""
<8 space>Function Description. If this is a multi-stage pipeline, use → to show the major blocks. If there is any alternative pipeline, show the alternative pathway with dashes.
<8 space>Args:
<12 space>arg1: Small Explanation. <Type> (example: torch.Tensor / numpy.ndarray) Shape <Shape> (example: [B x C x H x W]).
<12 space>arg2: Small Explanation. <Type> (example: torch.Tensor / numpy.ndarray) Shape <Shape> (example: [B x C x H x W]).
<8 space>Returns:
<12 space>output1: Small Explanation. <Type> (example: torch.Tensor / numpy.ndarray) Shape <Shape> (example: [B x C x H x W]).
<12 space>output2: Small Explanation. <Type> (example: torch.Tensor / numpy.ndarray) Shape <Shape> (example: [B x C x H x W]).
<8 space>Raises:
<12 space>Error: Small Explanation (example: ConnectionError: If no available port is found).
<4 space>"""
```

- In function docstring Args and Returns blocks, pad argument names with spaces before the colon so all descriptions start at the same column. The column is determined by the longest name in that block.
- The function description should be 4 characters further inside the triple quotes block
- The triple quotes should be aligned with the `f` of `foo`.

- Colon alignment across Args AND Returns: The : separating arg name from description must be at the same column in both the Args block and the Returns block of the same function (not just within each block separately). Column is determined by the longest name across all entries in the function.
- torch.Tensor type alignment across Args AND Returns: The t in torch.Tensor (the type annotation) must start at the same column across all entries that have torch.Tensor, spanning both the Args and Returns blocks of the same function. Column is determined by the longest description among all torch-annotated entries in the function.
  Example:

```
  Args:
      gaussian_xyz: Gaussian positions in normalized scene space. torch.Tensor Shape [N x 3].
      input_c2ws  : Input camera-to-world matrices.               torch.Tensor Shape [V x 4 x 4].
      input_intr  : Input intrinsics (fx, fy, cx, cy).            torch.Tensor Shape [V x 4].
  Returns:
      c2ws_out    : Camera-to-world matrices for the spiral.      torch.Tensor Shape [n_frames x 4 x 4].
      intr_out    : Intrinsics (mean of input intrinsics).        torch.Tensor Shape [n_frames x 4].
```

- Descriptions should be padded so type annotations align vertically (this applies to non-torch.Tensor types too). The description is padded with spaces so the type (torch.Tensor, int., str., etc.) starts at the same column within the block:

```
  Returns:
      images      : RGB images normalized to [0,1]. torch.Tensor Shape [V x 3 x H x W].
      c2ws        : Camera-to-world matrices.       torch.Tensor Shape [V x 4 x 4].
      intr        : Intrinsics (fx, fy, cx, cy).    torch.Tensor Shape [V x 4].
```

- Provide comment before `main()` function as

```python
# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
```

- Provide comment before `argparse`

```python
# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
parser = argparse.ArgumentParser()
```

- Never delete existing comments when refactoring or rewriting files. Preserve all comments exactly as they are unless explicitly asked to remove them.
-  When listing parallel items (e.g. conventions, options, mappings), align the values vertically so corresponding fields line up across rows.
- Do not collapse multi-line function calls into a single line when rewriting. Preserve the original line breaks and indentation of function arguments.
- Do not collapse multi-line string concatenations into a single line when rewriting. Preserve the original line breaks for long strings.
- Never pack multiple keyword arguments onto one line when rewriting. Keep one keyword argument per line in multi-line function calls.

## Spacings

- Put space between return and last line
- Make function arguments on one line similar def name(a: torch. Tensor, b: torch.Tensor) -> torch.Float. When they exceed the limit of 100 characters, move the remaining arguments down.
- No space between `# ---------------------------------------------------------------------------` and function line
- Fix space between functions as 1 line
- Fix space between functions as 1 line after return
- Never inline fixed vector/tuple lists into loop headers. Always assign them to a named variable first, one entry per line.

## Argparse arguments

- Provide a default value for all arguments
- Provide a small explanation of all arguments
- Do not use `required=True` unless absolutely necessary
- Do not overflow argparse args to 2 lines unless necessary
- The individual rows in argparse arguments should be filled with spaces.

```python
parser.add_argument("--out"                    , default="output/sdf_overfit", help="Output directory")
parser.add_argument("--mc_resolution", type=int, default=128                 , help="MC voxel grid resolution")
```
instead of

```python
parser.add_argument("--out", default="output/sdf_overfit", help="Output directory")
parser.add_argument("--mc_resolution", type=int, default=128, help="MC voxel grid resolution")
```

---

# Shell Scripts

- The top of any executable shell script should have a Sample Run header using `#` comments:

```bash
#   Sample Run:
#   bash script.sh --flag1
#   bash script.sh --flag2
#   bash script.sh --flag1 --flag2
#
#   <Description of what the script does>
#       --flag1  - Concise explanation
#       --flag2  - Concise explanation
```

- Split shell scripts into flag-gated sections using getopt, mirroring the [TRELLIS.2/setup.sh](https://raw.githubusercontent.com/microsoft/TRELLIS.2/refs/heads/main/setup.sh) pattern:

```bash
TEMP=`getopt -o h --long help,flag1,flag2 -n 'script.sh' -- "$@"`
eval set -- "$TEMP"
FLAG1=false
FLAG2=false
while true ; do
    case "$1" in
        --flag1 ) FLAG1=true ; shift ;;
        --flag2 ) FLAG2=true ; shift ;;
        --      ) shift ; break ;;
    esac
done
if [ "$FLAG1" = true ] ; then
    ...
fi
```

- Align case statement entries so flag names, ), assignments, and shift line up vertically across all rows.
- Use the same `# ---------------------------------------------------------------------------` section dividers as Python for major blocks inside shell scripts.

---

# Visualization Demos

## Required Files

- Every demo must have `index.html` and `manifest.json` in the same S3 folder.
- `manifest.json` lists all scenes and their per-column mesh paths. Keep it in sync with `index.html`.
- After updating either file locally, push to both S3 and git.

## Layout
- First Row: <Method> Comparison
- Second Row: <-- Prev | Page 1/#Pages (Num Scenes) | Next | Add Scene                                                  Compare <Method1> (let user choose) vs <Method 2> (let user choose)   Rotation On (Default) or Off | Reset | Metric (Metric 1) | Worst --> Best (Default) or (Best --> Worst) | Arrange by < Method 1> (let user choose)
- Third Row: Scene  | Ground Truth | <Method1> | <Method 2> Columns represent methods (e.g., GT, colligo, TRELLIS.2, PowerFoam).
- Fourth Row: Dataset Statistics |  | <Method 1> Dataset Statistics | <Method 2> Dataset Statistics 
Dataset statistics below the method name with all metrics
- Rows represent scenes/objects. List most important or largest variant first (e.g., 10k before 5k).
- Use Company color

## Viewer Behavior

- 3D Viewer should render double-sided triangles so that no matter which angle you’re looking from you see the mesh.  
- Viewer should display selected / all metric values and triangles count 
- All columns must **autorotate in sync** using a shared `performance.now()`-based theta:
```js 
const ROTATE_SPEED  = 0.008 * 60 / 1000;   // rad/ms  (colligo viewer)
let rotateStartWall  = performance.now();  
let rotateStartTheta = Math.PI / 6;
function getSharedTheta() {
return autoRotate
    ? rotateStartTheta + (performance.now() - rotateStartWall) * ROTATE_SPEED
    : rotateStartTheta;
}   
function freezeSharedTheta() {
rotateStartTheta = getSharedTheta();
rotateStartWall  = performance.now();
}
```
- Call `freezeSharedTheta()` at the top of `toggleAutoRotate()` (before flipping the flag).
- On pointer-down during drag: `snapshot sph.theta = getSharedTheta()`.
- On pointer-up after drag: write `rotateStartTheta = sph.theta and reset rotateStartWall = performance.now()`.

Mesh Download functionality behaviour  
- Support right-click → "Download mesh.glb" per cell via a context menu.
- Add `e.stopPropagation()` to the cell contextmenu listener to prevent the document-level listener from hiding the menu immediately.



## S3 & URL Conventions
  
- S3 bucket: `foundry-disney-mickey-mouse-adobe-assets`, always use `--profile foundry`

- Demo URL pattern: `https://foundry-aws-corp.adobe.io/asset/foundry-disney-mickey-mouse-adobe-assets/abhinakumar/demos/<YYYY_MM_DD_name>/index.html`

- Upload HTML with explicit content-type:
`aws s3 cp index.html s3://foundry-disney-mickey-mouse-adobe-assets/abhinakumar/demos//index.html --profile foundry --content-type text/html`

- Upload GLB meshes:
`aws s3 cp / s3://foundry-disney-mickey-mouse-adobe-assets/abhinakumar/demos// --profile foundry --recursive --include "*.glb"`

- **Never overwrite a previous demo.** Always create a new dated folder.
