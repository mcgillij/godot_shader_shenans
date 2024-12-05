shader_type canvas_item;

uniform float julia_a = 0.285;
uniform float julia_b = 0.01;
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 0.0, 1.0); // Yellow glow color
uniform float glow_size = 5.0; // Size of the glow
uniform float zoom_factor = 1.0; // Zoom factor (e.g., 2.0 for double zoom)

void fragment() {
    vec2 uv = UV; // Use the UV coordinates from the texture
    uv -= 0.5; // Center the UV coordinates around (0.5, 0.5)
    uv *= zoom_factor; // Apply the zoom factor

    int max_iterations = 100;
    float escape_radius = 4.0;
    vec2 c = vec2(julia_a, julia_b);
    vec2 z = uv * glow_size; // Scale the UV coordinates by the glow size

    for (int i = 0; i < max_iterations; ++i) {
        if (length(z) > escape_radius) {
            break;
        }
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
    }

    float dist = length(z);
    float alpha = smoothstep(escape_radius, escape_radius - 0.1, dist);

    COLOR = texture(TEXTURE, UV) * vec4(glow_color.rgb, alpha) * glow_color.a; // Sample the texture and mix with the glow color
}
