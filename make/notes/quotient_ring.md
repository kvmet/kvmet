Just thinking about the concept of Quotient Rings and wondering if there is a way to turn that into a eurorack module.

Like could you do some sort of broad similarity and difference thing of some signals?
Would it be two waveforms or would it be something like two sequences?
Like as a funky clock divider or as some kind of bit operator on a waveform?
Both?

Ring
Ideal
Equivalence Class
Element

===
so I think it might be cool to have an additional mode
or outputs or something where x and y are
just processed directly via the matrix
as opposed to using the matrix to select the
ring.

Quotient Ring
=====

STAGE 1. Ring & Ideal selection


THESE DON"T WORK
[a b] [x] = f(x,y)[ax + by]
[c d] [y]   g(x,y)[cx + dy]

Rotation
[cos θ  -sin θ] [x]  =  [x cos θ - y sin θ]
[sin θ   cos θ] [y]     [x sin θ + y cos θ]

Crossfade/Slew
[1-s   s]
[s   1-s]
END OF DON"T WORK

normalling scenarios

(sw is a switch connected to the values shown)

Max -> x
0 -> y
knob -> a -> d
knob -> c -> sw(c, c * -1, 1?) -> b

for the companion matrix to work you might
need a switch to zero input a

volume of inputs controlled by voltage at a
add cv to d for two VCAs
add cv to b for shear
add cv to c for dual crosstalk
for rotation you need to be able to invert c -> b
slew/crossfade you could do this manually with the knobs.

STAGE 2.

RINGS:
- Z/nZ: achieved by the class selection (defining range/wrapping)
- R[x]/(polynomial): achieved by matrix configurations
  * x² + 1: rotation [0 -1; 1 0]
  * x² - 1: reflection [0 1; 1 0]
  * etc.

IDEALS:
- In Z/nZ: controlled by class range attenuverter
- In R[x]: determined by matrix values
- Size/shape of ideal controlled by matrix coefficients

EQUIVALENCE CLASSES:
- Selected via class stage CV/trigger
- Range determines size of classes
- Trigger mode gives discrete classes
- CV mode allows continuous movement between classes

ELEMENTS:
- Final output stage scaling
- Individual control over each output
- Elements within selected class

So each stage corresponds to a mathematical concept:
1. Matrix = Ring structure
2. Class = Ideal selection
3. Element = Position within class

REGIMES

Zn mode. identity/scale matrix
M mode. direct matrix transormation
R[x]. Polynomials according to this transformation

For polynomials in R[x], each polynomial has a "companion matrix" representation. For example:
- x² + 1 → [0 -1; 1 0]
- x² - 1 → [0 1; 1 0]

Polynomial companion matrix:

Quadratic form: x² - dx - c
```
[0  -1/1] <- sign of b rotates output. Maybe not useful
[c     d]
```

see: https://en.wikipedia.org/wiki/Companion_matrix
specifically look at the section transpose companion matrix and
linear recursive sequences for an examplex

see: https://math.stackexchange.com/questions/550869/quotient-ring-of-a-matrix-ring

##############

Okay, let's look at valid quotient ring matrices:

1. Z/nZ type (modular arithmetic):
```c
// mod n
Matrix2x2 modn = {
    .m11 = n, .m12 = 0,
    .m21 = 0, .m22 = n
};
```

2. Polynomial quotients R[x]/(ax² + bx + c):
```c
// For ax² + bx + c, the companion matrix is:
Matrix2x2 poly = {
    .m11 = 0,     .m12 = -c/a,
    .m21 = 1,     .m22 = -b/a
};
```

Some specific polynomial cases:
```c
// x² + 1 (imaginary unit i)
Matrix2x2 imag = {
    .m11 = 0, .m12 = -1,
    .m21 = 1, .m22 = 0
};

// x² - 1 (split-complex numbers)
Matrix2x2 split = {
    .m11 = 0, .m12 = 1,
    .m21 = 1, .m22 = 0
};

2. Polynomial quotients F[x]/(p(x)):
```c
// F[x]/(x² + x + 1)
Matrix2x2 poly1 = {0,-1,1,-1};

