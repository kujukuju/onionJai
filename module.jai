//
// This file was auto-generated using the following command:
//
// jai generate.jai
//
        #import "Socket";
        #import "POSIX";



ONION_REQUEST_BUFFER_SIZE :: 256;
ONION_RESPONSE_BUFFER_SIZE :: 1500;

onion_dict :: onion_dict_t;

onion_handler :: onion_handler_t;

/**
* @struct onion_url_t
* @short Url regexp pack. This is also a handler, and can be converted with onion_url_to_handle.
* @ingroup url
*/
onion_url_t :: struct {}
onion_url :: onion_url_t;

onion_request :: onion_request_t;

onion_response :: onion_response_t;

/**
* @struct onion_server_t
* @short Onion server that do not depend on specific IO structure.
*
* This is separated as you can build your own servers using this structure instead of onion_t. For example
* using onion_server_t you can do a inet daemon that listens HTTP data.
*/
onion_server_t :: struct {}
onion_server :: onion_server_t;

onion :: onion_t;

/* Signature of the onion client data destoyer. */
onion_client_data_free_sig :: #type (unknown0: *void) -> void #c_call;

onion_sessions :: onion_sessions_t;

onion_block :: onion_block_t;

/**
* @struct onion_poller_t
* @short Manages the polling on a set of file descriptors
* @ingroup poller
*/
onion_poller_t :: struct {}
onion_poller :: onion_poller_t;

/**
* @struct onion_poller_slot_t
* @short Data about a poller element: timeout, function to call shutdown function
* @ingroup onion
*/
onion_poller_slot_t :: struct {}
onion_poller_slot :: onion_poller_slot_t;

onion_listen_point :: onion_listen_point_t;

onion_websocket :: onion_websocket_t;

onion_ptr_list :: onion_ptr_list_t;

/// Flags for the mode of operation of the onion server.
/// @ingroup onion
onion_mode_e :: enum u32 {
    ONE               :: 1;
    ONE_LOOP          :: 3;
    THREADED          :: 4;
    DETACH_LISTEN     :: 8;
    SYSTEMD           :: 16;

    POLL              :: 32;
    POOL              :: 36;
    NO_SIGPIPE        :: 64;
    NO_SIGTERM        :: 128;

    SSL_AVAILABLE     :: 256;
    SSL_ENABLED       :: 512;

    THREADS_AVAILABLE :: 1024;
    THREADS_ENABLED   :: 2048;

    DETACHED          :: 4096;
    LISTENING         :: 8192;

    O_ONE               :: ONE;
    O_ONE_LOOP          :: ONE_LOOP;
    O_THREADED          :: THREADED;
    O_DETACH_LISTEN     :: DETACH_LISTEN;
    O_SYSTEMD           :: SYSTEMD;

    O_POLL              :: POLL;
    O_POOL              :: POOL;
    O_NO_SIGPIPE        :: NO_SIGPIPE;
    O_NO_SIGTERM        :: NO_SIGTERM;

    O_SSL_AVAILABLE     :: SSL_AVAILABLE;
    O_SSL_ENABLED       :: SSL_ENABLED;

    O_THREADS_AVAILABLE :: THREADS_AVAILABLE;
    O_THREADS_ENABLED   :: THREADS_ENABLED;

    O_DETACHED          :: DETACHED;
    O_LISTENING         :: LISTENING;
}

onion_mode :: onion_mode_e;

/**
* @short The desired connection state of the connection.
* @ingroup handler
*
* If <0 it means close connection. May mean also to show something to the client.
*/
onion_connection_status_e :: enum s32 {
    NOT_PROCESSED    :: 0;
    NEED_MORE_DATA   :: 1;
    PROCESSED        :: 2;
    CLOSE_CONNECTION :: -2;
    KEEP_ALIVE       :: 3;
    WEBSOCKET        :: 4;
    REQUEST_READY    :: 5;
    INTERNAL_ERROR   :: -500;
    NOT_IMPLEMENTED  :: -501;
    FORBIDDEN        :: -502;
    YIELD            :: -3;

    OCS_NOT_PROCESSED    :: NOT_PROCESSED;
    OCS_NEED_MORE_DATA   :: NEED_MORE_DATA;
    OCS_PROCESSED        :: PROCESSED;
    OCS_CLOSE_CONNECTION :: CLOSE_CONNECTION;
    OCS_KEEP_ALIVE       :: KEEP_ALIVE;
    OCS_WEBSOCKET        :: WEBSOCKET;
    OCS_REQUEST_READY    :: REQUEST_READY;
    OCS_INTERNAL_ERROR   :: INTERNAL_ERROR;
    OCS_NOT_IMPLEMENTED  :: NOT_IMPLEMENTED;
    OCS_FORBIDDEN        :: FORBIDDEN;
    OCS_YIELD            :: YIELD;
}

onion_connection_status :: onion_connection_status_e;

/// Flags for the SSL connection.
/// @ingroup https
onion_ssl_flags_e :: enum u32 {
    O_USE_DEV_RANDOM :: 256;
}

onion_ssl_flags :: onion_ssl_flags_e;

/// Types of certificate onionssl knows: key, cert and intermediate
/// @ingroup https
onion_ssl_certificate_type_e :: enum u32 {
    NONE               :: 0;
    CERTIFICATE_KEY    :: 1;
    CERTIFICATE_CRL    :: 2;
    CERTIFICATE_TRUST  :: 3;
    CERTIFICATE_PKCS12 :: 4;

    DER                :: 256;
    NO_DEINIT          :: 512;

    O_SSL_NONE               :: NONE;
    O_SSL_CERTIFICATE_KEY    :: CERTIFICATE_KEY;
    O_SSL_CERTIFICATE_CRL    :: CERTIFICATE_CRL;
    O_SSL_CERTIFICATE_TRUST  :: CERTIFICATE_TRUST;
    O_SSL_CERTIFICATE_PKCS12 :: CERTIFICATE_PKCS12;

    O_SSL_DER                :: DER;
    O_SSL_NO_DEINIT          :: NO_DEINIT;
}

onion_ssl_certificate_type :: onion_ssl_certificate_type_e;

/**
* @short Types of fragments that websockets support
* @memberof onion_websocket_t
* @ingroup websocket
*/
onion_websocket_opcode_e :: enum u32 {
    TEXT             :: 1;
    BINARY           :: 2;
    CONNECTION_CLOSE :: 8;
    PING             :: 10;
    PONG             :: 11;

    OWS_TEXT             :: TEXT;
    OWS_BINARY           :: BINARY;
    OWS_CONNECTION_CLOSE :: CONNECTION_CLOSE;
    OWS_PING             :: PING;
    OWS_PONG             :: PONG;
}

onion_websocket_opcode :: onion_websocket_opcode_e;

/// Signature of request handlers.
/// @ingroup handler
onion_handler_handler :: #type (privdata: *void, req: *onion_request, res: *onion_response) -> onion_connection_status #c_call;

/// Signature of free function of private data of request handlers
/// @ingroup handler
onion_handler_private_data_free :: #type (privdata: *void) -> void #c_call;

