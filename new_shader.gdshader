shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5); // Center of the fractal
uniform float zoom = 1.0;
uniform float max_iterations = 50.0;

void fragment() {
    // Calculate the position in the complex plane based on UV and center
    vec2 pos = (UV - center) * 4.0; // Map UV to [-2, 2] range centered at 'center'
    pos /= zoom; // Apply zoom factor

    vec2 z = pos;
    int iterations = 0;

    for (float i = 0.0; i < max_iterations; ++i) {
        float r = dot(z, z);

        if (r > 4.0) break;

        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + pos;
        iterations++;
    }

    // Normalize the number of iterations to [0, 1]
    float t = float(iterations) / max_iterations;
    COLOR.rgb = smoothstep(0.0, 1.0, vec3(t, t, t));
    COLOR.a = 1.0;
}