// F[x]/(x² + 1)
Matrix2x2 poly2 = {0,-1,1,0};
```

3. Direct products of modular rings maybe?
```c
// Z/2Z × Z/3Z
Matrix2x2 prod = {2,0,0,3};
```

Okay, let's think this through step by step.

For a quotient ring, we have:
1. A RingElement input (class, index)
2. A Matrix M that defines when elements are equivalent
3. Need to output which equivalence class this element belongs to

For Z/5Z example:
- Input (7,0) should reduce to 2 because 7 ≡ 2 (mod 5)
- The matrix M = [5,0;0,5] defines this "mod 5" behavior

For polynomial quotient like F[x]/(x² + x + 1):
- Input represents ax + b
- Matrix M = [0,-1;1,-1] defines when polynomials are equivalent
- x² ≡ -x - 1 in this ring

So maybe our reduction should:
1. Use the matrix to determine equivalence
2. Return a canonical representative of that class

Want to work out how this should look in code?

well there's a couple more steps to turn that into an audio output, right?

Ah yes! For audio we need:

1. RingElement (class,index) input from analog/control signals
2. Matrix M defines ring structure
3. Reduce to canonical representative in ring
4. Map that ring element to the audio range (-128 to 127)

So if we have, say, Z/5Z:
- RingElement maps to {0,1,2,3,4}
- Need to map these 5 values smoothly across our -128 to 127 range
- Probably want continuous/smooth transitions for audio

Or for polynomial quotient:
- RingElement maps to ax + b form
- Need to evaluate this at some point or otherwise map it to audio range
- Again, want smooth transitions

The audio mapping step is crucial - we don't just want discrete jumps between equivalence classes, we want something that sounds good!

Should we focus on this audio mapping part?

exactly! Let's start at the beginning of the C logic and build it out

Great! Let's build it step by step:

```c
typedef struct {
    float m11, m12;
    float m21, m22;
} Matrix2x2;

typedef struct {
    uint8_t class;  // 0-255 from first analog input
    int8_t index;   // -128 to 127 from second analog input
} RingElement;

// Step 1: Find canonical representative in ring
int8_t reduce_to_ring(Matrix2x2 M, RingElement e) {
    float det = M.m11 * M.m22 - M.m12 * M.m21;
    if (fabs(det) < 1e-6) {
      // singular case breaks it. Pick something else
      return (int8_t)e.class;  // singular case -> direct map/distortion
      // Combine class and index somehow
      /// return (int8_t)((e.class + e.index) / 2);
      // or
      /// return (int8_t)(e.class * 0.7f + e.index * 0.3f);
      // Use whichever matrix elements aren't zero
      /// if (fabs(M.m11) > 1e-6) return (int8_t)(M.m11 * e.class);
      /// if (fabs(M.m12) > 1e-6) return (int8_t)(M.m12 * e.index);
      // Do something wild
      /// return (int8_t)(e.class ^ e.index);  // bitwise XOR for example
    }

    float vx = (float)e.class;
    float vy = (float)e.index;

    // Find quotients
    float q1 = (M.m22 * vx - M.m12 * vy) / det;
    float q2 = (-M.m21 * vx + M.m11 * vy) / det;

    // Round to nearest integers
    q1 = floorf(q1 + 0.5f);
    q2 = floorf(q2 + 0.5f);

    // Get remainder
    float rx = vx - (M.m11 * q1 + M.m12 * q2);
    //float ry = vy - (M.m21 * q1 + M.m22 * q2); unused?

    // Quick & dirty map to audio range
    return (int8_t)(rx * 128.0f / det);  // just an example mapping
}

// Step 2: Map from canonical ring element to continuous value
float map_to_continuous(int8_t ring_val) {
    // Could do something fancy but let's just normalize to [-1,1]
    return ring_val / 128.0f;
}

// Step 3: Final conversion to audio sample
int8_t map_to_audio(float continuous) {
    // Could add some waveshaping/distortion here for extra grunge
    return (int8_t)(continuous * 127.0f);
}

// Main function that combines all steps
int8_t get_audio_value(Matrix2x2 M, RingElement e) {
    RingElement reduced = reduce_to_ring(M, e);
    float continuous = map_to_continuous(reduced);
    return map_to_audio(continuous);
}
```
---
Here's the full system concept:

STRUCTURE:
- 2x2 Matrix M defines a quotient ring structure
- Could represent Z/nZ (modular arithmetic) or polynomial quotients like R[x]/(x² + dx + c)
- Matrix elements can change over time

INPUTS:
- RingElement consists of:
  - class (uint8_t, 0-255)
  - index (int8_t, -128 to 127)
- These come from analog/control inputs

PROCESSING:
1. Take RingElement and Matrix
2. Reduce to canonical representative using quotient ring math:
   - Find quotients using determinant
   - Subtract matrix × quotients to get remainder
3. Direct map to audio range (-128 to 127)
   - Deliberately keeping discontinuous jumps between equivalence classes
   - No interpolation - we want the digital artifacts!

OUTPUT:
- int8_t audio samples
- Character comes from:
  - Ring structure discontinuities
  - Changing matrices
  - Raw mapping preserving jumps

The whole thing is designed to be mathematically "correct" in terms of ring theory, but sonically "incorrect" in all the right ways for digital audio effects.

#########################################