/**
* @short Prototype for websocket callbacks
* @memberof onion_websocket_t
* @ingroup websocket
*
* The callbacks are the functions to be called when new data is available on websockets.
*
* They are not mandatory, but when used they can be changed from the
* callback itself, using onion_websocket_set_callback. If data is
* left for read after a callback call, next callback is called with
* that data. If same callback stays, and no data has been consumed,
* it will not be called until new data is available.  End of input,
* or websocket removal is notified with a negative data_ready_length.
*
* The private data is that of the original request handler.
*
* This chaining of callbacks allows easy creation of state machines.
*
* @returns OCS_INTERNAL_ERROR | OCS_CLOSE_CONNECTION | OCS_NEED_MORE_DATA. Other returns result in OCS_INTERNAL_ERROR.
*/
onion_websocket_callback_t :: #type (privdata: *void, ws: *onion_websocket, data_ready_length: s64) -> onion_connection_status #c_call;

onion_block_new :: (__args: ..Any) -> *onion_block #foreign libonion;
onion_block_free :: (b: *onion_block) -> void #foreign libonion;
onion_block_clear :: (b: *onion_block) -> void #foreign libonion;

onion_block_min_maxsize :: (b: *onion_block, minsize: s32) -> void #foreign libonion;
onion_block_size :: (b: *onion_block) -> s64 #foreign libonion;
onion_block_data :: (b: *onion_block) -> *u8 #foreign libonion;

onion_block_rewind :: (b: *onion_block, n: s64) -> void #foreign libonion;

onion_block_add_char :: (b: *onion_block, c: u8) -> s32 #foreign libonion;
onion_block_add_str :: (b: *onion_block, str: *u8) -> s32 #foreign libonion;
onion_block_add_data :: (b: *onion_block, data: *u8, length: u64) -> s32 #foreign libonion;
onion_block_add_block :: (b: *onion_block, toadd: *onion_block) -> s32 #foreign libonion;

/// Decodes a base64 into a new char* (must be freed later).
onion_base64_decode :: (orig: *u8, length: *s32) -> *u8 #foreign libonion;

/// Encodes a byte array to a base64 into a new char* (must be freed later).
onion_base64_encode :: (orig: *u8, length: s32) -> *u8 #foreign libonion;

/// Performs URL unquoting
onion_unquote_inplace :: (str: *u8) -> void #foreign libonion;

/// Performs URL quoting, memory is allocated and has to be freed.
onion_quote_new :: (str: *u8) -> *u8 #foreign libonion;

/// Performs URL quoting, uses auxiliary res, with maxlength size. If more, do up to where I can, and cut it with \0.
onion_quote :: (str: *u8, res: *u8, maxlength: s32) -> s32 #foreign libonion;

/// Performs C quotation: changes " for \". Usefull when sending data to be interpreted as JSON.
onion_c_quote_new :: (str: *u8) -> *u8 #foreign libonion;

/// Performs the C quotation on the ret str. Max length is l.
onion_c_quote :: (str: *u8, ret: *u8, l: s32) -> *u8 #foreign libonion;

/// Calculates the sha1 checksum
onion_sha1 :: (data: *u8, length: s32, result: *u8) -> void #foreign libonion;

/// Calculates the HTML encoding of a string. Returned value must be freed. If no encoding needed, returns NULL.
onion_html_quote :: (str: *u8) -> *u8 #foreign libonion;

/// Always return a freshly allocated string, to be later freed.
onion_html_quote_dup :: (str: *u8) -> *u8 #foreign libonion;

/// Generates JSON string encoding and adds it to an existing block
onion_json_quote_add :: (block: *onion_block, str: *u8) -> void #foreign libonion;

/// Adds to the block the quoted string; converts "\\n" to "\n"
onion_json_unquote_add :: (block: *onion_block, str: *u8) -> s64 #foreign libonion;

/**
* @short Flags to change some parameters of each key.
* @ingroup dict
*/
onion_dict_flags_e :: enum u32 {
    FREE_KEY   :: 2;
    FREE_VALUE :: 4;
    FREE_ALL   :: 6;
    DUP_KEY    :: 18;
    DUP_VALUE  :: 36;
    DUP_ALL    :: 54;
    REPLACE    :: 64;

    STRING     :: 0;
    DICT       :: 256;

    TYPE_MASK  :: 65280;

    ICASE      :: 1;

    OD_FREE_KEY   :: FREE_KEY;
    OD_FREE_VALUE :: FREE_VALUE;
    OD_FREE_ALL   :: FREE_ALL;
    OD_DUP_KEY    :: DUP_KEY;
    OD_DUP_VALUE  :: DUP_VALUE;
    OD_DUP_ALL    :: DUP_ALL;
    OD_REPLACE    :: REPLACE;

    OD_STRING     :: STRING;
    OD_DICT       :: DICT;

    OD_TYPE_MASK  :: TYPE_MASK;

    OD_ICASE      :: ICASE;
}

/// Initializes a dict.
onion_dict_new :: (__args: ..Any) -> *onion_dict #foreign libonion;

onion_dict_set_flags :: (dict: *onion_dict, flags: s32) -> void #foreign libonion;

/// Adds a value. Flags are or from onion_dict_flags_e, for example OD_DUP_ALL. @see onion_dict_flags_e
onion_dict_add :: (dict: *onion_dict, key: *u8, value: *void, flags: s32) -> void #foreign libonion;

/// Removes a value
onion_dict_remove :: (dict: *onion_dict, key: *u8) -> s32 #foreign libonion;

/// Removes the full dict struct form mem.
onion_dict_free :: (dict: *onion_dict) -> void #foreign libonion;

/// Merges argument dictionary into current
onion_dict_merge :: (me: *onion_dict, other: *onion_dict) -> void #foreign libonion;

/// Creates a soft duplicate of the dict.
onion_dict_dup :: (dict: *onion_dict) -> *onion_dict #foreign libonion;

/// Creates a hard duplicate of the dict.
onion_dict_hard_dup :: (dict: *onion_dict) -> *onion_dict #foreign libonion;

/// Gets a value
onion_dict_get :: (dict: *onion_dict, key: *u8) -> *u8 #foreign libonion;

/// Gets a value, recursively over the nested dicts, until NULL.
onion_dict_rget_CFormat :: (dict: *onion_dict, key: *u8, __args: ..Any) -> *u8 #foreign libonion "onion_dict_rget";
onion_dict_rget :: (dict: *onion_dict, key: string, __args: ..Any) -> *u8 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, key, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return onion_dict_rget_CFormat(dict, "%s", formatted_text.data);
} @PrintLike

/// Gets a dict. It ensures its a dict.
onion_dict_get_dict :: (dict: *onion_dict, key: *u8) -> *onion_dict #foreign libonion;

/// Gets a dict. It ensures its a dict. Recursively until NULL.
onion_dict_rget_dict_CFormat :: (dict: *onion_dict, key: *u8, __args: ..Any) -> *onion_dict #foreign libonion "onion_dict_rget_dict";
onion_dict_rget_dict :: (dict: *onion_dict, key: string, __args: ..Any) -> *onion_dict {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, key, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return onion_dict_rget_dict_CFormat(dict, "%s", formatted_text.data);
} @PrintLike

/// Prints a dot ready graph to stderr
onion_dict_print_dot :: (dict: *onion_dict) -> void #foreign libonion;

/// Visits the full graph in preorder, calling that function on each node. void func(void *data, const char *key, const void *value, int flags).
onion_dict_preorder :: (dict: *onion_dict, func: *void, data: *void) -> void #foreign libonion;

/// Counts elements
onion_dict_count :: (dict: *onion_dict) -> s32 #foreign libonion;

/// @{ @name lock management
/// Locks for reading. Several can read, one can write.
onion_dict_lock_read :: (dict: *onion_dict) -> void #foreign libonion;

