{
  home.file."/.config/hypr/shaders/brighten.frag" = {
    text = ''
      // shader.glsl
      #version 450

      uniform vec2 resolution;
      uniform float brightness_factor;

      in vec2 v_texcoord;
      out vec4 out_color;

      void main() {
        vec4 color = texture(s_texture, v_texcoord);
        out_color = color * brightness_factor;
      }
    '';
    executable = false;
  };
}
