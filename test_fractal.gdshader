shader_type canvas_item;
render_mode blend_mix;

uniform float scale = 0.1;
uniform float time_speed = 0.1;
uniform int max_iterations = 8;
uniform vec3 color_a = vec3(0.5, 0.2, 0.8);
uniform vec3 color_b = vec3(0.2, 0.8, 0.5);

void fragment() {
    // Center and scale UV coordinates
    vec2 uv_centered = UV - 0.5;
    float time = TIME * time_speed;

    // Create the rotation matrix using vec2 constructors
    mat2 rotation = mat2(
        vec2(cos(time), -sin(time)),
        vec2(sin(time), cos(time))
    );

    // Apply rotation to UV coordinates
    uv_centered *= rotation;

    // Initialize z based on scaled and rotated UV
    vec3 z = vec3(uv_centered * scale, 0.0);

    for (int i = 0; i < max_iterations; ++i) {
        float r = length(z);

        // Escape condition if radius exceeds a certain threshold
        if (r > 4.0)
            break;

        // Mandelbulb transformation in polar coordinates
        float theta = acos(z.z / r);
        float phi = atan(z.y, z.x);

        // Convert back to Cartesian coordinates with power of 8
        float r_power8 = pow(r, 8.0);
        z.x = r_power8 * sin(8.0 * theta) * cos(phi);
        z.y = r_power8 * sin(8.0 * theta) * sin(phi);
        z.z = r_power8 * cos(8.0 * theta);
    }

    // Calculate the distance from the origin
    float distance = length(z);

    // Smooth transition for coloring based on distance
    float t = smoothstep(1.0, 0.95, pow(distance, -2.0));
    vec3 color = mix(color_a, color_b, t);

    // Output the final color to the screen
    COLOR = vec4(color, 1.0);
}