/// Locks for writing
onion_dict_lock_write :: (dict: *onion_dict) -> void #foreign libonion;

/// Unlocks last lock
onion_dict_unlock :: (dict: *onion_dict) -> void #foreign libonion;

/// Converts a dict into a JSON onion_block
onion_dict_to_json :: (dict: *onion_dict) -> *onion_block #foreign libonion;

/// Converts a C string into a dictionary
onion_dict_from_json :: (data: *u8) -> *onion_dict #foreign libonion;

/**
* @short Flags about the request, including method, error status, http version.
* @ingroup request
*/
onion_request_flags_e :: enum u32 {
    METHODS         :: 15;
    GET             :: 0;
    POST            :: 1;
    HEAD            :: 2;
    OPTIONS         :: 3;
    PROPFIND        :: 4;
    PUT             :: 5;
    DELETE          :: 6;
    MOVE            :: 7;
    MKCOL           :: 8;
    PROPPATCH       :: 9;
    PATCH           :: 10;

    HTTP11          :: 16;
    POST_MULTIPART  :: 32;
    POST_URLENCODED :: 64;

    NO_KEEP_ALIVE   :: 256;
    HEADER_SENT_    :: 512;

    INTERNAL_ERROR  :: 4096;
    NOT_IMPLEMENTED :: 8192;
    NOT_FOUND       :: 12288;
    FORBIDDEN       :: 16384;

    OR_METHODS         :: METHODS;
    OR_GET             :: GET;
    OR_POST            :: POST;
    OR_HEAD            :: HEAD;
    OR_OPTIONS         :: OPTIONS;
    OR_PROPFIND        :: PROPFIND;
    OR_PUT             :: PUT;
    OR_DELETE          :: DELETE;
    OR_MOVE            :: MOVE;
    OR_MKCOL           :: MKCOL;
    OR_PROPPATCH       :: PROPPATCH;
    OR_PATCH           :: PATCH;

    OR_HTTP11          :: HTTP11;
    OR_POST_MULTIPART  :: POST_MULTIPART;
    OR_POST_URLENCODED :: POST_URLENCODED;

    OR_NO_KEEP_ALIVE   :: NO_KEEP_ALIVE;
    OR_HEADER_SENT_    :: HEADER_SENT_;

    OR_INTERNAL_ERROR  :: INTERNAL_ERROR;
    OR_NOT_IMPLEMENTED :: NOT_IMPLEMENTED;
    OR_NOT_FOUND       :: NOT_FOUND;
    OR_FORBIDDEN       :: FORBIDDEN;
}

onion_request_flags :: onion_request_flags_e;

/// List of known methods. NULL empty space, position is the method as listed at the flags. @see onion_request_flags
onion_request_methods: [16] *u8 #elsewhere libonion;

/// Creates a request from a listen point. Socket info and so on must be filled by user.
onion_request_new :: (con: *onion_listen_point) -> *onion_request #foreign libonion;

/// Creates a request, with socket info.
onion_request_new_from_socket :: (con: *onion_listen_point, fd: s32, cli_addr: *sockaddr_storage, cli_len: socklen_t) -> *onion_request #foreign libonion;

/// Deletes a request and all its data
onion_request_free :: (req: *onion_request) -> void #foreign libonion;

/// Reads some data from the input (net, file...) and performs the onion_request_fill
onion_request_write :: (req: *onion_request, data: *u8, length: u64) -> onion_connection_status #foreign libonion;

/// Gets the current path
onion_request_get_path :: (req: *onion_request) -> *u8 #foreign libonion;

/// Gets the full path of the request
onion_request_get_fullpath :: (req: *onion_request) -> *u8 #foreign libonion;

/// Gets the current flags, as in onion_request_flags_e
onion_request_get_flags :: (req: *onion_request) -> onion_request_flags #foreign libonion;

/// Moves the path pointer to later in the fullpath
onion_request_advance_path :: (req: *onion_request, addtopos: s64) -> void #foreign libonion;

/// Gets a header data
onion_request_get_header :: (req: *onion_request, header: *u8) -> *u8 #foreign libonion;

/// Gets query data
onion_request_get_query :: (req: *onion_request, query: *u8) -> *u8 #foreign libonion;

/// Gets query data, but returns a default value if key not found.
onion_request_get_queryd :: (req: *onion_request, key: *u8, def: *u8) -> *u8 #foreign libonion;

/// Gets post data
onion_request_get_post :: (req: *onion_request, query: *u8) -> *u8 #foreign libonion;

/// Gets file data
onion_request_get_file :: (req: *onion_request, query: *u8) -> *u8 #foreign libonion;

/// Gets session data
onion_request_get_session :: (req: *onion_request, query: *u8) -> *u8 #foreign libonion;

/// Get as literal constant string -e.g. "GET" or "PUT"- the method name or else NULL
onion_request_get_method_name :: (req: *onion_request) -> *u8 #foreign libonion;

/// Gets the header header data dict
onion_request_get_header_dict :: (req: *onion_request) -> *onion_dict #foreign libonion;

/// Gets request query dict
onion_request_get_query_dict :: (req: *onion_request) -> *onion_dict #foreign libonion;

/// Gets post data dict
onion_request_get_post_dict :: (req: *onion_request) -> *onion_dict #foreign libonion;

/// Gets post data dict
onion_request_get_file_dict :: (req: *onion_request) -> *onion_dict #foreign libonion;

/// Gets session data dict
onion_request_get_session_dict :: (req: *onion_request) -> *onion_dict #foreign libonion;

/// Gets the cookies dict
onion_request_get_cookies_dict :: (req: *onion_request) -> *onion_dict #foreign libonion;

/// Gets a cookie value
onion_request_get_cookie :: (req: *onion_request, cookiename: *u8) -> *u8 #foreign libonion;

/// Frees the session dictionary.
onion_request_session_free :: (req: *onion_request) -> void #foreign libonion;

/// Cleans the request object, to reuse it
onion_request_clean :: (req: *onion_request) -> void #foreign libonion;

/// Reqeust to close connection after one request is done, forces no keep alive.
onion_request_set_no_keep_alive :: (req: *onion_request) -> void #foreign libonion;

/// Returns if current request wants to keep alive
onion_request_keep_alive :: (req: *onion_request) -> s32 #foreign libonion;

/// Gets the language code for the current language. C is returned if none recognized.
onion_request_get_language_code :: (req: *onion_request) -> *u8 #foreign libonion;

/// Returns extra request data, such as POST with non-form data, or PROPFIND. Needs the Content-Length request header.
onion_request_get_data :: (req: *onion_request) -> *onion_block #foreign libonion;

/// Performs final touches to the request to its ready to be processed.
onion_request_polish :: (req: *onion_request) -> void #foreign libonion;

/// Executes the handler required for this request
onion_request_process :: (req: *onion_request) -> onion_connection_status #foreign libonion;

/// Get a string with a client description
onion_request_get_client_description :: (req: *onion_request) -> *u8 #foreign libonion;

/// Get the sockaddr_storage from the client, if any.
onion_request_get_sockadd_storage :: (req: *onion_request, client_len: *socklen_t) -> *sockaddr_storage #foreign libonion;

/// Determine if the request was sent over a secure listen point
onion_request_is_secure :: (req: *onion_request) -> bool #foreign libonion;

/// checks that handler to handle the request
onion_handler_handle :: (handler: *onion_handler, request: *onion_request, response: *onion_response) -> onion_connection_status #foreign libonion;

