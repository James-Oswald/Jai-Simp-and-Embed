// James Oswald
// 2024

Win :: #import "Window_Creation";
Basic :: #import "Basic";
Simp :: #import "Simp";
Input :: #import "Input";

main :: () {
    w : s32 = 800;
    h : s32 = 800;
    win := Win.create_window(w, h, "Simple Embeded Resource");

    Simp.prepare_window(win, 8);

    image : Simp.Texture;
    #run {
        success := Simp.texture_load_from_file(*image, "blow.png");
        Basic.assert(success);
    }

    while no_quit := true {
        Input.update_window_events();

        for Input.get_window_resizes() {
            Simp.update_window(it.window);
            if it.window == win {
                w = it.width;
                h = it.height;
            }
        }

        for Input.events_this_frame {
            if it.type == .QUIT
                // Testing out Jai's cool ability to break out of multiple nested loops
                break no_quit; 
        }

        //Render our image
        Simp.clear_render_target(.15, .08, .08, 1);
        Simp.set_shader_for_images(*image);
        Simp.immediate_begin();
        fw := cast(float) w;
        fh := cast(float) h; 
        Simp.immediate_quad(.{fh, 0}, .{0, 0}, .{0, fw}, .{fw, fh});
        Simp.immediate_flush();

        Simp.swap_buffers(win);
        Basic.reset_temporary_storage();
    }
}