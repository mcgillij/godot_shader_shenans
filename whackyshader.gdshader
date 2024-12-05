shader_type canvas_item;

void fragment() {
    // Define the speed of the morphing effect
    float speed = 0.5;
    
    // Create a time variable based on the global time and speed
    float time = TIME * speed;
    
    // Modify UV coordinates to create a morphing effect
    vec2 morphed_uv = UV + vec2(sin(time), cos(time)) * 0.1;
    
    // Sample the texture with the modified UV coordinates
    COLOR = texture(TEXTURE, morphed_uv);
}