/// Creates an onion handler with that private datas.
onion_handler_new :: (handler: onion_handler_handler, privdata: *void, priv_data_free: onion_handler_private_data_free) -> *onion_handler #foreign libonion;

/// Frees the memory of the handler
onion_handler_free :: (handler: *onion_handler) -> s32 #foreign libonion;

/// Adds a handler to the list of handler of this level
onion_handler_add :: (base: *onion_handler, new_handler: *onion_handler) -> void #foreign libonion;

/// Returns the private data part of the handler. Useful at handlers, to customize the private data externally.
onion_handler_get_private_data :: (handler: *onion_handler) -> *void #foreign libonion;

onion_http_new :: (__args: ..Any) -> *onion_listen_point #foreign libonion;

onion_listen_point_new :: (__args: ..Any) -> *onion_listen_point #foreign libonion;
onion_listen_point_listen :: (unknown0: *onion_listen_point) -> s32 #foreign libonion;
onion_listen_point_listen_stop :: (op: *onion_listen_point) -> void #foreign libonion;
onion_listen_point_free :: (unknown0: *onion_listen_point) -> void #foreign libonion;
onion_listen_point_accept :: (unknown0: *onion_listen_point) -> s32 #foreign libonion;
onion_listen_point_request_init_from_socket :: (op: *onion_request) -> s32 #foreign libonion;
onion_listen_point_request_close_socket :: (oc: *onion_request) -> void #foreign libonion;

/**
* @short NEVER FAILING MEMORY ALLOCATORS
* @{
*
* These allocators should not fail: if memory is exhausted, they
* invoke the memory failure routine then abort with a short
* failure message.
*/
/**
* @short Our malloc wrapper for any kind of data, including data containing pointers.
* @ingroup low
*/
onion_low_malloc :: (sz: u64) -> *void #foreign libonion;

/**
* @short Our malloc wrapper for scalar data which does not contain any pointers inside.
* @ingroup low
*
* Knowing that a given zone does not contain any pointer can be useful, e.g. to Hans Boehm's conservative garbage
* collector on http://hboehm.info/gc/ using GC_MALLOC_ATOMIC....
*/
onion_low_scalar_malloc :: (sz: u64) -> *void #foreign libonion;

/// @short Our calloc wrapper for any kind of data, even scalar one.
/// @ingroup low
onion_low_calloc :: (nmemb: u64, size: u64) -> *void #foreign libonion;

/// @short Our realloc wrapper for any kind of data, even scalar one.
/// @ingroup low
onion_low_realloc :: (ptr: *void, size: u64) -> *void #foreign libonion;

/// @short Our strdup wrapper.
/// @ingroup low
onion_low_strdup :: (str: *u8) -> *u8 #foreign libonion;

/// @short Our malloc wrapper for any kind of data, including data containing pointers. May return NULL on fail.
/// @ingroup low
onion_low_try_malloc :: (sz: u64) -> *void #foreign libonion;

/// @short Our malloc wrapper for scalar data which does not contain any pointers inside.  May return NULL on fail.
/// @ingroup low
onion_low_try_scalar_malloc :: (sz: u64) -> *void #foreign libonion;

/// @short Our calloc wrapper for any kind of data, even scalar one.  May return NULL on fail.
/// @ingroup low
onion_low_try_calloc :: (nmemb: u64, size: u64) -> *void #foreign libonion;

/// @short Our realloc wrapper for any kind of data, even scalar one. May return NULL on fail.
/// @ingroup low
onion_low_try_realloc :: (ptr: *void, size: u64) -> *void #foreign libonion;

/// @short Our strdup wrapper. May return NULL on fail.
/// @ingroup low
onion_low_try_strdup :: (str: *u8) -> *u8 #foreign libonion;

/******** FREE WRAPPER ******/
/// @short Our free wrapper for any kind of data, even scalar one.
/// @ingroup low
onion_low_free :: (ptr: *void) -> void #foreign libonion;

/// @short Signatures of user configurable memory routine replacement.  @{
/// @ingroup low
onion_low_malloc_sigt :: #type (sz: u64) -> *void #c_call;
onion_low_scalar_malloc_sigt :: #type (sz: u64) -> *void #c_call;
onion_low_calloc_sigt :: #type (nmemb: u64, size: u64) -> *void #c_call;
onion_low_realloc_sigt :: #type (ptr: *void, size: u64) -> *void #c_call;
onion_low_strdup_sigt :: #type (ptr: *u8) -> *u8 #c_call;
onion_low_free_sigt :: #type (ptr: *void) -> void #c_call;

/**
* @short The memory failure handler is called with a short message.
* @ingroup low
*
* It generally should not return, i.e. should exit, abort, or perhaps
* setjmp....
*/
onion_low_memoryfailure_sigt :: #type (msg: *u8) -> void #c_call;

/**
* @short Our configurator for memory routines.
* @ingroup low
*
* To be called once before any other onion processing at initialization.
* All the routines should be explicitly provided.
*/
onion_low_initialize_memory_allocation :: (mallocrout: onion_low_malloc_sigt, scalarmallocrout: onion_low_scalar_malloc_sigt, callocrout: onion_low_calloc_sigt, reallocrout: onion_low_realloc_sigt, strduprout: onion_low_strdup_sigt, freerout: onion_low_free_sigt, memoryfailurerout: onion_low_memoryfailure_sigt) -> void #foreign libonion;

onion_log_level_e :: enum u32 {
    DEBUG0  :: 0;
    DEBUG   :: 1;
    INFO    :: 2;
    WARNING :: 3;
    ERROR   :: 4;

    O_DEBUG0  :: DEBUG0;
    O_DEBUG   :: DEBUG;
    O_INFO    :: INFO;
    O_WARNING :: WARNING;
    O_ERROR   :: ERROR;
}

onion_log_flags_e :: enum u32 {
    INIT       :: 1;
    NOCOLOR    :: 2;
    SYSLOGINIT :: 8;
    NOINFO     :: 16;
    NODEBUG    :: 32;

    OF_INIT       :: INIT;
    OF_NOCOLOR    :: NOCOLOR;
    OF_SYSLOGINIT :: SYSLOGINIT;
    OF_NOINFO     :: NOINFO;
    OF_NODEBUG    :: NODEBUG;
}

onion_log_level :: onion_log_level_e;
onion_log_flags: s32 #elsewhere libonion; // For some speedups, as not getting client info if not going to save it.

/// This function can be overwritten with whatever onion_log facility you want to use, same signature
onion_log: #type (level: onion_log_level, filename: *u8, lineno: s32, fmt: *u8, __args: ..Any) -> void #c_call #elsewhere libonion;

onion_log_stderr_CFormat :: (level: onion_log_level, filename: *u8, lineno: s32, fmt: *u8, __args: ..Any) -> void #foreign libonion "onion_log_stderr";
onion_log_stderr :: (level: onion_log_level, filename: *u8, lineno: s32, fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    onion_log_stderr_CFormat(level, filename, lineno, "%s", formatted_text.data);
} @PrintLike

onion_log_syslog_CFormat :: (level: onion_log_level, filename: *u8, lineno: s32, fmt: *u8, __args: ..Any) -> void #foreign libonion "onion_log_syslog";
onion_log_syslog :: (level: onion_log_level, filename: *u8, lineno: s32, fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    onion_log_syslog_CFormat(level, filename, lineno, "%s", formatted_text.data);
} @PrintLike

/// Sets the mime dictionary (extension -> mime_type)
onion_mime_set :: (unknown0: *onion_dict) -> void #foreign libonion;

