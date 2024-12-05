shader_type canvas_item;

uniform float time = 0.0;
uniform vec2 center = vec2(0.0, 0.0);
uniform float zoom = 1.0;
uniform int max_iterations = 50;

void fragment() {
    // Use the UV coordinates as the starting position for the fractal calculation
    vec2 pos = (UV - vec2(0.5)) * 4.0 * zoom + center;
    
    // Time-based transformation to create morphing effect
    float phase = sin(time) * 0.1;
    pos += vec2(cos(time), sin(time)) * phase;

    int iterations = 0;
    vec2 z = pos;
    vec2 c = pos; // Using the current position as the constant 'c'

    while (iterations < max_iterations && length(z) < 2.0) {
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
        iterations++;
    }

    // Create a color based on the number of iterations
    float color = float(iterations / max_iterations);
    COLOR = vec4(color, color, color, 1.0);
}
