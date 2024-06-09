#import "Bindings_Generator";
#import "Basic";
#import "File";
#import "String";
#import "BuildCpp";
#import "File_Utilities";
#import "Hash_Table";

#run {
    using opts: Generate_Bindings_Options;
    array_add(*system_include_paths, GENERATOR_DEFAULT_SYSTEM_INCLUDE_PATH);

    array_add(*libpaths, "linux");
    array_add(*libnames, "libonion");
    array_add(*include_paths, "include");
    // files := file_list("include", true);
    // for file: files {
    //     if !ends_with(file, ".h") {
    //         continue;
    //     }

    //     print("%\n", file);
    //     array_add(*source_files, file);
    // }

    array_add(*source_files,
        "include/block.h",
        "include/codecs.h",
        "include/dict.h",
        "include/handler.h",
        "include/http.h",
        "include/https.h",
        "include/listen_point.h",
        "include/low.h",
        "include/log.h",
        "include/mime.h",
        "include/onion.h",
        "include/poller.h",
        "include/request.h",
        "include/response.h",
        "include/sessions.h",
        "include/shortcuts.h",
        "include/types.h",
        "include/types_internal.h",
        "include/url.h",
        "include/websocket.h",
        "include/ptr_list.h");

    generate_compile_time_struct_checks = false;

    array_add(*generate_enums_from_macros_with_prefixes, "onion");

    header = #string ___jai
        #import "Socket";
        #import "POSIX";
    ___jai;

//     header = #string ___jai
// onion_dict_node :: onion_dict_node_t;
// onion_dict :: onion_dict_t;
// onion :: onion_t;
// onion_ptr_list :: onion_ptr_list_t;
// onion_request :: onion_request_t;
// onion_response :: onion_response_t;
// onion_handler :: onion_handler_t;
// onion_url :: onion_handler_t;
// onion_sessions :: onion_sessions_t;
// onion_block :: onion_block_t;
// onion_listen_point :: onion_listen_point_t;
// onion_websocket :: onion_websocket_t;
// onion_handler_handler :: #type (privdata: *void, req: *onion_request, res: *onion_response) -> s32 #c_call;
//     ___jai

    // forced_files :: string.[
    //     "include/types.h",
    //     "include/types_internal.h",
    // ];

    // visitor = (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
    //     filename_clang := clang_getFileName(decl.location.file);
    //     defer clang_disposeString(filename_clang);
    //     filename := to_lower_copy_new(to_string(clang_getCString(filename_clang)),, temp);

    //     for forced_file: forced_files {
    //         if ends_with(filename, forced_file) {
    //             decl.macro_value_result = .KEEP;
    //             break;
    //         }
    //     }

    //     print("%\n%\n\n", decl.*, filename);

    //     return .RECURSE;
    // };

    replace_free :: (str: string, old: string, new: string) -> string {
        result := replace(str, old, new);
        free(str);
        return result;
    }

    // very cool jai thing where you can't have overlapping names for things with different purposes
    generated_builder, success := generate_bindings(opts, true);
    if success {
        generated_string := builder_to_string(*generated_builder);
        generated_string = replace_free(generated_string, "onion: *onion", "onion: *onion_t");
        generated_string = replace_free(generated_string, "onion_new :: (flags: s32)", "onion_new :: (flags: onion_mode)");
        generated_string = replace_free(generated_string, "handler_f: *void", "handler_f: onion_handler_handler");
        write_entire_file("module.jai", generated_string);
    }
}