/// Returns a mime type based on the file name.
onion_mime_get :: (filename: *u8) -> *u8 #foreign libonion;

/// Updates a mime record, for that extensions set that mimetype. If mimetype==NULL, removes it.
onion_mime_update :: (extension: *u8, mimetype: *u8) -> void #foreign libonion;

/**
* @short This is a list of standard response codes.
*
* Not all resposne codes are listed, as some of them may not have sense here.
* Check other sources for complete listings.
*/
onion_response_codes_e :: enum u32 {
    SWITCH_PROTOCOL       :: 101;

    OK                    :: 200;
    CREATED               :: 201;
    PARTIAL_CONTENT       :: 206;
    MULTI_STATUS          :: 207;

    MOVED                 :: 301;
    REDIRECT              :: 302;
    SEE_OTHER             :: 303;
    NOT_MODIFIED          :: 304;
    TEMPORARY_REDIRECT    :: 307;

    BAD_REQUEST           :: 400;
    UNAUTHORIZED          :: 401;
    FORBIDDEN             :: 403;
    NOT_FOUND             :: 404;
    METHOD_NOT_ALLOWED    :: 405;
    RANGE_NOT_SATISFIABLE :: 416;
    IM_A_TEAPOT           :: 418;

    INTERNAL_ERROR        :: 500;
    NOT_IMPLEMENTED       :: 501;
    BAD_GATEWAY           :: 502;
    SERVICE_UNAVAILABLE   :: 503;

    HTTP_SWITCH_PROTOCOL       :: SWITCH_PROTOCOL;

    HTTP_OK                    :: OK;
    HTTP_CREATED               :: CREATED;
    HTTP_PARTIAL_CONTENT       :: PARTIAL_CONTENT;
    HTTP_MULTI_STATUS          :: MULTI_STATUS;

    HTTP_MOVED                 :: MOVED;
    HTTP_REDIRECT              :: REDIRECT;
    HTTP_SEE_OTHER             :: SEE_OTHER;
    HTTP_NOT_MODIFIED          :: NOT_MODIFIED;
    HTTP_TEMPORARY_REDIRECT    :: TEMPORARY_REDIRECT;

    HTTP_BAD_REQUEST           :: BAD_REQUEST;
    HTTP_UNAUTHORIZED          :: UNAUTHORIZED;
    HTTP_FORBIDDEN             :: FORBIDDEN;
    HTTP_NOT_FOUND             :: NOT_FOUND;
    HTTP_METHOD_NOT_ALLOWED    :: METHOD_NOT_ALLOWED;
    HTTP_RANGE_NOT_SATISFIABLE :: RANGE_NOT_SATISFIABLE;
    HTTP_IM_A_TEAPOT           :: IM_A_TEAPOT;

    HTTP_INTERNAL_ERROR        :: INTERNAL_ERROR;
    HTTP_NOT_IMPLEMENTED       :: NOT_IMPLEMENTED;
    HTTP_BAD_GATEWAY           :: BAD_GATEWAY;
    HTTP_SERVICE_UNAVAILABLE   :: SERVICE_UNAVAILABLE;
}

onion_response_codes :: onion_response_codes_e;

/* utility function to return a string for a code above, so given
HTTP_OK returns "OK", etc... */
onion_response_code_description :: (code: s32) -> *u8 #foreign libonion;

/**
* @short Possible flags.
*
* These flags are used internally by the resposnes, but they can be the responses themselves of the handler when appropiate.
*/
onion_response_flags_e :: enum u32 {
    KEEP_ALIVE         :: 4;
    LENGTH_SET         :: 2;
    CLOSE_CONNECTION   :: 1;
    SKIP_CONTENT       :: 8;
    CHUNKED            :: 32;
    CONNECTION_UPGRADE :: 64;
    HEADER_SENT        :: 512;

    OR_KEEP_ALIVE         :: KEEP_ALIVE;
    OR_LENGTH_SET         :: LENGTH_SET;
    OR_CLOSE_CONNECTION   :: CLOSE_CONNECTION;
    OR_SKIP_CONTENT       :: SKIP_CONTENT;
    OR_CHUNKED            :: CHUNKED;
    OR_CONNECTION_UPGRADE :: CONNECTION_UPGRADE;
    OR_HEADER_SENT        :: HEADER_SENT;
}

onion_response_cookie_flags_e :: enum u32 {
    HTTP_ONLY       :: 1;
    SECURE          :: 2;
    SAMESITE_NONE   :: 16;
    SAMESITE_LAX    :: 32;
    SAMESITE_STRICT :: 64;

    OC_HTTP_ONLY       :: HTTP_ONLY;
    OC_SECURE          :: SECURE;
    OC_SAMESITE_NONE   :: SAMESITE_NONE;
    OC_SAMESITE_LAX    :: SAMESITE_LAX;
    OC_SAMESITE_STRICT :: SAMESITE_STRICT;
}

onion_response_flags :: onion_response_flags_e;

/// Generates a new response object
onion_response_new :: (req: *onion_request) -> *onion_response #foreign libonion;

/// Frees the memory consumed by this object. Returns keep_alive status.
onion_response_free :: (res: *onion_response) -> s32 #foreign libonion;

/// Adds a header to the response object
onion_response_set_header :: (res: *onion_response, key: *u8, value: *u8) -> void #foreign libonion;

/// Sets the header length. Normally it should be through set_header, but as its very common and needs some procesing here is a shortcut
onion_response_set_length :: (res: *onion_response, length: u64) -> void #foreign libonion;

/// Sets the return code
onion_response_set_code :: (res: *onion_response, code: s32) -> void #foreign libonion;

/// Gets the headers dictionary
onion_response_get_headers :: (res: *onion_response) -> *onion_dict #foreign libonion;

/// Sets a new cookie
onion_response_add_cookie :: (req: *onion_response, cookiename: *u8, cookievalue: *u8, validity_t: time_t, path: *u8, domain: *u8, flags: s32) -> bool #foreign libonion;

/// @{ @name Write functions
/// Writes all the header to the given fd
onion_response_write_headers :: (res: *onion_response) -> s32 #foreign libonion;

/// Writes some data to the response
onion_response_write :: (res: *onion_response, data: *u8, length: u64) -> s64 #foreign libonion;

/// Writes some data to the response. \0 ended string
onion_response_write0 :: (res: *onion_response, data: *u8) -> s64 #foreign libonion;

/// Writes some data to the response. \0 ended string, and encodes it if necesary into html entities to make it safe
onion_response_write_html_safe :: (res: *onion_response, data: *u8) -> s64 #foreign libonion;

/// Writes some data to the response. Using sprintf format strings.
onion_response_printf_CFormat :: (res: *onion_response, fmt: *u8, __args: ..Any) -> s64 #foreign libonion "onion_response_printf";
onion_response_printf :: (res: *onion_response, fmt: string, __args: ..Any) -> s64 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return onion_response_printf_CFormat(res, "%s", formatted_text.data);
} @PrintLike

/// Flushes remaining data on the buffer to the listen point.
onion_response_flush :: (res: *onion_response) -> s32 #foreign libonion;

/// @defgroup url URL handlers
/// @{
/// Creates an handler that checks that crrent path matches the current regexp, and passes to next.
onion_url_new :: (__args: ..Any) -> *onion_url #foreign libonion;

/// Frees the url data
onion_url_free :: (url: *onion_url) -> void #foreign libonion;

