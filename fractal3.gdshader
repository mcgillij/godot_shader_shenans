shader_type canvas_item;

uniform float max_iterations = 50.0;    // Maximum iterations before escape
uniform float escape_radius = 4.0;     // Radius at which a point is considered "escaped"
uniform float smooth_power = 8.0;      // Power for smooth coloring

// Helper function to calculate the magnitude squared of a complex number (vec2)
float length_squared(vec2 z) {
    return dot(z, z);
}

void fragment() {
    // Scale and translate UV coordinates to fit the fractal viewport
    vec2 scaled_uv = UV * 4.0 - vec2(2.0, 2.0); // Zoom in by a factor of 4 and center

    vec2 z = scaled_uv; // Convert UV to complex number (real part = x, imaginary part = y)
    vec2 c = scaled_uv; // For Mandelbrot, c is derived from the UV coordinate

    float n_iterations = max_iterations;

    for (float i = 0.0; i < max_iterations; ++i) {
        // Mandelbrot Set transformation: f(z) = z^2 + c
        vec2 z_squared = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y);
        z = z_squared + c;

        if (length_squared(z) > escape_radius * escape_radius) {
            n_iterations = i; // Point has escaped
            break;
        }
    }

    float t = n_iterations / max_iterations;

    // Smooth coloring technique using log-log method
    if (n_iterations < max_iterations) {
        float log_length_squared = length(z);
        t += log(log_length_squared / escape_radius) / log(2.0) * smooth_power / max_iterations;
    }

    // Assign colors based on normalized iteration count
    vec3 color = vec3(t, 1.0 - t, abs(t - 0.5));

    // Optional: Add a smooth transition to the edges of the fractal
    float edge_factor = smoothstep(0.9, 1.0, t);
    color *= edge_factor;

    COLOR = vec4(color, 1.0); // Output final color with full opacity
}
