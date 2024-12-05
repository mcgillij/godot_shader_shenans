shader_type canvas_item;

uniform vec4 glow_color = vec4(1.0, 1.0, 0.0, 1.0); // Yellow glow color
uniform float glow_size = 5.0; // Size of the glow

void fragment() {
    vec2 uv = UV;
    vec4 original_color = texture(TEXTURE, uv);

    if (original_color.a < 0.1) { // Consider pixels with very low alpha as transparent
        COLOR = vec4(0.0); // No color contribution from fully transparent pixels
    } else {
        bool is_edge = false;
        for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
                if (i != 0 || j != 0) { // Skip the current pixel
                    vec2 offset = vec2(float(i), float(j)) / vec2(textureSize(TEXTURE, 0));
                    vec4 neighbor_color = texture(TEXTURE, uv + offset);

                    // Check if the neighbor is outside the texture or has a very low alpha
                    if (neighbor_color.a < 0.1 || any(lessThan(uv + offset, vec2(0.0))) || any(greaterThan(uv + offset, vec2(1.0)))) {
                        is_edge = true;
                        break;
                    }
                }
            }
        }

        float edge_detection = is_edge ? smoothstep(glow_size, glow_size + 0.5, 0.0) : 1.0;
        COLOR = mix( glow_color, original_color, edge_detection);
    }
}