/// Adds a simple handler, with no custom data
onion_url_add :: (url: *onion_url, regexp: *u8, handler_f: onion_handler_handler) -> s32 #foreign libonion;

/// Adds a handler, with custom data
onion_url_add_with_data :: (url: *onion_url, regexp: *u8, handler_f: onion_handler_handler, data: *void, datafree: *void) -> s32 #foreign libonion;

/// Adds a handler, using handler methods
onion_url_add_handler :: (url: *onion_url, regexp: *u8, handler: *onion_handler) -> s32 #foreign libonion;

/// Adds another url on this regexp
onion_url_add_url :: (url: *onion_url, regexp: *u8, handler: *onion_url) -> s32 #foreign libonion;

/// Adds a simple handler, it has static data and a default return code
onion_url_add_static :: (url: *onion_url, regexp: *u8, text: *u8, http_code: s32) -> s32 #foreign libonion;

/// Returns the related handler for this url
onion_url_to_handler :: (url: *onion_url) -> *onion_handler #foreign libonion;

/// @defgroup onion Onion. Base server
/// @{
/// Creates the onion structure to fill with the server data, and later do the onion_listen()
onion_new :: (flags: onion_mode) -> *onion #foreign libonion;

/// set a client data in the onion, freeing the previous one if it exists.  Thread-safe.
onion_set_client_data :: (server: *onion, data: *void, data_free: onion_client_data_free_sig) -> void #foreign libonion;

/// Retrieve the client data in the onion server.  Thread-safe.
onion_client_data :: (server: *onion) -> *void #foreign libonion;

/// Performs the listening with the given mode
onion_listen :: (server: *onion) -> s32 #foreign libonion;

/// Stops the listening
onion_listen_stop :: (server: *onion) -> void #foreign libonion;

/// Removes the allocated data (also free the client data, if one was given).
onion_free :: (onion: *onion_t) -> void #foreign libonion;

/// Sets the root handler
onion_set_root_handler :: (server: *onion, handler: *onion_handler) -> void #foreign libonion;

/// Sets the root handler
onion_get_root_handler :: (server: *onion) -> *onion_handler #foreign libonion;

/// Sets the root handler
onion_set_internal_error_handler :: (server: *onion, handler: *onion_handler) -> void #foreign libonion;

/// Sets the port to listen
onion_set_port :: (server: *onion, port: *u8) -> void #foreign libonion;

/// Sets the hostname on which to listen
onion_set_hostname :: (server: *onion, hostname: *u8) -> void #foreign libonion;

/// Set a certificate for use in the connection
onion_set_certificate_CFormat :: (onion: *onion_t, type: onion_ssl_certificate_type, filename: *u8, __args: ..Any) -> s32 #foreign libonion "onion_set_certificate";
onion_set_certificate :: (onion: *onion_t, type: onion_ssl_certificate_type, filename: string, __args: ..Any) -> s32 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, filename, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return onion_set_certificate_CFormat(onion, type, "%s", formatted_text.data);
} @PrintLike

/// Adds a listen point, a listening address and port with a given protocol.
onion_add_listen_point :: (server: *onion, hostname: *u8, port: *u8, protocol: *onion_listen_point) -> s32 #foreign libonion;

/// Gets a single listen point, or NULL if not that many.
onion_get_listen_point :: (server: *onion, nlisten_point: s32) -> *onion_listen_point #foreign libonion;

/// Gets the current flags, for example to check SSL support.
onion_flags :: (onion: *onion_t) -> s32 #foreign libonion;

/// Sets the timeout, in milliseconds, 0 dont wait for incomming data (too strict maybe), -1 forever, clients closes connection
onion_set_timeout :: (onion: *onion_t, timeout: s32) -> void #foreign libonion;

/// Sets the maximum number of threads to use for requests. default 16.
onion_set_max_threads :: (onion: *onion_t, max_threads: s32) -> void #foreign libonion;

/// Sets this user as soon as listen starts.
onion_set_user :: (server: *onion, username: *u8) -> void #foreign libonion;

/// If no root handler is set, creates an url handler and returns it.
onion_root_url :: (server: *onion) -> *onion_url #foreign libonion;

/// If on poller mode, returns the poller, if not, returns NULL
onion_get_poller :: (server: *onion) -> *onion_poller #foreign libonion;

/// Set the maximum post size
onion_set_max_post_size :: (server: *onion, max_size: u64) -> void #foreign libonion;

/// Set the maximum post FILE size
onion_set_max_file_size :: (server: *onion, max_size: u64) -> void #foreign libonion;

/// Set a new session backend
onion_set_session_backend :: (server: *onion, sessions_backend: *onion_sessions) -> void #foreign libonion;

/// @ingroup poller
onion_poller_slot_type_e :: enum u32 {
    READ  :: 1;
    WRITE :: 2;
    OTHER :: 4;
    ALL   :: 7;

    O_POLL_READ  :: READ;
    O_POLL_WRITE :: WRITE;
    O_POLL_OTHER :: OTHER;
    O_POLL_ALL   :: ALL;
}

