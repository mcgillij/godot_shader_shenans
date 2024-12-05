shader_type canvas_item;

uniform vec2 center = vec2(0.0, 0.0);
uniform float zoom = 1.0;
uniform float max_iterations = 50.0;

void fragment() {
    // Use the UV coordinates as the starting position for the fractal calculation
    vec2 pos = (UV - vec2(0.5)) * 4.0; // Map UV to [-2, 2] range
    pos /= zoom; // Apply zoom factor
    
    vec2 z = pos;
    int iterations = 0;

    for (float i = 0.0; i < max_iterations; ++i) {
        float r = dot(z, z);

        if (r > 4.0) break;

        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + pos;
        iterations++;
    }

    // Create a simple color gradient based on the number of iterations
    float t = float(iterations) / max_iterations;
    COLOR.rgb = smoothstep(0.0, 1.0, vec3(t, t, t));
    COLOR.a = 1.0;
}
