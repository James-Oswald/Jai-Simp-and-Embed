// James Oswald
// First Jai program!
// 2024

Win :: #import "Window_Creation";
Basic :: #import "Basic";
Simp :: #import "Simp";
Input :: #import "Input";

// return a bitmap of the image with the given file name
get_bitmap :: (filename : string) -> Simp.Bitmap{
    bitmap : Simp.Bitmap;
    good := Simp.bitmap_load(*bitmap, filename);
    Basic.assert(good, "Failed to load bitmap from %", filename);
    return bitmap;
};

main :: () {
    // Create window, init Simp
    w : s32 = 400;
    h : s32 = 400;
    win := Win.create_window(w, h, "Window Title");
    Simp.prepare_window(win, 8);

    // Load our image
    bitmap := get_bitmap("blow.png");
    image : Simp.Texture;
    Simp.texture_load_from_bitmap(*image, *bitmap);

    // Window render/event loop
    while no_quit := true {

        Input.update_window_events();
        for Input.events_this_frame {
            if it.type == .QUIT
                // Testing out Jai's cool ability to break
                // out of multiple nested loops
                break no_quit; 
        }

        // Render our image
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