/// Create a new slot for the poller
onion_poller_slot_new :: (fd: s32, f: #type (unknown0: *void) -> s32 #c_call, data: *void) -> *onion_poller_slot #foreign libonion;

/// Cleans a poller slot. Do not call if already on the poller (onion_poller_add). Use onion_poller_remove instead.
onion_poller_slot_free :: (el: *onion_poller_slot) -> void #foreign libonion;

/// Sets the shutdown function for this poller slot
onion_poller_slot_set_shutdown :: (el: *onion_poller_slot, shutdown: #type (unknown0: *void) -> void #c_call, data: *void) -> void #foreign libonion;

/// Sets the timeout for this slot. Current implementation takes ms, but then it rounds to seconds.
onion_poller_slot_set_timeout :: (el: *onion_poller_slot, timeout_ms: s32) -> void #foreign libonion;

/// Sets the polling type: read/write/other. O_POLL_READ | O_POLL_WRITE | O_POLL_OTHER
onion_poller_slot_set_type :: (el: *onion_poller_slot, type: onion_poller_slot_type_e) -> void #foreign libonion;

/// Create a new poller
onion_poller_new :: (aprox_n: s32) -> *onion_poller #foreign libonion;

/// Frees the poller. It first stops it.
onion_poller_free :: (unknown0: *onion_poller) -> void #foreign libonion;

/// Sets the max events per thread queue size.
onion_poller_set_queue_size_per_thread :: (poller: *onion_poller, count: u64) -> void #foreign libonion;

/// Adds a slot to the poller
onion_poller_add :: (poller: *onion_poller, el: *onion_poller_slot) -> s32 #foreign libonion;

/// Gets the poller to do some modifications as change shutdown
onion_poller_get :: (poller: *onion_poller, fd: s32) -> *onion_poller_slot #foreign libonion;

/// Removes a fd from the poller
onion_poller_remove :: (poller: *onion_poller, fd: s32) -> s32 #foreign libonion;

/// Do the polling. If on several threads, this is done in every thread.
onion_poller_poll :: (unknown0: *onion_poller) -> void #foreign libonion;

/// Stops the polling. This only marks the flag, and should be cancelled with pthread_cancel.
onion_poller_stop :: (unknown0: *onion_poller) -> void #foreign libonion;

/// Initializes the sessions object
onion_sessions_new :: (__args: ..Any) -> *onion_sessions #foreign libonion;

/// Frees the sessions object
onion_sessions_free :: (sessions: *onion_sessions) -> void #foreign libonion;

/// Creates a session. Returns the session name.
onion_sessions_create :: (sessions: *onion_sessions) -> *u8 #foreign libonion;

/// Returns the session object.
onion_sessions_get :: (sessions: *onion_sessions, sessionId: *u8) -> *onion_dict #foreign libonion;

/// Store session
onion_sessions_save :: (sessions: *onion_sessions, sessionId: *u8, data: *onion_dict) -> void #foreign libonion;

/// Removes a session from the storage.
onion_sessions_remove :: (sessions: *onion_sessions, sessionId: *u8) -> void #foreign libonion;

stat :: struct {}

/// Shortcut for fast responses, like errors.
onion_shortcut_response :: (response: *u8, code: s32, req: *onion_request, res: *onion_response) -> onion_connection_status #foreign libonion;

/// Shortcut for fast responses, like errors, with extra headers.
onion_shortcut_response_extra_headers :: (response: *u8, code: s32, req: *onion_request, res: *onion_response, __args: ..Any) -> onion_connection_status #foreign libonion;

/// Shortcut for fast redirect. It tells the browser to look somewhere else.
onion_shortcut_redirect :: (newurl: *u8, req: *onion_request, res: *onion_response) -> onion_connection_status #foreign libonion;

/// Shortcut for fast internal redirect. It returns what the server would return with the new address.
onion_shortcut_internal_redirect :: (newurl: *u8, req: *onion_request, res: *onion_response) -> onion_connection_status #foreign libonion;

/// Shortcut for response a static file on disk
onion_shortcut_response_file :: (filename: *u8, req: *onion_request, res: *onion_response) -> onion_connection_status #foreign libonion;

/// Shortcut for response json data. Dict is freed before return.
onion_shortcut_response_json :: (d: *onion_dict, req: *onion_request, res: *onion_response) -> onion_connection_status #foreign libonion;

/// Shortcut to return the date in "RFC 822 / section 5, 4 digit years" date format.
onion_shortcut_date_string :: (t: time_t, dest: *u8) -> void #foreign libonion;

/// Shortcut to return the date in ISO format
onion_shortcut_date_string_iso :: (t: time_t, dest: *u8) -> void #foreign libonion;

/// Shortcut to unify the creation of etags.
onion_shortcut_etag :: (unknown0: *stat, etag: *[32] u8) -> void #foreign libonion;

/// Moves a file to another location
onion_shortcut_rename :: (orig: *u8, dest: *u8) -> s32 #foreign libonion;

onion_dict_node_t :: struct {}

/**
* @struct onion_dict_t
* @short A 'char *' to 'char *' dictionary.
* @ingroup dict
*/
onion_dict_t :: struct {
    root:     *onion_dict_node_t;

    refcount: s32;
    cmp:      #type (a: *u8, b: *u8) -> s32 #c_call;
}

/**
* @struct onion_t
* @short Webserver info.
* @ingroup onion
*
* This is information about onion implementation of the generic server. It contains the listening descriptors,
* the SSL parameters if SSL is enabled...
*
* This is platform specific server IO. Normally POSIX, using TCP/IP.
*/
onion_t :: struct {
    flags:                  s32;
    timeout:                s32; ///< Timeout in milliseconds
    username:               *u8;
    poller:                 *onion_poller;
    ///< List of listen_point. Everytime a new listen point adds,
    ///< it reallocs the full list. Its NULL terminated.
    ///< If NULL at listen, creates a http at 8080.
    listen_points:          **onion_listen_point;

    root_handler:           *onion_handler;
    /// Root processing handler for this server.
    internal_error_handler: *onion_handler;
    /// Root processing handler for this server.
    max_post_size:          u64;
    /// Maximum size of post data. This is the sum of posts, @see onion_request_write_post
    max_file_size:          u64;
    /// Maximum size of files. @see onion_request_write_post
    sessions:               *onion_sessions;
    /// Storage for sessions.
    client_data:            *void;
    client_data_free:       onion_client_data_free_sig;
}

/**
* @short List of pointers.
* @memberof onion_ptr_list_t
* @struct onion_ptr_list_t
* @ingroup ptr_list
*
* Used at least on onion_request to as a freelist;
*/
onion_ptr_list_t :: struct {
    ptr:  *void;
    next: *onion_ptr_list_t;
}

/**
* @struct onion_request_t
* @short Basic information about a request
* @ingroup request
*/
onion_request_t :: struct {
    connection:  struct {
        listen_point: *onion_listen_point;
        user_data:    *void;
        fd:           s32; ///< Original fd, to use at polling.
        cli_addr:     sockaddr_storage;
        cli_len:      socklen_t;
        cli_info:     *u8;
    };

    /// Connection to the client.
    flags:       s32;

    /// Flags for this response. Ored onion_request_flags_e
    fullpath:    *u8;
    /// Original path for the request
    path:        *u8;
    /// Path at this level. Its actually a pointer inside fullpath, removing the leading parts already processed by handlers
    headers:     *onion_dict;
    /// Headers prepared for this response.
    GET:         *onion_dict;
    /// When the query (?q=query) is processed, the dict with the values @see onion_request_parse_query
    POST:        *onion_dict;
    /// Dictionary with POST values
    FILES:       *onion_dict;
    /// Dictionary with files. They are automatically saved at /tmp/ and removed at request free. mapped string is full path.
    session:     *onion_dict;
    /// Pointer to related session
    data:        *onion_block;
    /// Some extra data from PUT, normally PROPFIND.
    cookies:     *onion_dict;
    /// Data about cookies.
    session_id:  *u8;
    /// Session id of the request, if any.
    parser:      *void;
    /// When recieving data, where to put it. Check at request_parser.c.
    parser_data: *void;
    /// Data necesary while parsing, muy be deleted when state changed. At free is simply freed.
    websocket:   *onion_websocket;
    /// Websocket handler.
    free_list:   *onion_ptr_list;
}

/**
* @struct onion_response_t
* @short The response
* @ingroup response
*/
onion_response_t :: struct {
    request:          *onion_request;
    /// Original request, so both are related, and get connected to the onion_t structure. Writes through the request connection.
    headers:          *onion_dict;
    /// Headers to write when appropiate.
    code:             s32;
    /// Response code
    flags:            s32;
    /// Flags. @see onion_response_flags_e
    length:           u32;
    /// Length, if known, of the response, to create the Content-Lenght header.
    sent_bytes:       u32;
    /// Sent bytes at content.
    sent_bytes_total: u32;
    /// Total sent bytes, including headers.
    buffer:           [1500] u8;
    /// buffer of output data. This way its do not send small chunks all the time, but blocks, so better network use. Also helps to keep alive connections with less than block size bytes.
    buffer_pos:       s64;
}

/**
* @struct onion_handler_t
* @short Information about a handler for onion. A tree structure of handlers is what really serves the data.
* @ingroup handler
*/
onion_handler_t :: struct {
    handler:        onion_handler_handler;
    /// callback that should return an onion_connection_status, and maybe process the request.
    priv_data_free: onion_handler_private_data_free;
    /// When freeing some memory, how to remove the private memory.
    priv_data:      *void;

    /// Private data as needed by the handler
    next:           *onion_handler_t;
}

/**
* @struct onion_sessions_t
* @short Storage for all sessions known
* @ingroup sessions
*
* This is a simple storage for sessions.
*
* Sessions are thread safe to use.
*
* The sessions themselves are not created until some data is written to it by the program. This way we avoid
* "session attack" where a malicious user sends many requests asking for new sessions.
*
* FIXME to add some LRU so that on some moment we can remove old sessions.
*/
onion_sessions_t :: struct {
    data: *void;

    get:  #type (sessions: *onion_sessions, sessionid: *u8) -> *onion_dict #c_call;
    save: #type (sessions: *onion_sessions, sessionid: *u8, data: *onion_dict) -> void #c_call;

    free: #type (sessions: *onion_sessions) -> void #c_call;
}

/**
* @struct onion_block_t
* @short Data type to store some raw data
* @ingroup block
*
* Normally it will be used to store strings when the size is unknown beforehand,
* but it can contain any type of data.
*
* Use with care as in most situations it might not be needed and more efficient
* alternatives may exist.
*/
onion_block_t :: struct {
    data:    *u8;
    size:    s32;
    maxsize: s32;
}

/// Opaque type used at onion_url internally
onion_url_data_t :: struct {}
onion_url_data :: onion_url_data_t;

/**
* @short Stored common data for each listen point: address, port, protocol status data...
* @struct onion_listen_point_t
* @memberof onion_listen_point_t
* @ingroup listen_point
*
* Stored information about the listen points; where they are listenting, and how to handle
* a new connection. Each listen point can understand a protocol and associated data.
*
* A protocol is HTTP, HTTPS, SPDY... each may do the request parsing in adiferent way, and the
* response write too.
*
* A listen point A can be HTTPS with one certificate, and B with another, with C using SPDY.
*
*/
onion_listen_point_t :: struct {
    server:         *onion; ///< Onion server
    hostname:       *u8; ///< Stated hostname, as a string. If NULL tries to attach to any hostname, normally 0.0.0.0 (ipv4 and ipv6)
    port:           *u8; ///< Stated port, if none then 8080
    listenfd:       s32; ///< For socket listening listen points, the listen fd. For others may be -1 as not used, or an fd to watch and when changed calls the request_init with a new request.
    secure:         bool; ///< Is this listen point secure?

    /// Internal data used by the listen point, for example in HTTPS is the certificate loaded data.
    user_data:      *void;

    /// Method to call to free the user data
    free_user_data: #type (lp: *onion_listen_point) -> void #c_call;

    /**
    * @short How to start the listening phase.
    *
    * Normally NULL means socket listening.
    *
    * Must set at listenfd a file descriptor that will be polled, and when data arrives,
    * it will call the request_init with a new request object.
    */
    listen:         #type (lp: *onion_listen_point) -> void #c_call;

    /**
    * @short Frees internal data and state of listen point, but not listen point itself.
    *
    * If NULL means socket listen, and should be closed calling onion_listen_point_listen_stop.
    * If a port is open must be closed. Its the exact oposite of listen.
    *
    * May be called in a loop: listen -> ... -> listen_stop -> ... -> listen.
    *
    * It also may be called two succesive times, and should do nothing on second.
    */
    listen_stop:    #type (lp: *onion_listen_point) -> void #c_call;

    /// @{ @name To be used by requests, but as these methods are shared by protocol, done here.
    /**
    * @short Initialize the request object. Data is already malloc'd but specific listen protocols may need custom data
    *
    * Has default implementation that do the socket accept and set of default params. On some protocols may be
    * reimplemented to do non socket-request accept.
    *
    * @returns 0 if everything ok, <0 if request is invalid and should be closed.
    */
    request_init:   #type (req: *onion_request) -> s32 #c_call;
    read_ready:     #type (req: *onion_request) -> s32 #c_call; ///< When poller detects data is ready to be read. Might be diferent in diferent parts of the processing.
    write:          #type (req: *onion_request, data: *u8, len: u64) -> s64 #c_call; ///< Write data to the given request.
    read:           #type (req: *onion_request, data: *u8, len: u64) -> s64 #c_call; ///< Read data from the given request and write it in data.
    close:          #type (req: *onion_request) -> void #c_call; ///< Closes the connection and frees listen point user data. Request itself it left. It is called from onion_request_free ONLY.
}

/**
* @short Websocket data type, as returned by onion_websocket_new
* @memberof onion_websocket_t
* @struct onion_websocket_t
* @ingroup websocket
*
* FIXME: Some websocket description on how to use.
*
* Ping requests (client->server) are handled internally. pong answers are not (server->client).
*
* When a ping request is received, callback may be called with length=0, and no data waiting to be read.
*/
onion_websocket_t :: struct {
    req:            *onion_request;
    /// Associated request
    callback:       onion_websocket_callback_t;

    /// Callback to call, if any, when new data is available.
    user_data:      *void;
    free_user_data: #type (unknown0: *void) -> void #c_call;

    data_left:      s64;
    mask:           [4] u8;
    mask_pos:       s8;
    flags:          s8;
    /// Defined at websocket.c
    opcode:         onion_websocket_opcode;
}

/// Get the current websocket handler, or create it. If not a websocket request, returns NULL
onion_websocket_new :: (req: *onion_request, res: *onion_response) -> *onion_websocket #foreign libonion;

/// When freed, the callback is invoked with a negative data length.
onion_websocket_free :: (ws: *onion_websocket) -> void #foreign libonion;
onion_websocket_close :: (ws: *onion_websocket, status: *u8) -> void #foreign libonion;

onion_websocket_set_callback :: (ws: *onion_websocket, cb: onion_websocket_callback_t) -> void #foreign libonion;

onion_websocket_set_userdata :: (ws: *onion_websocket, userdata: *void, free_userdata: #type (unknown0: *void) -> void #c_call) -> void #foreign libonion;

onion_websocket_read :: (ws: *onion_websocket, buffer: *u8, len: u64) -> s32 #foreign libonion;
onion_websocket_write :: (ws: *onion_websocket, buffer: *u8, len: u64) -> s32 #foreign libonion;

onion_websocket_printf_CFormat :: (ws: *onion_websocket, str: *u8, __args: ..Any) -> s32 #foreign libonion "onion_websocket_printf";
onion_websocket_printf :: (ws: *onion_websocket, str: string, __args: ..Any) -> s32 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, str, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return onion_websocket_printf_CFormat(ws, "%s", formatted_text.data);
} @PrintLike

onion_websocket_call :: (ws: *onion_websocket) -> onion_connection_status #foreign libonion;
onion_websocket_set_opcode :: (ws: *onion_websocket, opcode: onion_websocket_opcode) -> void #foreign libonion;

onion_websocket_get_opcode :: (ws: *onion_websocket) -> onion_websocket_opcode #foreign libonion;

onion_ptr_list_new :: (__args: ..Any) -> *onion_ptr_list #foreign libonion;
onion_ptr_list_add :: (l: *onion_ptr_list, ptr: *void) -> *onion_ptr_list #foreign libonion;
onion_ptr_list_remove :: (l: *onion_ptr_list, ptr: *void) -> *onion_ptr_list #foreign libonion;
onion_ptr_list_free :: (l: *onion_ptr_list) -> void #foreign libonion;
onion_ptr_list_foreach :: (l: *onion_ptr_list, f: #type (ptr: *void) -> void #c_call) -> void #foreign libonion;
onion_ptr_list_filter :: (l: *onion_ptr_list, f: #type (data: *void, ptr: *void) -> bool #c_call, data: *void) -> *onion_ptr_list #foreign libonion;

onion_ptr_list_count :: (l: *onion_ptr_list) -> u64 #foreign libonion;

#scope_file

#import "Basic"; // For push_context

libonion :: #library "linux/libonion";
