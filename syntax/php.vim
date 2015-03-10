" Vim syntax file
" " Language: PHP 5.3 & up
" "
" " {{{ BLOCK: Last-modified
"
" " Thu, 11 Dec 2014 09:22:42 +0000, PHP 5.6.3-1+deb.sury.org~trusty+1
"
" " }}}
" "
" " Maintainer: Paul Garvin <paul@paulgarvin.net>
" "
" " Contributor: Stan Angeloff <stanimir@angeloff.name>
" " URL: https://github.com/StanAngeloff/php.vim
" "
" " Contributor: Alessandro Antonello <aleantonello@hotmail.com>
" " URL: https://github.com/aantonello/php.vim
" "
" " Contributor: Tim Carry <tim@pixelastic.com>
" " URL: https://github.com/pixelastic/php.vim
" "
" " Contributor: Joshua Sherman <josh@gravityblvd.com>
" " URL: https://github.com/joshtronic/php.vim
" "
" " Former Maintainer:  Peter Hodge <toomuchphp-vim@yahoo.com>
" " Former URL: http://www.vim.org/scripts/script.php?script_id=1571
" "
" " Note: All of the switches for VIM 5.X and 6.X compatability were removed.
" "       DO NOT USE THIS FILE WITH A VERSION OF VIM < 7.0.
" "
" " Note: If you are using a colour terminal with dark background, you will
" probably find
" "       the 'elflord' colorscheme is much better for PHP's syntax than the default
" "       colourscheme, because elflord's colours will better highlight the break-points
" "       (Statements) in your code.
" "
" " Options:  php_sql_query = 1  for SQL syntax highlighting inside strings (default: 0)
" "           php_sql_heredoc = 1 for SQL syntax highlighting inside heredocs (default: 1)
" "           b:sql_type_override = 'postgresql' for PostgreSQL syntax highlighting in current buffer (default: 'mysql')
" "           g:sql_type_default = 'postgresql' to set global SQL syntax highlighting language default (default: 'mysql')"
" "           php_html_in_strings = 1  for HTML syntax highlighting inside strings (default: 0)
" "           php_html_in_heredoc = 1 for HTML syntax highlighting inside heredocs (default: 1)
" "           php_html_load = 1 for loading the HTML syntax at all.  Overwrites php_html_in_strings and php_html_in_heredoc (default: 1)
" "           php_ignore_phpdoc = 0 for not highlighting parts of phpDocs
" "           php_parent_error_close = 1  for highlighting parent error ] or )
" (default: 0)
" "           php_parent_error_open = 1  for skipping an php end tag,
" "                                      if there exists an open ( or [
" without a closing one (default: 0)
" "           php_folding = 1  for folding loops, if/elseif/else, switch,
" try/catch, classes, and functions based on
" "                            indent, finds a } with an indent matching the
" structure.
" "                         2  for folding all { }, ( ), and [ ] pairs. (see
" known bugs ii)
" "           php_phpdoc_folding = 0 Don't fold phpDoc comments (default)
" "                                1 Fold phpDoc comments
" "           php_sync_method = x
" "                             x=-1 to sync by search ( default )
" "                             x>0 to sync at least x lines backwards
" "                             x=0 to sync from start
" "
" "           php_var_selector_is_identifier = 1  include the '$' as part of
" identifiers.
" "                                               Variables will be
" highlighted as a single 'phpIdentifier' group
" "                                               instead of as 'phpOperator'
" for '$' and 'phpIdentifier' the rest.
" "                                               (default: 0)
" "
" "           g:php_syntax_extensions_enabled
" "           g:php_syntax_extensions_disabled  A list of extension names
" (lowercase) for which built-in functions,
" "                                             constants, classes and
" interfaces is enabled / disabled.
" "
" " Known Bugs:
" "  - setting  php_parent_error_close  on  and  php_parent_error_open  off
" "    has these two leaks:
" "     i) A closing ) or ] inside a string match to the last open ( or [
" "        before the string, when the the closing ) or ] is on the same line
" "        where the string started. In this case a following ) or ] after
" "        the string would be highlighted as an error, what is incorrect.
" "    ii) Same problem if you are setting php_folding = 2 with a closing
" "        } inside an string on the first line of this string.
" "
" "  - A double-quoted string like this:
" "      "$foo->someVar->someOtherVar->bar"
" "    will highight '->someOtherVar->bar' as though they will be parsed
" "    as object member variables, but PHP only recognizes the first
" "    object member variable ($foo->someVar).
"
"
" if exists("b:current_syntax")
"   finish
"   endif
"
"   if !exists("main_syntax")
"     let main_syntax = 'php'
"     endif
"
"     " Save the 'iskeyword' setting before including the HTML syntax.
"     " See https://github.com/pangloss/vim-javascript/issues/153
"     let s:iskeyword_save = &iskeyword
"
"     if !exists("php_html_load")
"       let php_html_load=1
"       endif
"
"       if (exists("php_html_load") && php_html_load)
"         if !exists("php_html_in_heredoc")
"             let php_html_in_heredoc=1
"               endif
"
"                 runtime! syntax/html.vim
"                   unlet! b:current_syntax
"                     " HTML syntax file turns on spelling for all top level
"                     words, we attempt to turn off
"                       syntax spell default
"
"                         syn cluster htmlPreproc add=phpRegion
"                         else
"                           " If it is desired that the HTML syntax file not
"                           be loaded at all, set the options for highlighting
"                           it in string
"                             " and heredocs to false.
"                               let php_html_in_strings=0
"                                 let php_html_in_heredoc=0
"                                 endif
"
"                                 if (exists("php_html_in_strings") && php_html_in_strings)
"                                   syn cluster phpAddStrings add=@htmlTop
"                                   endif
"
"                                   " Set sync method if none declared
"                                   if ( ! exists("php_sync_method") || php_sync_method == 1)
"                                     if exists("php_minlines")
"                                         let php_sync_method=php_minlines
"                                           else
"                                               let php_sync_method=-1
"                                                 endif
"                                                 endif
"
"                                                 if !exists("php_sql_heredoc")
"                                                   let php_sql_heredoc=1
"                                                   endif
"
"                                                   if ((exists("php_sql_query") && php_sql_query) || (exists("php_sql_heredoc") && php_sql_heredoc))
"                                                     " Use MySQL as the default SQL syntax file.
"                                                       " See https://github.com/StanAngeloff/php.vim/pull/1
"                                                         if !exists('b:sql_type_override') && !exists('g:sql_type_default')
"                                                             let b:sql_type_override='mysql'
"                                                               endif
"                                                                 syn include @sqlTop syntax/sql.vim
"
"                                                                   syn sync clear
"                                                                     unlet! b:current_syntax
"                                                                       syn cluster sqlTop remove=sqlString,sqlComment
"
"                                                                         if (exists("php_sql_query") && php_sql_query)
"                                                                             syn cluster phpAddStrings contains=@sqlTop
"                                                                               endif
"                                                                               endif
"
"                                                                               "
"                                                                               set
"                                                                               default
"                                                                               for
"                                                                               php_folding
"                                                                               so
"                                                                               we
"                                                                               don't
"                                                                               have
"                                                                               to
"                                                                               keep
"                                                                               checking
"                                                                               its
"                                                                               existence.
"                                                                               if
"                                                                               !exists("php_folding")
"                                                                                 let
"                                                                                 php_folding
"                                                                                 =
"                                                                                 0
"                                                                                 endif
"
"                                                                                 "
"                                                                                 set
"                                                                                 default
"                                                                                 for
"                                                                                 php_phpdoc_folding
"                                                                                 so
"                                                                                 we
"                                                                                 don't
"                                                                                 have
"                                                                                 to
"                                                                                 keep
"                                                                                 checking
"                                                                                 its
"                                                                                 existence.
"                                                                                 if
"                                                                                 !exists("php_phpdoc_folding")
"                                                                                   let
"                                                                                   php_phpdoc_folding
"                                                                                   =
"                                                                                   0
"                                                                                   endif
"
"                                                                                   "
"                                                                                   Folding
"                                                                                   Support
"                                                                                   {{{
"                                                                                   "
"                                                                                   if
"                                                                                   php_folding==1
"                                                                                   &&
"                                                                                   has("folding")
"                                                                                     command!
"                                                                                     -nargs=+
"                                                                                     SynFold
"                                                                                     <args>
"                                                                                     fold
"                                                                                     else
"                                                                                       command!
"                                                                                       -nargs=+
"                                                                                       SynFold
"                                                                                       <args>
"                                                                                       endif
"
"                                                                                       if
"                                                                                       php_phpdoc_folding==1
"                                                                                       &&
"                                                                                       has("folding")
"                                                                                         command!
"                                                                                         -nargs=+
"                                                                                         SynFoldDoc
"                                                                                         <args>
"                                                                                         fold
"                                                                                         else
"                                                                                           command!
"                                                                                           -nargs=+
"                                                                                           SynFoldDoc
"                                                                                           <args>
"                                                                                           endif
"
"                                                                                           "
"                                                                                           }}}
"
"                                                                                           syn
"                                                                                           case
"                                                                                           match
"
"                                                                                           "
"                                                                                           Superglobals
"                                                                                           syn
"                                                                                           keyword
"                                                                                           phpSuperglobals
"                                                                                           GLOBALS
"                                                                                           _GET
"                                                                                           _POST
"                                                                                           _REQUEST
"                                                                                           _FILES
"                                                                                           _COOKIE
"                                                                                           _SERVER
"                                                                                           _SESSION
"                                                                                           _ENV
"                                                                                           HTTP_RAW_POST_DATA
"                                                                                           php_errormsg
"                                                                                           http_response_header
"                                                                                           argc
"                                                                                           argv
"                                                                                           contained
"
"                                                                                           "
"                                                                                           Magic
"                                                                                           Constants
"                                                                                           syn
"                                                                                           keyword
"                                                                                           phpMagicConstants
"                                                                                           __LINE__
"                                                                                           __FILE__
"                                                                                           __DIR__
"                                                                                           __FUNCTION__
"                                                                                           __CLASS__
"                                                                                           __TRAIT__
"                                                                                           __METHOD__
"                                                                                           __NAMESPACE__
"                                                                                           contained
"
"                                                                                           "
"                                                                                           $_SERVER
"                                                                                           Variables
"                                                                                           syn
"                                                                                           keyword
"                                                                                           phpServerVars
"                                                                                           GATEWAY_INTERFACE
"                                                                                           SERVER_NAME
"                                                                                           SERVER_SOFTWARE
"                                                                                           SERVER_PROTOCOL
"                                                                                           REQUEST_METHOD
"                                                                                           QUERY_STRING
"                                                                                           DOCUMENT_ROOT
"                                                                                           HTTP_ACCEPT
"                                                                                           HTTP_ACCEPT_CHARSET
"                                                                                           HTTP_ENCODING
"                                                                                           HTTP_ACCEPT_LANGUAGE
"                                                                                           HTTP_CONNECTION
"                                                                                           HTTP_HOST
"                                                                                           HTTP_REFERER
"                                                                                           HTTP_USER_AGENT
"                                                                                           REMOTE_ADDR
"                                                                                           REMOTE_PORT
"                                                                                           SCRIPT_FILENAME
"                                                                                           SERVER_ADMIN
"                                                                                           SERVER_PORT
"                                                                                           SERVER_SIGNATURE
"                                                                                           PATH_TRANSLATED
"                                                                                           SCRIPT_NAME
"                                                                                           REQUEST_URI
"                                                                                           PHP_SELF
"                                                                                           contained
"
"                                                                                           "
"                                                                                           {{{
"                                                                                           BLOCK:
"                                                                                           Extensions
"
"                                                                                           if
"                                                                                           !
"                                                                                           exists("g:php_syntax_extensions_enabled")
"                                                                                               let
"                                                                                               g:php_syntax_extensions_enabled
"                                                                                               =
"                                                                                               ["bcmath",
"                                                                                               "bz2",
"                                                                                               "core",
"                                                                                               "curl",
"                                                                                               "date",
"                                                                                               "dom",
"                                                                                               "ereg",
"                                                                                               "gd",
"                                                                                               "gettext",
"                                                                                               "hash",
"                                                                                               "iconv",
"                                                                                               "json",
"                                                                                               "libxml",
"                                                                                               "mbstring",
"                                                                                               "mcrypt",
"                                                                                               "mhash",
"                                                                                               "mysql",
"                                                                                               "mysqli",
"                                                                                               "openssl",
"                                                                                               "pcre",
"                                                                                               "pdo",
"                                                                                               "pgsql",
"                                                                                               "phar",
"                                                                                               "reflection",
"                                                                                               "session",
"                                                                                               "simplexml",
"                                                                                               "soap",
"                                                                                               "sockets",
"                                                                                               "spl",
"                                                                                               "sqlite3",
"                                                                                               "standard",
"                                                                                               "tokenizer",
"                                                                                               "wddx",
"                                                                                               "xml",
"                                                                                               "xmlreader",
"                                                                                               "xmlwriter",
"                                                                                               "zip",
"                                                                                               "zlib"]
"                                                                                               endif
"                                                                                               if
"                                                                                               !
"                                                                                               exists("g:php_syntax_extensions_disabled")
"                                                                                                   let
"                                                                                                   g:php_syntax_extensions_disabled
"                                                                                                   =
"                                                                                                   []
"                                                                                                   endif
"                                                                                                   syn
"                                                                                                   case
"                                                                                                   match
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "core")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "core")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "core") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "core") < 0)
"                                                                                                   " Core constants
"                                                                                                   syn keyword phpConstants DEBUG_BACKTRACE_IGNORE_ARGS DEBUG_BACKTRACE_PROVIDE_OBJECT DEFAULT_INCLUDE_PATH E_ALL E_COMPILE_ERROR E_COMPILE_WARNING E_CORE_ERROR E_CORE_WARNING E_DEPRECATED E_ERROR E_NOTICE E_PARSE E_RECOVERABLE_ERROR E_STRICT E_USER_DEPRECATED E_USER_ERROR E_USER_NOTICE E_USER_WARNING E_WARNING PEAR_EXTENSION_DIR PEAR_INSTALL_DIR PHP_BINARY PHP_BINDIR PHP_CONFIG_FILE_PATH PHP_CONFIG_FILE_SCAN_DIR PHP_DATADIR PHP_DEBUG PHP_EOL PHP_EXTENSION_DIR PHP_EXTRA_VERSION PHP_INT_MAX PHP_INT_SIZE PHP_LIBDIR PHP_LOCALSTATEDIR PHP_MAJOR_VERSION PHP_MANDIR PHP_MAXPATHLEN PHP_MINOR_VERSION PHP_OS PHP_OUTPUT_HANDLER_CLEAN PHP_OUTPUT_HANDLER_CLEANABLE PHP_OUTPUT_HANDLER_CONT PHP_OUTPUT_HANDLER_DISABLED PHP_OUTPUT_HANDLER_END PHP_OUTPUT_HANDLER_FINAL PHP_OUTPUT_HANDLER_FLUSH PHP_OUTPUT_HANDLER_FLUSHABLE PHP_OUTPUT_HANDLER_REMOVABLE PHP_OUTPUT_HANDLER_START PHP_OUTPUT_HANDLER_STARTED PHP_OUTPUT_HANDLER_STDFLAGS PHP_OUTPUT_HANDLER_WRITE PHP_PREFIX PHP_RELEASE_VERSION PHP_SAPI PHP_SHLIB_SUFFIX PHP_SYSCONFDIR PHP_VERSION PHP_VERSION_ID PHP_ZTS STDERR STDIN STDOUT UPLOAD_ERR_CANT_WRITE UPLOAD_ERR_EXTENSION UPLOAD_ERR_FORM_SIZE UPLOAD_ERR_INI_SIZE UPLOAD_ERR_NO_FILE UPLOAD_ERR_NO_TMP_DIR UPLOAD_ERR_OK UPLOAD_ERR_PARTIAL ZEND_DEBUG_BUILD ZEND_THREAD_SAFE contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "curl") >= 0 && index(g:php_syntax_extensions_disabled, "curl") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "curl") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "curl") < 0)
"                                                                                                   " curl constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   CURLAUTH_ANY
"                                                                                                   CURLAUTH_ANYSAFE
"                                                                                                   CURLAUTH_BASIC
"                                                                                                   CURLAUTH_DIGEST
"                                                                                                   CURLAUTH_DIGEST_IE
"                                                                                                   CURLAUTH_GSSNEGOTIATE
"                                                                                                   CURLAUTH_NONE
"                                                                                                   CURLAUTH_NTLM
"                                                                                                   CURLAUTH_ONLY
"                                                                                                   CURLE_ABORTED_BY_CALLBACK
"                                                                                                   CURLE_BAD_CALLING_ORDER
"                                                                                                   CURLE_BAD_CONTENT_ENCODING
"                                                                                                   CURLE_BAD_DOWNLOAD_RESUME
"                                                                                                   CURLE_BAD_FUNCTION_ARGUMENT
"                                                                                                   CURLE_BAD_PASSWORD_ENTERED
"                                                                                                   CURLE_COULDNT_CONNECT
"                                                                                                   CURLE_COULDNT_RESOLVE_HOST
"                                                                                                   CURLE_COULDNT_RESOLVE_PROXY
"                                                                                                   CURLE_FAILED_INIT
"                                                                                                   CURLE_FILESIZE_EXCEEDED
"                                                                                                   CURLE_FILE_COULDNT_READ_FILE
"                                                                                                   CURLE_FTP_ACCESS_DENIED
"                                                                                                   CURLE_FTP_BAD_DOWNLOAD_RESUME
"                                                                                                   CURLE_FTP_CANT_GET_HOST
"                                                                                                   CURLE_FTP_CANT_RECONNECT
"                                                                                                   CURLE_FTP_COULDNT_GET_SIZE
"                                                                                                   CURLE_FTP_COULDNT_RETR_FILE
"                                                                                                   CURLE_FTP_COULDNT_SET_ASCII
"                                                                                                   CURLE_FTP_COULDNT_SET_BINARY
"                                                                                                   CURLE_FTP_COULDNT_STOR_FILE
"                                                                                                   CURLE_FTP_COULDNT_USE_REST
"                                                                                                   CURLE_FTP_PARTIAL_FILE
"                                                                                                   CURLE_FTP_PORT_FAILED
"                                                                                                   CURLE_FTP_QUOTE_ERROR
"                                                                                                   CURLE_FTP_SSL_FAILED
"                                                                                                   CURLE_FTP_USER_PASSWORD_INCORRECT
"                                                                                                   CURLE_FTP_WEIRD_227_FORMAT
"                                                                                                   CURLE_FTP_WEIRD_PASS_REPLY
"                                                                                                   CURLE_FTP_WEIRD_PASV_REPLY
"                                                                                                   CURLE_FTP_WEIRD_SERVER_REPLY
"                                                                                                   CURLE_FTP_WEIRD_USER_REPLY
"                                                                                                   CURLE_FTP_WRITE_ERROR
"                                                                                                   CURLE_FUNCTION_NOT_FOUND
"                                                                                                   CURLE_GOT_NOTHING
"                                                                                                   CURLE_HTTP_NOT_FOUND
"                                                                                                   CURLE_HTTP_PORT_FAILED
"                                                                                                   CURLE_HTTP_POST_ERROR
"                                                                                                   CURLE_HTTP_RANGE_ERROR
"                                                                                                   CURLE_HTTP_RETURNED_ERROR
"                                                                                                   CURLE_LDAP_CANNOT_BIND
"                                                                                                   CURLE_LDAP_INVALID_URL
"                                                                                                   CURLE_LDAP_SEARCH_FAILED
"                                                                                                   CURLE_LIBRARY_NOT_FOUND
"                                                                                                   CURLE_MALFORMAT_USER
"                                                                                                   CURLE_OBSOLETE
"                                                                                                   CURLE_OK
"                                                                                                   CURLE_OPERATION_TIMEDOUT
"                                                                                                   CURLE_OPERATION_TIMEOUTED
"                                                                                                   CURLE_OUT_OF_MEMORY
"                                                                                                   CURLE_PARTIAL_FILE
"                                                                                                   CURLE_READ_ERROR
"                                                                                                   CURLE_RECV_ERROR
"                                                                                                   CURLE_SEND_ERROR
"                                                                                                   CURLE_SHARE_IN_USE
"                                                                                                   CURLE_SSH
"                                                                                                   CURLE_SSL_CACERT
"                                                                                                   CURLE_SSL_CERTPROBLEM
"                                                                                                   CURLE_SSL_CIPHER
"                                                                                                   CURLE_SSL_CONNECT_ERROR
"                                                                                                   CURLE_SSL_ENGINE_NOTFOUND
"                                                                                                   CURLE_SSL_ENGINE_SETFAILED
"                                                                                                   CURLE_SSL_PEER_CERTIFICATE
"                                                                                                   CURLE_TELNET_OPTION_SYNTAX
"                                                                                                   CURLE_TOO_MANY_REDIRECTS
"                                                                                                   CURLE_UNKNOWN_TELNET_OPTION
"                                                                                                   CURLE_UNSUPPORTED_PROTOCOL
"                                                                                                   CURLE_URL_MALFORMAT
"                                                                                                   CURLE_URL_MALFORMAT_USER
"                                                                                                   CURLE_WRITE_ERROR
"                                                                                                   CURLFTPAUTH_DEFAULT
"                                                                                                   CURLFTPAUTH_SSL
"                                                                                                   CURLFTPAUTH_TLS
"                                                                                                   CURLFTPMETHOD_MULTICWD
"                                                                                                   CURLFTPMETHOD_NOCWD
"                                                                                                   CURLFTPMETHOD_SINGLECWD
"                                                                                                   CURLFTPSSL_ALL
"                                                                                                   CURLFTPSSL_CCC_ACTIVE
"                                                                                                   CURLFTPSSL_CCC_NONE
"                                                                                                   CURLFTPSSL_CCC_PASSIVE
"                                                                                                   CURLFTPSSL_CONTROL
"                                                                                                   CURLFTPSSL_NONE
"                                                                                                   CURLFTPSSL_TRY
"                                                                                                   CURLGSSAPI_DELEGATION_FLAG
"                                                                                                   CURLGSSAPI_DELEGATION_POLICY_FLAG
"                                                                                                   CURLINFO_APPCONNECT_TIME
"                                                                                                   CURLINFO_CERTINFO
"                                                                                                   CURLINFO_CONDITION_UNMET
"                                                                                                   CURLINFO_CONNECT_TIME
"                                                                                                   CURLINFO_CONTENT_LENGTH_DOWNLOAD
"                                                                                                   CURLINFO_CONTENT_LENGTH_UPLOAD CURLINFO_CONTENT_TYPE CURLINFO_COOKIELIST CURLINFO_EFFECTIVE_URL CURLINFO_FILETIME CURLINFO_FTP_ENTRY_PATH CURLINFO_HEADER_OUT CURLINFO_HEADER_SIZE CURLINFO_HTTPAUTH_AVAIL CURLINFO_HTTP_CODE CURLINFO_HTTP_CONNECTCODE CURLINFO_LASTONE CURLINFO_LOCAL_IP CURLINFO_LOCAL_PORT CURLINFO_NAMELOOKUP_TIME CURLINFO_NUM_CONNECTS CURLINFO_OS_ERRNO CURLINFO_PRETRANSFER_TIME CURLINFO_PRIMARY_IP CURLINFO_PRIMARY_PORT CURLINFO_PRIVATE CURLINFO_PROXYAUTH_AVAIL CURLINFO_REDIRECT_COUNT CURLINFO_REDIRECT_TIME CURLINFO_REDIRECT_URL CURLINFO_REQUEST_SIZE CURLINFO_RESPONSE_CODE CURLINFO_RTSP_CLIENT_CSEQ CURLINFO_RTSP_CSEQ_RECV CURLINFO_RTSP_SERVER_CSEQ CURLINFO_RTSP_SESSION_ID CURLINFO_SIZE_DOWNLOAD CURLINFO_SIZE_UPLOAD CURLINFO_SPEED_DOWNLOAD CURLINFO_SPEED_UPLOAD CURLINFO_SSL_ENGINES CURLINFO_SSL_VERIFYRESULT CURLINFO_STARTTRANSFER_TIME CURLINFO_TOTAL_TIME CURLMOPT_MAXCONNECTS CURLMOPT_PIPELINING CURLMSG_DONE CURLM_BAD_EASY_HANDLE CURLM_BAD_HANDLE CURLM_CALL_MULTI_PERFORM CURLM_INTERNAL_ERROR CURLM_OK CURLM_OUT_OF_MEMORY CURLOPT_ACCEPTTIMEOUT_MS CURLOPT_ACCEPT_ENCODING CURLOPT_ADDRESS_SCOPE CURLOPT_APPEND CURLOPT_AUTOREFERER CURLOPT_BINARYTRANSFER CURLOPT_BUFFERSIZE CURLOPT_CAINFO CURLOPT_CAPATH CURLOPT_CERTINFO CURLOPT_CONNECTTIMEOUT CURLOPT_CONNECTTIMEOUT_MS CURLOPT_CONNECT_ONLY CURLOPT_COOKIE CURLOPT_COOKIEFILE CURLOPT_COOKIEJAR CURLOPT_COOKIELIST CURLOPT_COOKIESESSION CURLOPT_CRLF CURLOPT_CRLFILE CURLOPT_CUSTOMREQUEST CURLOPT_DIRLISTONLY CURLOPT_DNS_CACHE_TIMEOUT CURLOPT_DNS_SERVERS CURLOPT_DNS_USE_GLOBAL_CACHE CURLOPT_EGDSOCKET CURLOPT_ENCODING CURLOPT_FAILONERROR CURLOPT_FILE CURLOPT_FILETIME CURLOPT_FNMATCH_FUNCTION CURLOPT_FOLLOWLOCATION CURLOPT_FORBID_REUSE CURLOPT_FRESH_CONNECT CURLOPT_FTPAPPEND CURLOPT_FTPLISTONLY CURLOPT_FTPPORT CURLOPT_FTPSSLAUTH CURLOPT_FTP_ACCOUNT CURLOPT_FTP_ALTERNATIVE_TO_USER CURLOPT_FTP_CREATE_MISSING_DIRS CURLOPT_FTP_FILEMETHOD CURLOPT_FTP_RESPONSE_TIMEOUT CURLOPT_FTP_SKIP_PASV_IP CURLOPT_FTP_SSL CURLOPT_FTP_SSL_CCC CURLOPT_FTP_USE_EPRT CURLOPT_FTP_USE_EPSV CURLOPT_FTP_USE_PRET CURLOPT_GSSAPI_DELEGATION CURLOPT_HEADER CURLOPT_HEADERFUNCTION CURLOPT_HTTP200ALIASES CURLOPT_HTTPAUTH CURLOPT_HTTPGET CURLOPT_HTTPHEADER CURLOPT_HTTPPROXYTUNNEL CURLOPT_HTTP_CONTENT_DECODING CURLOPT_HTTP_TRANSFER_DECODING CURLOPT_HTTP_VERSION CURLOPT_IGNORE_CONTENT_LENGTH CURLOPT_INFILE CURLOPT_INFILESIZE CURLOPT_INTERFACE CURLOPT_IPRESOLVE CURLOPT_ISSUERCERT CURLOPT_KEYPASSWD CURLOPT_KRB4LEVEL CURLOPT_KRBLEVEL CURLOPT_LOCALPORT CURLOPT_LOCALPORTRANGE CURLOPT_LOW_SPEED_LIMIT CURLOPT_LOW_SPEED_TIME CURLOPT_MAIL_AUTH CURLOPT_MAIL_FROM CURLOPT_MAIL_RCPT CURLOPT_MAXCONNECTS CURLOPT_MAXFILESIZE CURLOPT_MAXREDIRS CURLOPT_MAX_RECV_SPEED_LARGE CURLOPT_MAX_SEND_SPEED_LARGE CURLOPT_NETRC CURLOPT_NETRC_FILE CURLOPT_NEW_DIRECTORY_PERMS CURLOPT_NEW_FILE_PERMS CURLOPT_NOBODY CURLOPT_NOPROGRESS CURLOPT_NOPROXY CURLOPT_NOSIGNAL CURLOPT_PASSWORD CURLOPT_PORT CURLOPT_POST CURLOPT_POSTFIELDS CURLOPT_POSTQUOTE CURLOPT_POSTREDIR CURLOPT_PREQUOTE CURLOPT_PRIVATE CURLOPT_PROGRESSFUNCTION CURLOPT_PROTOCOLS CURLOPT_PROXY CURLOPT_PROXYAUTH CURLOPT_PROXYPASSWORD CURLOPT_PROXYPORT CURLOPT_PROXYTYPE CURLOPT_PROXYUSERNAME CURLOPT_PROXYUSERPWD CURLOPT_PROXY_TRANSFER_MODE CURLOPT_PUT CURLOPT_QUOTE CURLOPT_RANDOM_FILE CURLOPT_RANGE CURLOPT_READDATA CURLOPT_READFUNCTION CURLOPT_REDIR_PROTOCOLS CURLOPT_REFERER CURLOPT_RESOLVE CURLOPT_RESUME_FROM CURLOPT_RETURNTRANSFER CURLOPT_RTSP_CLIENT_CSEQ CURLOPT_RTSP_REQUEST CURLOPT_RTSP_SERVER_CSEQ CURLOPT_RTSP_SESSION_ID CURLOPT_RTSP_STREAM_URI CURLOPT_RTSP_TRANSPORT CURLOPT_SAFE_UPLOAD CURLOPT_SHARE CURLOPT_SOCKS5_GSSAPI_NEC CURLOPT_SOCKS5_GSSAPI_SERVICE CURLOPT_SSH_AUTH_TYPES CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 CURLOPT_SSH_KNOWNHOSTS CURLOPT_SSH_PRIVATE_KEYFILE CURLOPT_SSH_PUBLIC_KEYFILE CURLOPT_SSLCERT CURLOPT_SSLCERTPASSWD CURLOPT_SSLCERTTYPE CURLOPT_SSLENGINE CURLOPT_SSLENGINE_DEFAULT CURLOPT_SSLKEY CURLOPT_SSLKEYPASSWD CURLOPT_SSLKEYTYPE CURLOPT_SSLVERSION CURLOPT_SSL_CIPHER_LIST CURLOPT_SSL_OPTIONS CURLOPT_SSL_SESSIONID_CACHE CURLOPT_SSL_VERIFYHOST CURLOPT_SSL_VERIFYPEER CURLOPT_STDERR CURLOPT_TCP_KEEPALIVE CURLOPT_TCP_KEEPIDLE CURLOPT_TCP_KEEPINTVL CURLOPT_TCP_NODELAY CURLOPT_TELNETOPTIONS CURLOPT_TFTP_BLKSIZE CURLOPT_TIMECONDITION CURLOPT_TIMEOUT CURLOPT_TIMEOUT_MS CURLOPT_TIMEVALUE CURLOPT_TLSAUTH_PASSWORD CURLOPT_TLSAUTH_TYPE CURLOPT_TLSAUTH_USERNAME CURLOPT_TRANSFERTEXT CURLOPT_TRANSFER_ENCODING CURLOPT_UNRESTRICTED_AUTH CURLOPT_UPLOAD CURLOPT_URL CURLOPT_USERAGENT CURLOPT_USERNAME CURLOPT_USERPWD CURLOPT_USE_SSL CURLOPT_VERBOSE CURLOPT_WILDCARDMATCH CURLOPT_WRITEFUNCTION CURLOPT_WRITEHEADER CURLPAUSE_ALL CURLPAUSE_CONT CURLPAUSE_RECV CURLPAUSE_RECV_CONT CURLPAUSE_SEND CURLPAUSE_SEND_CONT CURLPROTO_ALL CURLPROTO_DICT CURLPROTO_FILE CURLPROTO_FTP CURLPROTO_FTPS CURLPROTO_GOPHER CURLPROTO_HTTP CURLPROTO_HTTPS CURLPROTO_IMAP CURLPROTO_IMAPS CURLPROTO_LDAP CURLPROTO_LDAPS CURLPROTO_POP3 CURLPROTO_POP3S CURLPROTO_RTMP CURLPROTO_RTMPE CURLPROTO_RTMPS CURLPROTO_RTMPT CURLPROTO_RTMPTE CURLPROTO_RTMPTS CURLPROTO_RTSP CURLPROTO_SCP CURLPROTO_SFTP CURLPROTO_SMTP CURLPROTO_SMTPS CURLPROTO_TELNET CURLPROTO_TFTP CURLPROXY_HTTP CURLPROXY_SOCKS4 CURLPROXY_SOCKS5 CURLSHOPT_NONE CURLSHOPT_SHARE CURLSHOPT_UNSHARE CURLSSH_AUTH_ANY CURLSSH_AUTH_DEFAULT CURLSSH_AUTH_HOST CURLSSH_AUTH_KEYBOARD CURLSSH_AUTH_NONE CURLSSH_AUTH_PASSWORD CURLSSH_AUTH_PUBLICKEY CURLSSLOPT_ALLOW_BEAST CURLUSESSL_ALL CURLUSESSL_CONTROL CURLUSESSL_NONE CURLUSESSL_TRY CURLVERSION_NOW CURL_FNMATCHFUNC_FAIL CURL_FNMATCHFUNC_MATCH CURL_FNMATCHFUNC_NOMATCH CURL_HTTP_VERSION_1_0 CURL_HTTP_VERSION_1_1 CURL_HTTP_VERSION_NONE CURL_IPRESOLVE_V4 CURL_IPRESOLVE_V6 CURL_IPRESOLVE_WHATEVER CURL_LOCK_DATA_COOKIE CURL_LOCK_DATA_DNS CURL_LOCK_DATA_SSL_SESSION CURL_NETRC_IGNORED CURL_NETRC_OPTIONAL CURL_NETRC_REQUIRED CURL_READFUNC_PAUSE CURL_RTSPREQ_ANNOUNCE CURL_RTSPREQ_DESCRIBE CURL_RTSPREQ_GET_PARAMETER CURL_RTSPREQ_OPTIONS CURL_RTSPREQ_PAUSE CURL_RTSPREQ_PLAY CURL_RTSPREQ_RECEIVE CURL_RTSPREQ_RECORD CURL_RTSPREQ_SETUP CURL_RTSPREQ_SET_PARAMETER CURL_RTSPREQ_TEARDOWN CURL_SSLVERSION_DEFAULT CURL_SSLVERSION_SSLv2 CURL_SSLVERSION_SSLv3 CURL_SSLVERSION_TLSv1 CURL_SSLVERSION_TLSv1_0 CURL_SSLVERSION_TLSv1_1 CURL_SSLVERSION_TLSv1_2 CURL_TIMECOND_IFMODSINCE CURL_TIMECOND_IFUNMODSINCE CURL_TIMECOND_LASTMOD CURL_TIMECOND_NONE CURL_TLSAUTH_SRP CURL_VERSION_IPV6 CURL_VERSION_KERBEROS4 CURL_VERSION_LIBZ CURL_VERSION_SSL CURL_WRITEFUNC_PAUSE contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "date") >= 0 && index(g:php_syntax_extensions_disabled, "date") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "date") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "date") < 0)
"                                                                                                   " date constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   AFRICA
"                                                                                                   ALL
"                                                                                                   ALL_WITH_BC
"                                                                                                   AMERICA
"                                                                                                   ANTARCTICA
"                                                                                                   ARCTIC
"                                                                                                   ASIA
"                                                                                                   ATLANTIC
"                                                                                                   ATOM
"                                                                                                   AUSTRALIA
"                                                                                                   COOKIE
"                                                                                                   DATE_ATOM
"                                                                                                   DATE_COOKIE
"                                                                                                   DATE_ISO8601
"                                                                                                   DATE_RFC822
"                                                                                                   DATE_RFC850
"                                                                                                   DATE_RFC1036
"                                                                                                   DATE_RFC1123
"                                                                                                   DATE_RFC2822
"                                                                                                   DATE_RFC3339
"                                                                                                   DATE_RSS
"                                                                                                   DATE_W3C
"                                                                                                   EUROPE
"                                                                                                   EXCLUDE_START_DATE
"                                                                                                   INDIAN
"                                                                                                   ISO8601
"                                                                                                   PACIFIC
"                                                                                                   PER_COUNTRY
"                                                                                                   RFC822
"                                                                                                   RFC850
"                                                                                                   RFC1036
"                                                                                                   RFC1123
"                                                                                                   RFC2822
"                                                                                                   RFC3339
"                                                                                                   RSS
"                                                                                                   SUNFUNCS_RET_DOUBLE
"                                                                                                   SUNFUNCS_RET_STRING
"                                                                                                   SUNFUNCS_RET_TIMESTAMP
"                                                                                                   UTC
"                                                                                                   W3C
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "dom")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "dom")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "dom")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "dom")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   dom
"                                                                                                   constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   DOMSTRING_SIZE_ERR
"                                                                                                   DOM_HIERARCHY_REQUEST_ERR
"                                                                                                   DOM_INDEX_SIZE_ERR
"                                                                                                   DOM_INUSE_ATTRIBUTE_ERR
"                                                                                                   DOM_INVALID_ACCESS_ERR
"                                                                                                   DOM_INVALID_CHARACTER_ERR
"                                                                                                   DOM_INVALID_MODIFICATION_ERR
"                                                                                                   DOM_INVALID_STATE_ERR
"                                                                                                   DOM_NAMESPACE_ERR
"                                                                                                   DOM_NOT_FOUND_ERR
"                                                                                                   DOM_NOT_SUPPORTED_ERR
"                                                                                                   DOM_NO_DATA_ALLOWED_ERR
"                                                                                                   DOM_NO_MODIFICATION_ALLOWED_ERR
"                                                                                                   DOM_PHP_ERR
"                                                                                                   DOM_SYNTAX_ERR
"                                                                                                   DOM_VALIDATION_ERR
"                                                                                                   DOM_WRONG_DOCUMENT_ERR
"                                                                                                   XML_ATTRIBUTE_CDATA
"                                                                                                   XML_ATTRIBUTE_DECL_NODE
"                                                                                                   XML_ATTRIBUTE_ENTITY
"                                                                                                   XML_ATTRIBUTE_ENUMERATION
"                                                                                                   XML_ATTRIBUTE_ID
"                                                                                                   XML_ATTRIBUTE_IDREF
"                                                                                                   XML_ATTRIBUTE_IDREFS
"                                                                                                   XML_ATTRIBUTE_NMTOKEN
"                                                                                                   XML_ATTRIBUTE_NMTOKENS
"                                                                                                   XML_ATTRIBUTE_NODE
"                                                                                                   XML_ATTRIBUTE_NOTATION
"                                                                                                   XML_CDATA_SECTION_NODE
"                                                                                                   XML_COMMENT_NODE
"                                                                                                   XML_DOCUMENT_FRAG_NODE
"                                                                                                   XML_DOCUMENT_NODE
"                                                                                                   XML_DOCUMENT_TYPE_NODE
"                                                                                                   XML_DTD_NODE
"                                                                                                   XML_ELEMENT_DECL_NODE
"                                                                                                   XML_ELEMENT_NODE
"                                                                                                   XML_ENTITY_DECL_NODE
"                                                                                                   XML_ENTITY_NODE
"                                                                                                   XML_ENTITY_REF_NODE
"                                                                                                   XML_HTML_DOCUMENT_NODE
"                                                                                                   XML_LOCAL_NAMESPACE
"                                                                                                   XML_NAMESPACE_DECL_NODE
"                                                                                                   XML_NOTATION_NODE
"                                                                                                   XML_PI_NODE
"                                                                                                   XML_TEXT_NODE
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "gd")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "gd")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "gd")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "gd")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   gd
"                                                                                                   constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   GD_BUNDLED
"                                                                                                   GD_EXTRA_VERSION
"                                                                                                   GD_MAJOR_VERSION
"                                                                                                   GD_MINOR_VERSION
"                                                                                                   GD_RELEASE_VERSION
"                                                                                                   GD_VERSION
"                                                                                                   IMG_AFFINE_ROTATE
"                                                                                                   IMG_AFFINE_SCALE
"                                                                                                   IMG_AFFINE_SHEAR_HORIZONTAL
"                                                                                                   IMG_AFFINE_SHEAR_VERTICAL
"                                                                                                   IMG_AFFINE_TRANSLATE
"                                                                                                   IMG_ARC_CHORD
"                                                                                                   IMG_ARC_EDGED
"                                                                                                   IMG_ARC_NOFILL
"                                                                                                   IMG_ARC_PIE
"                                                                                                   IMG_ARC_ROUNDED
"                                                                                                   IMG_BELL
"                                                                                                   IMG_BESSEL
"                                                                                                   IMG_BICUBIC
"                                                                                                   IMG_BICUBIC_FIXED
"                                                                                                   IMG_BILINEAR_FIXED IMG_BLACKMAN IMG_BOX IMG_BSPLINE IMG_CATMULLROM IMG_COLOR_BRUSHED IMG_COLOR_STYLED IMG_COLOR_STYLEDBRUSHED IMG_COLOR_TILED IMG_COLOR_TRANSPARENT IMG_CROP_BLACK IMG_CROP_DEFAULT IMG_CROP_SIDES IMG_CROP_THRESHOLD IMG_CROP_TRANSPARENT IMG_CROP_WHITE IMG_EFFECT_ALPHABLEND IMG_EFFECT_NORMAL IMG_EFFECT_OVERLAY IMG_EFFECT_REPLACE IMG_FILTER_BRIGHTNESS IMG_FILTER_COLORIZE IMG_FILTER_CONTRAST IMG_FILTER_EDGEDETECT IMG_FILTER_EMBOSS IMG_FILTER_GAUSSIAN_BLUR IMG_FILTER_GRAYSCALE IMG_FILTER_MEAN_REMOVAL IMG_FILTER_NEGATE IMG_FILTER_PIXELATE IMG_FILTER_SELECTIVE_BLUR IMG_FILTER_SMOOTH IMG_FLIP_BOTH IMG_FLIP_HORIZONTAL IMG_FLIP_VERTICAL IMG_GAUSSIAN IMG_GD2_COMPRESSED IMG_GD2_RAW IMG_GENERALIZED_CUBIC IMG_GIF IMG_HAMMING IMG_HANNING IMG_HERMITE IMG_JPEG IMG_JPG IMG_MITCHELL IMG_NEAREST_NEIGHBOUR IMG_PNG IMG_POWER IMG_QUADRATIC IMG_SINC IMG_TRIANGLE IMG_WBMP IMG_WEIGHTED4 IMG_XPM PNG_ALL_FILTERS PNG_FILTER_AVG PNG_FILTER_NONE PNG_FILTER_PAETH PNG_FILTER_SUB PNG_FILTER_UP PNG_NO_FILTER contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "hash") >= 0 && index(g:php_syntax_extensions_disabled, "hash") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "hash") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "hash") < 0)
"                                                                                                   " hash constants
"                                                                                                   syn keyword phpConstants HASH_HMAC MHASH_ADLER32 MHASH_CRC32 MHASH_CRC32B MHASH_FNV1A32 MHASH_FNV1A64 MHASH_FNV132 MHASH_FNV164 MHASH_GOST MHASH_HAVAL128 MHASH_HAVAL160 MHASH_HAVAL192 MHASH_HAVAL224 MHASH_HAVAL256 MHASH_JOAAT MHASH_MD2 MHASH_MD4 MHASH_MD5 MHASH_RIPEMD128 MHASH_RIPEMD160 MHASH_RIPEMD256 MHASH_RIPEMD320 MHASH_SHA1 MHASH_SHA224 MHASH_SHA256 MHASH_SHA384 MHASH_SHA512 MHASH_SNEFRU256 MHASH_TIGER MHASH_TIGER128 MHASH_TIGER160 MHASH_WHIRLPOOL contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "iconv") >= 0 && index(g:php_syntax_extensions_disabled, "iconv") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "iconv") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "iconv") < 0)
"                                                                                                   " iconv constants
"                                                                                                   syn keyword phpConstants ICONV_IMPL ICONV_MIME_DECODE_CONTINUE_ON_ERROR ICONV_MIME_DECODE_STRICT ICONV_VERSION contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "json") >= 0 && index(g:php_syntax_extensions_disabled, "json") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "json") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "json") < 0)
"                                                                                                   " json constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   JSON_BIGINT_AS_STRING
"                                                                                                   JSON_C_BUNDLED
"                                                                                                   JSON_C_VERSION
"                                                                                                   JSON_ERROR_CTRL_CHAR
"                                                                                                   JSON_ERROR_DEPTH
"                                                                                                   JSON_ERROR_INF_OR_NAN
"                                                                                                   JSON_ERROR_NONE
"                                                                                                   JSON_ERROR_RECURSION
"                                                                                                   JSON_ERROR_STATE_MISMATCH
"                                                                                                   JSON_ERROR_SYNTAX
"                                                                                                   JSON_ERROR_UNSUPPORTED_TYPE
"                                                                                                   JSON_ERROR_UTF8
"                                                                                                   JSON_FORCE_OBJECT
"                                                                                                   JSON_HEX_AMP
"                                                                                                   JSON_HEX_APOS
"                                                                                                   JSON_HEX_QUOT
"                                                                                                   JSON_HEX_TAG
"                                                                                                   JSON_NUMERIC_CHECK
"                                                                                                   JSON_OBJECT_AS_ARRAY
"                                                                                                   JSON_PARSER_CONTINUE
"                                                                                                   JSON_PARSER_NOTSTRICT
"                                                                                                   JSON_PARSER_SUCCESS
"                                                                                                   JSON_PARTIAL_OUTPUT_ON_ERROR
"                                                                                                   JSON_PRETTY_PRINT
"                                                                                                   JSON_UNESCAPED_SLASHES
"                                                                                                   JSON_UNESCAPED_UNICODE
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "libxml")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "libxml")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "libxml")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "libxml")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   libxml
"                                                                                                   constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   LIBXML_COMPACT
"                                                                                                   LIBXML_DOTTED_VERSION
"                                                                                                   LIBXML_DTDATTR
"                                                                                                   LIBXML_DTDLOAD
"                                                                                                   LIBXML_DTDVALID
"                                                                                                   LIBXML_ERR_ERROR
"                                                                                                   LIBXML_ERR_FATAL
"                                                                                                   LIBXML_ERR_NONE
"                                                                                                   LIBXML_ERR_WARNING
"                                                                                                   LIBXML_HTML_NODEFDTD
"                                                                                                   LIBXML_HTML_NOIMPLIED
"                                                                                                   LIBXML_LOADED_VERSION
"                                                                                                   LIBXML_NOBLANKS
"                                                                                                   LIBXML_NOCDATA
"                                                                                                   LIBXML_NOEMPTYTAG
"                                                                                                   LIBXML_NOENT
"                                                                                                   LIBXML_NOERROR
"                                                                                                   LIBXML_NONET
"                                                                                                   LIBXML_NOWARNING
"                                                                                                   LIBXML_NOXMLDECL
"                                                                                                   LIBXML_NSCLEAN
"                                                                                                   LIBXML_PARSEHUGE
"                                                                                                   LIBXML_PEDANTIC
"                                                                                                   LIBXML_SCHEMA_CREATE
"                                                                                                   LIBXML_VERSION
"                                                                                                   LIBXML_XINCLUDE
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "mbstring")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled, "mbstring") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "mbstring") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "mbstring") < 0)
"                                                                                                   " mbstring constants
"                                                                                                   syn keyword phpConstants MB_CASE_LOWER MB_CASE_TITLE MB_CASE_UPPER MB_OVERLOAD_MAIL MB_OVERLOAD_REGEX MB_OVERLOAD_STRING contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "mcrypt") >= 0 && index(g:php_syntax_extensions_disabled, "mcrypt") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "mcrypt") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "mcrypt") < 0)
"                                                                                                   " mcrypt constants
"                                                                                                   syn keyword phpConstants MCRYPT_3DES MCRYPT_ARCFOUR MCRYPT_ARCFOUR_IV MCRYPT_BLOWFISH MCRYPT_BLOWFISH_COMPAT MCRYPT_CAST_128 MCRYPT_CAST_256 MCRYPT_CRYPT MCRYPT_DECRYPT MCRYPT_DES MCRYPT_DEV_RANDOM MCRYPT_DEV_URANDOM MCRYPT_ENCRYPT MCRYPT_ENIGNA MCRYPT_GOST MCRYPT_IDEA MCRYPT_LOKI97 MCRYPT_MARS MCRYPT_MODE_CBC MCRYPT_MODE_CFB MCRYPT_MODE_ECB MCRYPT_MODE_NOFB MCRYPT_MODE_OFB MCRYPT_MODE_STREAM MCRYPT_PANAMA MCRYPT_RAND MCRYPT_RC2 MCRYPT_RC6 MCRYPT_RIJNDAEL_128 MCRYPT_RIJNDAEL_192 MCRYPT_RIJNDAEL_256 MCRYPT_SAFER64 MCRYPT_SAFER128 MCRYPT_SAFERPLUS MCRYPT_SERPENT MCRYPT_SKIPJACK MCRYPT_THREEWAY MCRYPT_TRIPLEDES MCRYPT_TWOFISH MCRYPT_WAKE MCRYPT_XTEA contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "mysql") >= 0 && index(g:php_syntax_extensions_disabled, "mysql") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "mysql") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "mysql") < 0)
"                                                                                                   " mysql constants
"                                                                                                   syn keyword phpConstants MYSQL_ASSOC MYSQL_BOTH MYSQL_CLIENT_COMPRESS MYSQL_CLIENT_IGNORE_SPACE MYSQL_CLIENT_INTERACTIVE MYSQL_CLIENT_SSL MYSQL_NUM contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "mysqli") >= 0 && index(g:php_syntax_extensions_disabled, "mysqli") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "mysqli") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "mysqli") < 0)
"                                                                                                   " mysqli constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   MYSQLI_ASSOC
"                                                                                                   MYSQLI_AUTO_INCREMENT_FLAG
"                                                                                                   MYSQLI_BINARY_FLAG
"                                                                                                   MYSQLI_BLOB_FLAG
"                                                                                                   MYSQLI_BOTH
"                                                                                                   MYSQLI_CLIENT_COMPRESS
"                                                                                                   MYSQLI_CLIENT_FOUND_ROWS
"                                                                                                   MYSQLI_CLIENT_IGNORE_SPACE
"                                                                                                   MYSQLI_CLIENT_INTERACTIVE
"                                                                                                   MYSQLI_CLIENT_NO_SCHEMA
"                                                                                                   MYSQLI_CLIENT_SSL
"                                                                                                   MYSQLI_CURSOR_TYPE_FOR_UPDATE
"                                                                                                   MYSQLI_CURSOR_TYPE_NO_CURSOR
"                                                                                                   MYSQLI_CURSOR_TYPE_READ_ONLY
"                                                                                                   MYSQLI_CURSOR_TYPE_SCROLLABLE
"                                                                                                   MYSQLI_DATA_TRUNCATED
"                                                                                                   MYSQLI_DEBUG_TRACE_ENABLED
"                                                                                                   MYSQLI_ENUM_FLAG
"                                                                                                   MYSQLI_GROUP_FLAG
"                                                                                                   MYSQLI_INIT_COMMAND
"                                                                                                   MYSQLI_MULTIPLE_KEY_FLAG
"                                                                                                   MYSQLI_NOT_NULL_FLAG
"                                                                                                   MYSQLI_NO_DATA
"                                                                                                   MYSQLI_NO_DEFAULT_VALUE_FLAG
"                                                                                                   MYSQLI_NUM
"                                                                                                   MYSQLI_NUM_FLAG
"                                                                                                   MYSQLI_OPT_CONNECT_TIMEOUT
"                                                                                                   MYSQLI_OPT_LOCAL_INFILE
"                                                                                                   MYSQLI_OPT_SSL_VERIFY_SERVER_CERT
"                                                                                                   MYSQLI_PART_KEY_FLAG
"                                                                                                   MYSQLI_PRI_KEY_FLAG
"                                                                                                   MYSQLI_READ_DEFAULT_FILE
"                                                                                                   MYSQLI_READ_DEFAULT_GROUP
"                                                                                                   MYSQLI_REFRESH_GRANT
"                                                                                                   MYSQLI_REFRESH_HOSTS
"                                                                                                   MYSQLI_REFRESH_LOG
"                                                                                                   MYSQLI_REFRESH_MASTER
"                                                                                                   MYSQLI_REFRESH_SLAVE
"                                                                                                   MYSQLI_REFRESH_STATUS
"                                                                                                   MYSQLI_REFRESH_TABLES
"                                                                                                   MYSQLI_REFRESH_THREADS
"                                                                                                   MYSQLI_REPORT_ALL
"                                                                                                   MYSQLI_REPORT_ERROR
"                                                                                                   MYSQLI_REPORT_INDEX
"                                                                                                   MYSQLI_REPORT_OFF
"                                                                                                   MYSQLI_REPORT_STRICT
"                                                                                                   MYSQLI_SERVER_PS_OUT_PARAMS
"                                                                                                   MYSQLI_SERVER_QUERY_NO_GOOD_INDEX_USED
"                                                                                                   MYSQLI_SERVER_QUERY_NO_INDEX_USED
"                                                                                                   MYSQLI_SERVER_QUERY_WAS_SLOW
"                                                                                                   MYSQLI_SET_CHARSET_DIR
"                                                                                                   MYSQLI_SET_CHARSET_NAME
"                                                                                                   MYSQLI_SET_FLAG
"                                                                                                   MYSQLI_STMT_ATTR_CURSOR_TYPE
"                                                                                                   MYSQLI_STMT_ATTR_PREFETCH_ROWS
"                                                                                                   MYSQLI_STMT_ATTR_UPDATE_MAX_LENGTH
"                                                                                                   MYSQLI_STORE_RESULT
"                                                                                                   MYSQLI_TIMESTAMP_FLAG
"                                                                                                   MYSQLI_TRANS_COR_AND_CHAIN
"                                                                                                   MYSQLI_TRANS_COR_AND_NO_CHAIN
"                                                                                                   MYSQLI_TRANS_COR_NO_RELEASE
"                                                                                                   MYSQLI_TRANS_COR_RELEASE
"                                                                                                   MYSQLI_TRANS_START_READ_ONLY
"                                                                                                   MYSQLI_TRANS_START_READ_WRITE
"                                                                                                   MYSQLI_TRANS_START_WITH_CONSISTENT_SNAPSHOT
"                                                                                                   MYSQLI_TYPE_BIT
"                                                                                                   MYSQLI_TYPE_BLOB
"                                                                                                   MYSQLI_TYPE_CHAR
"                                                                                                   MYSQLI_TYPE_DATE
"                                                                                                   MYSQLI_TYPE_DATETIME
"                                                                                                   MYSQLI_TYPE_DECIMAL
"                                                                                                   MYSQLI_TYPE_DOUBLE
"                                                                                                   MYSQLI_TYPE_ENUM
"                                                                                                   MYSQLI_TYPE_FLOAT
"                                                                                                   MYSQLI_TYPE_GEOMETRY
"                                                                                                   MYSQLI_TYPE_INT24
"                                                                                                   MYSQLI_TYPE_INTERVAL
"                                                                                                   MYSQLI_TYPE_LONG
"                                                                                                   MYSQLI_TYPE_LONGLONG
"                                                                                                   MYSQLI_TYPE_LONG_BLOB
"                                                                                                   MYSQLI_TYPE_MEDIUM_BLOB
"                                                                                                   MYSQLI_TYPE_NEWDATE
"                                                                                                   MYSQLI_TYPE_NEWDECIMAL
"                                                                                                   MYSQLI_TYPE_NULL
"                                                                                                   MYSQLI_TYPE_SET
"                                                                                                   MYSQLI_TYPE_SHORT
"                                                                                                   MYSQLI_TYPE_STRING
"                                                                                                   MYSQLI_TYPE_TIME
"                                                                                                   MYSQLI_TYPE_TIMESTAMP
"                                                                                                   MYSQLI_TYPE_TINY
"                                                                                                   MYSQLI_TYPE_TINY_BLOB
"                                                                                                   MYSQLI_TYPE_VAR_STRING
"                                                                                                   MYSQLI_TYPE_YEAR
"                                                                                                   MYSQLI_UNIQUE_KEY_FLAG
"                                                                                                   MYSQLI_UNSIGNED_FLAG
"                                                                                                   MYSQLI_USE_RESULT
"                                                                                                   MYSQLI_ZEROFILL_FLAG
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "openssl")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "openssl")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "openssl")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "openssl")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   openssl
"                                                                                                   constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   OPENSSL_ALGO_DSS1
"                                                                                                   OPENSSL_ALGO_MD4
"                                                                                                   OPENSSL_ALGO_MD5
"                                                                                                   OPENSSL_ALGO_RMD160
"                                                                                                   OPENSSL_ALGO_SHA1
"                                                                                                   OPENSSL_ALGO_SHA224
"                                                                                                   OPENSSL_ALGO_SHA256
"                                                                                                   OPENSSL_ALGO_SHA384
"                                                                                                   OPENSSL_ALGO_SHA512
"                                                                                                   OPENSSL_CIPHER_3DES
"                                                                                                   OPENSSL_CIPHER_AES_128_CBC
"                                                                                                   OPENSSL_CIPHER_AES_192_CBC
"                                                                                                   OPENSSL_CIPHER_AES_256_CBC
"                                                                                                   OPENSSL_CIPHER_DES
"                                                                                                   OPENSSL_CIPHER_RC2_40
"                                                                                                   OPENSSL_CIPHER_RC2_64
"                                                                                                   OPENSSL_CIPHER_RC2_128
"                                                                                                   OPENSSL_DEFAULT_STREAM_CIPHERS
"                                                                                                   OPENSSL_KEYTYPE_DH
"                                                                                                   OPENSSL_KEYTYPE_DSA
"                                                                                                   OPENSSL_KEYTYPE_EC
"                                                                                                   OPENSSL_KEYTYPE_RSA
"                                                                                                   OPENSSL_NO_PADDING
"                                                                                                   OPENSSL_PKCS1_OAEP_PADDING
"                                                                                                   OPENSSL_PKCS1_PADDING
"                                                                                                   OPENSSL_RAW_DATA
"                                                                                                   OPENSSL_SSLV23_PADDING
"                                                                                                   OPENSSL_TLSEXT_SERVER_NAME
"                                                                                                   OPENSSL_VERSION_NUMBER
"                                                                                                   OPENSSL_VERSION_TEXT
"                                                                                                   OPENSSL_ZERO_PADDING
"                                                                                                   PKCS7_BINARY
"                                                                                                   PKCS7_DETACHED
"                                                                                                   PKCS7_NOATTR
"                                                                                                   PKCS7_NOCERTS
"                                                                                                   PKCS7_NOCHAIN
"                                                                                                   PKCS7_NOINTERN
"                                                                                                   PKCS7_NOSIGS
"                                                                                                   PKCS7_NOVERIFY
"                                                                                                   PKCS7_TEXT
"                                                                                                   X509_PURPOSE_ANY
"                                                                                                   X509_PURPOSE_CRL_SIGN
"                                                                                                   X509_PURPOSE_NS_SSL_SERVER
"                                                                                                   X509_PURPOSE_SMIME_ENCRYPT
"                                                                                                   X509_PURPOSE_SMIME_SIGN
"                                                                                                   X509_PURPOSE_SSL_CLIENT
"                                                                                                   X509_PURPOSE_SSL_SERVER
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "pcre")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "pcre")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "pcre")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled, "pcre") < 0)
"                                                                                                   " pcre constants
"                                                                                                   syn keyword phpConstants PCRE_VERSION PREG_BACKTRACK_LIMIT_ERROR PREG_BAD_UTF8_ERROR PREG_BAD_UTF8_OFFSET_ERROR PREG_GREP_INVERT PREG_INTERNAL_ERROR PREG_NO_ERROR PREG_OFFSET_CAPTURE PREG_PATTERN_ORDER PREG_RECURSION_LIMIT_ERROR PREG_SET_ORDER PREG_SPLIT_DELIM_CAPTURE PREG_SPLIT_NO_EMPTY PREG_SPLIT_OFFSET_CAPTURE contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "pdo") >= 0 && index(g:php_syntax_extensions_disabled, "pdo") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "pdo") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "pdo") < 0)
"                                                                                                   " PDO constants
"                                                                                                   syn keyword phpConstants ATTR_AUTOCOMMIT ATTR_CASE ATTR_CLIENT_VERSION ATTR_CONNECTION_STATUS ATTR_CURSOR ATTR_CURSOR_NAME ATTR_DEFAULT_FETCH_MODE ATTR_DRIVER_NAME ATTR_EMULATE_PREPARES ATTR_ERRMODE ATTR_FETCH_CATALOG_NAMES ATTR_FETCH_TABLE_NAMES ATTR_MAX_COLUMN_LEN ATTR_ORACLE_NULLS ATTR_PERSISTENT ATTR_PREFETCH ATTR_SERVER_INFO ATTR_SERVER_VERSION ATTR_STATEMENT_CLASS ATTR_STRINGIFY_FETCHES ATTR_TIMEOUT CASE_LOWER CASE_NATURAL CASE_UPPER CURSOR_FWDONLY CURSOR_SCROLL ERRMODE_EXCEPTION ERRMODE_SILENT ERRMODE_WARNING ERR_NONE FETCH_ASSOC FETCH_BOTH FETCH_BOUND FETCH_CLASS FETCH_CLASSTYPE FETCH_COLUMN FETCH_FUNC FETCH_GROUP FETCH_INTO FETCH_KEY_PAIR FETCH_LAZY FETCH_NAMED FETCH_NUM FETCH_OBJ FETCH_ORI_ABS FETCH_ORI_FIRST FETCH_ORI_LAST FETCH_ORI_NEXT FETCH_ORI_PRIOR FETCH_ORI_REL FETCH_PROPS_LATE FETCH_SERIALIZE FETCH_UNIQUE MYSQL_ATTR_COMPRESS MYSQL_ATTR_DIRECT_QUERY MYSQL_ATTR_FOUND_ROWS MYSQL_ATTR_IGNORE_SPACE MYSQL_ATTR_INIT_COMMAND MYSQL_ATTR_LOCAL_INFILE MYSQL_ATTR_MAX_BUFFER_SIZE MYSQL_ATTR_READ_DEFAULT_FILE MYSQL_ATTR_READ_DEFAULT_GROUP MYSQL_ATTR_SSL_CA MYSQL_ATTR_SSL_CAPATH MYSQL_ATTR_SSL_CERT MYSQL_ATTR_SSL_CIPHER MYSQL_ATTR_SSL_KEY MYSQL_ATTR_USE_BUFFERED_QUERY NULL_EMPTY_STRING NULL_NATURAL NULL_TO_STRING PARAM_BOOL PARAM_EVT_ALLOC PARAM_EVT_EXEC_POST PARAM_EVT_EXEC_PRE PARAM_EVT_FETCH_POST PARAM_EVT_FETCH_PRE PARAM_EVT_FREE PARAM_EVT_NORMALIZE PARAM_INPUT_OUTPUT PARAM_INT PARAM_LOB PARAM_NULL PARAM_STMT PARAM_STR PGSQL_ATTR_DISABLE_NATIVE_PREPARED_STATEMENT PGSQL_ATTR_DISABLE_PREPARES PGSQL_TRANSACTION_ACTIVE PGSQL_TRANSACTION_IDLE PGSQL_TRANSACTION_INERROR PGSQL_TRANSACTION_INTRANS PGSQL_TRANSACTION_UNKNOWN contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "pgsql") >= 0 && index(g:php_syntax_extensions_disabled, "pgsql") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "pgsql") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "pgsql") < 0)
"                                                                                                   " pgsql constants
"                                                                                                   syn keyword phpConstants PGSQL_ASSOC PGSQL_BAD_RESPONSE PGSQL_BOTH PGSQL_COMMAND_OK PGSQL_CONNECTION_AUTH_OK PGSQL_CONNECTION_AWAITING_RESPONSE PGSQL_CONNECTION_BAD PGSQL_CONNECTION_MADE PGSQL_CONNECTION_OK PGSQL_CONNECTION_SETENV PGSQL_CONNECTION_STARTED PGSQL_CONNECT_ASYNC PGSQL_CONNECT_FORCE_NEW PGSQL_CONV_FORCE_NULL PGSQL_CONV_IGNORE_DEFAULT PGSQL_CONV_IGNORE_NOT_NULL PGSQL_COPY_IN PGSQL_COPY_OUT PGSQL_DIAG_CONTEXT PGSQL_DIAG_INTERNAL_POSITION PGSQL_DIAG_INTERNAL_QUERY PGSQL_DIAG_MESSAGE_DETAIL PGSQL_DIAG_MESSAGE_HINT PGSQL_DIAG_MESSAGE_PRIMARY PGSQL_DIAG_SEVERITY PGSQL_DIAG_SOURCE_FILE PGSQL_DIAG_SOURCE_FUNCTION PGSQL_DIAG_SOURCE_LINE PGSQL_DIAG_SQLSTATE PGSQL_DIAG_STATEMENT_POSITION PGSQL_DML_ASYNC PGSQL_DML_ESCAPE PGSQL_DML_EXEC PGSQL_DML_NO_CONV PGSQL_DML_STRING PGSQL_EMPTY_QUERY PGSQL_ERRORS_DEFAULT PGSQL_ERRORS_TERSE PGSQL_ERRORS_VERBOSE PGSQL_FATAL_ERROR PGSQL_LIBPQ_VERSION PGSQL_LIBPQ_VERSION_STR PGSQL_NONFATAL_ERROR PGSQL_NUM PGSQL_POLLING_ACTIVE PGSQL_POLLING_FAILED PGSQL_POLLING_OK PGSQL_POLLING_READING PGSQL_POLLING_WRITING PGSQL_SEEK_CUR PGSQL_SEEK_END PGSQL_SEEK_SET PGSQL_STATUS_LONG PGSQL_STATUS_STRING PGSQL_TRANSACTION_ACTIVE PGSQL_TRANSACTION_IDLE PGSQL_TRANSACTION_INERROR PGSQL_TRANSACTION_INTRANS PGSQL_TRANSACTION_UNKNOWN PGSQL_TUPLES_OK contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "phar") >= 0 && index(g:php_syntax_extensions_disabled, "phar") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "phar") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "phar") < 0)
"                                                                                                   " Phar constants
"                                                                                                   syn keyword phpConstants BZ2 COMPRESSED CURRENT_AS_FILEINFO CURRENT_AS_PATHNAME CURRENT_AS_SELF CURRENT_MODE_MASK FOLLOW_SYMLINKS GZ KEY_AS_FILENAME KEY_AS_PATHNAME KEY_MODE_MASK MD5 NEW_CURRENT_AND_KEY NONE OPENSSL OTHER_MODE_MASK PHAR PHP PHPS SHA1 SHA256 SHA512 SKIP_DOTS TAR UNIX_PATHS ZIP contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "reflection") >= 0 && index(g:php_syntax_extensions_disabled, "reflection") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "reflection") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "reflection") < 0)
"                                                                                                   " Reflection constants
"                                                                                                   syn keyword phpConstants IS_ABSTRACT IS_DEPRECATED IS_EXPLICIT_ABSTRACT IS_FINAL IS_IMPLICIT_ABSTRACT IS_PRIVATE IS_PROTECTED IS_PUBLIC IS_STATIC contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "session") >= 0 && index(g:php_syntax_extensions_disabled, "session") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "session") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "session") < 0)
"                                                                                                   " session constants
"                                                                                                   syn keyword phpConstants PHP_SESSION_ACTIVE PHP_SESSION_DISABLED PHP_SESSION_NONE contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "soap") >= 0 && index(g:php_syntax_extensions_disabled, "soap") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "soap") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "soap") < 0)
"                                                                                                   " soap constants
"                                                                                                   syn keyword phpConstants APACHE_MAP SOAP_1_1 SOAP_1_2 SOAP_ACTOR_NEXT SOAP_ACTOR_NONE SOAP_ACTOR_UNLIMATERECEIVER SOAP_AUTHENTICATION_BASIC SOAP_AUTHENTICATION_DIGEST SOAP_COMPRESSION_ACCEPT SOAP_COMPRESSION_DEFLATE SOAP_COMPRESSION_GZIP SOAP_DOCUMENT SOAP_ENCODED SOAP_ENC_ARRAY SOAP_ENC_OBJECT SOAP_FUNCTIONS_ALL SOAP_LITERAL SOAP_PERSISTENCE_REQUEST SOAP_PERSISTENCE_SESSION SOAP_RPC SOAP_SINGLE_ELEMENT_ARRAYS SOAP_SSL_METHOD_SSLv2 SOAP_SSL_METHOD_SSLv3 SOAP_SSL_METHOD_SSLv23 SOAP_SSL_METHOD_TLS SOAP_USE_XSI_ARRAY_TYPE SOAP_WAIT_ONE_WAY_CALLS UNKNOWN_TYPE WSDL_CACHE_BOTH WSDL_CACHE_DISK WSDL_CACHE_MEMORY WSDL_CACHE_NONE XSD_1999_NAMESPACE XSD_1999_TIMEINSTANT XSD_ANYTYPE XSD_ANYURI XSD_ANYXML XSD_BASE64BINARY XSD_BOOLEAN XSD_BYTE XSD_DATE XSD_DATETIME XSD_DECIMAL XSD_DOUBLE XSD_DURATION XSD_ENTITIES XSD_ENTITY XSD_FLOAT XSD_GDAY XSD_GMONTH XSD_GMONTHDAY XSD_GYEAR XSD_GYEARMONTH XSD_HEXBINARY XSD_ID XSD_IDREF XSD_IDREFS XSD_INT XSD_INTEGER XSD_LANGUAGE XSD_LONG XSD_NAME XSD_NAMESPACE XSD_NCNAME XSD_NEGATIVEINTEGER XSD_NMTOKEN XSD_NMTOKENS XSD_NONNEGATIVEINTEGER XSD_NONPOSITIVEINTEGER XSD_NORMALIZEDSTRING XSD_NOTATION XSD_POSITIVEINTEGER XSD_QNAME XSD_SHORT XSD_STRING XSD_TIME XSD_TOKEN XSD_UNSIGNEDBYTE XSD_UNSIGNEDINT XSD_UNSIGNEDLONG XSD_UNSIGNEDSHORT contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "sockets") >= 0 && index(g:php_syntax_extensions_disabled, "sockets") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "sockets") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "sockets") < 0)
"                                                                                                   " sockets constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   AF_INET
"                                                                                                   AF_INET6
"                                                                                                   AF_UNIX
"                                                                                                   IPPROTO_IP
"                                                                                                   IPPROTO_IPV6
"                                                                                                   IPV6_HOPLIMIT
"                                                                                                   IPV6_MULTICAST_HOPS
"                                                                                                   IPV6_MULTICAST_IF
"                                                                                                   IPV6_MULTICAST_LOOP
"                                                                                                   IPV6_PKTINFO
"                                                                                                   IPV6_RECVHOPLIMIT
"                                                                                                   IPV6_RECVPKTINFO
"                                                                                                   IPV6_RECVTCLASS
"                                                                                                   IPV6_TCLASS
"                                                                                                   IPV6_UNICAST_HOPS
"                                                                                                   IP_MULTICAST_IF
"                                                                                                   IP_MULTICAST_LOOP
"                                                                                                   IP_MULTICAST_TTL
"                                                                                                   MCAST_BLOCK_SOURCE
"                                                                                                   MCAST_JOIN_GROUP
"                                                                                                   MCAST_JOIN_SOURCE_GROUP
"                                                                                                   MCAST_LEAVE_GROUP
"                                                                                                   MCAST_LEAVE_SOURCE_GROUP
"                                                                                                   MCAST_UNBLOCK_SOURCE
"                                                                                                   MSG_CMSG_CLOEXEC
"                                                                                                   MSG_CONFIRM
"                                                                                                   MSG_CTRUNC
"                                                                                                   MSG_DONTROUTE
"                                                                                                   MSG_DONTWAIT
"                                                                                                   MSG_EOF
"                                                                                                   MSG_EOR
"                                                                                                   MSG_ERRQUEUE
"                                                                                                   MSG_MORE
"                                                                                                   MSG_NOSIGNAL
"                                                                                                   MSG_OOB
"                                                                                                   MSG_PEEK
"                                                                                                   MSG_TRUNC
"                                                                                                   MSG_WAITALL
"                                                                                                   MSG_WAITFORONE
"                                                                                                   PHP_BINARY_READ
"                                                                                                   PHP_NORMAL_READ
"                                                                                                   SCM_CREDENTIALS
"                                                                                                   SCM_RIGHTS
"                                                                                                   SOCKET_E2BIG
"                                                                                                   SOCKET_EACCES
"                                                                                                   SOCKET_EADDRINUSE
"                                                                                                   SOCKET_EADDRNOTAVAIL
"                                                                                                   SOCKET_EADV
"                                                                                                   SOCKET_EAFNOSUPPORT
"                                                                                                   SOCKET_EAGAIN
"                                                                                                   SOCKET_EALREADY
"                                                                                                   SOCKET_EBADE
"                                                                                                   SOCKET_EBADF
"                                                                                                   SOCKET_EBADFD
"                                                                                                   SOCKET_EBADMSG
"                                                                                                   SOCKET_EBADR
"                                                                                                   SOCKET_EBADRQC
"                                                                                                   SOCKET_EBADSLT
"                                                                                                   SOCKET_EBUSY
"                                                                                                   SOCKET_ECHRNG
"                                                                                                   SOCKET_ECOMM
"                                                                                                   SOCKET_ECONNABORTED
"                                                                                                   SOCKET_ECONNREFUSED
"                                                                                                   SOCKET_ECONNRESET
"                                                                                                   SOCKET_EDESTADDRREQ
"                                                                                                   SOCKET_EDQUOT
"                                                                                                   SOCKET_EEXIST
"                                                                                                   SOCKET_EFAULT
"                                                                                                   SOCKET_EHOSTDOWN
"                                                                                                   SOCKET_EHOSTUNREACH
"                                                                                                   SOCKET_EIDRM
"                                                                                                   SOCKET_EINPROGRESS
"                                                                                                   SOCKET_EINTR
"                                                                                                   SOCKET_EINVAL
"                                                                                                   SOCKET_EIO
"                                                                                                   SOCKET_EISCONN
"                                                                                                   SOCKET_EISDIR
"                                                                                                   SOCKET_EISNAM
"                                                                                                   SOCKET_EL2HLT
"                                                                                                   SOCKET_EL2NSYNC
"                                                                                                   SOCKET_EL3HLT
"                                                                                                   SOCKET_EL3RST
"                                                                                                   SOCKET_ELNRNG
"                                                                                                   SOCKET_ELOOP
"                                                                                                   SOCKET_EMEDIUMTYPE
"                                                                                                   SOCKET_EMFILE
"                                                                                                   SOCKET_EMLINK
"                                                                                                   SOCKET_EMSGSIZE
"                                                                                                   SOCKET_EMULTIHOP
"                                                                                                   SOCKET_ENAMETOOLONG
"                                                                                                   SOCKET_ENETDOWN
"                                                                                                   SOCKET_ENETRESET
"                                                                                                   SOCKET_ENETUNREACH
"                                                                                                   SOCKET_ENFILE
"                                                                                                   SOCKET_ENOANO
"                                                                                                   SOCKET_ENOBUFS
"                                                                                                   SOCKET_ENOCSI
"                                                                                                   SOCKET_ENODATA
"                                                                                                   SOCKET_ENODEV
"                                                                                                   SOCKET_ENOENT
"                                                                                                   SOCKET_ENOLCK
"                                                                                                   SOCKET_ENOLINK
"                                                                                                   SOCKET_ENOMEDIUM
"                                                                                                   SOCKET_ENOMEM
"                                                                                                   SOCKET_ENOMSG
"                                                                                                   SOCKET_ENONET
"                                                                                                   SOCKET_ENOPROTOOPT
"                                                                                                   SOCKET_ENOSPC
"                                                                                                   SOCKET_ENOSR
"                                                                                                   SOCKET_ENOSTR
"                                                                                                   SOCKET_ENOSYS
"                                                                                                   SOCKET_ENOTBLK
"                                                                                                   SOCKET_ENOTCONN
"                                                                                                   SOCKET_ENOTDIR
"                                                                                                   SOCKET_ENOTEMPTY
"                                                                                                   SOCKET_ENOTSOCK
"                                                                                                   SOCKET_ENOTTY
"                                                                                                   SOCKET_ENOTUNIQ
"                                                                                                   SOCKET_ENXIO
"                                                                                                   SOCKET_EOPNOTSUPP
"                                                                                                   SOCKET_EPERM
"                                                                                                   SOCKET_EPFNOSUPPORT
"                                                                                                   SOCKET_EPIPE
"                                                                                                   SOCKET_EPROTO
"                                                                                                   SOCKET_EPROTONOSUPPORT
"                                                                                                   SOCKET_EPROTOTYPE
"                                                                                                   SOCKET_EREMCHG
"                                                                                                   SOCKET_EREMOTE
"                                                                                                   SOCKET_EREMOTEIO
"                                                                                                   SOCKET_ERESTART
"                                                                                                   SOCKET_EROFS
"                                                                                                   SOCKET_ESHUTDOWN
"                                                                                                   SOCKET_ESOCKTNOSUPPORT
"                                                                                                   SOCKET_ESPIPE
"                                                                                                   SOCKET_ESRMNT
"                                                                                                   SOCKET_ESTRPIPE
"                                                                                                   SOCKET_ETIME
"                                                                                                   SOCKET_ETIMEDOUT
"                                                                                                   SOCKET_ETOOMANYREFS
"                                                                                                   SOCKET_EUNATCH
"                                                                                                   SOCKET_EUSERS
"                                                                                                   SOCKET_EWOULDBLOCK
"                                                                                                   SOCKET_EXDEV
"                                                                                                   SOCKET_EXFULL
"                                                                                                   SOCK_DGRAM
"                                                                                                   SOCK_RAW
"                                                                                                   SOCK_RDM
"                                                                                                   SOCK_SEQPACKET
"                                                                                                   SOCK_STREAM
"                                                                                                   SOL_SOCKET
"                                                                                                   SOL_TCP
"                                                                                                   SOL_UDP
"                                                                                                   SOMAXCONN
"                                                                                                   SO_BINDTODEVICE
"                                                                                                   SO_BROADCAST
"                                                                                                   SO_DEBUG
"                                                                                                   SO_DONTROUTE
"                                                                                                   SO_ERROR
"                                                                                                   SO_KEEPALIVE
"                                                                                                   SO_LINGER
"                                                                                                   SO_OOBINLINE
"                                                                                                   SO_PASSCRED
"                                                                                                   SO_RCVBUF
"                                                                                                   SO_RCVLOWAT
"                                                                                                   SO_RCVTIMEO
"                                                                                                   SO_REUSEADDR
"                                                                                                   SO_REUSEPORT
"                                                                                                   SO_SNDBUF
"                                                                                                   SO_SNDLOWAT
"                                                                                                   SO_SNDTIMEO
"                                                                                                   SO_TYPE
"                                                                                                   TCP_NODELAY
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "spl")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "spl")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "spl")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "spl")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   SPL
"                                                                                                   constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   ALL_MATCHES
"                                                                                                   ARRAY_AS_PROPS
"                                                                                                   BYPASS_CURRENT
"                                                                                                   BYPASS_KEY
"                                                                                                   CALL_TOSTRING
"                                                                                                   CATCH_GET_CHILD
"                                                                                                   CHILD_ARRAYS_ONLY
"                                                                                                   CHILD_FIRST
"                                                                                                   CURRENT_AS_FILEINFO
"                                                                                                   CURRENT_AS_PATHNAME
"                                                                                                   CURRENT_AS_SELF
"                                                                                                   CURRENT_MODE_MASK
"                                                                                                   DROP_NEW_LINE
"                                                                                                   EXTR_BOTH
"                                                                                                   EXTR_DATA
"                                                                                                   EXTR_PRIORITY
"                                                                                                   FOLLOW_SYMLINKS
"                                                                                                   FULL_CACHE
"                                                                                                   GET_MATCH
"                                                                                                   INVERT_MATCH
"                                                                                                   IT_MODE_DELETE
"                                                                                                   IT_MODE_FIFO
"                                                                                                   IT_MODE_KEEP
"                                                                                                   IT_MODE_LIFO
"                                                                                                   KEY_AS_FILENAME
"                                                                                                   KEY_AS_PATHNAME
"                                                                                                   KEY_MODE_MASK
"                                                                                                   LEAVES_ONLY
"                                                                                                   MATCH
"                                                                                                   MIT_KEYS_ASSOC
"                                                                                                   MIT_KEYS_NUMERIC
"                                                                                                   MIT_NEED_ALL
"                                                                                                   MIT_NEED_ANY
"                                                                                                   NEW_CURRENT_AND_KEY
"                                                                                                   OTHER_MODE_MASK
"                                                                                                   PREFIX_END_HAS_NEXT
"                                                                                                   PREFIX_END_LAST
"                                                                                                   PREFIX_LEFT
"                                                                                                   PREFIX_MID_HAS_NEXT
"                                                                                                   PREFIX_MID_LAST
"                                                                                                   PREFIX_RIGHT
"                                                                                                   READ_AHEAD
"                                                                                                   READ_CSV
"                                                                                                   REPLACE
"                                                                                                   SELF_FIRST
"                                                                                                   SKIP_DOTS
"                                                                                                   SKIP_EMPTY
"                                                                                                   SPLIT
"                                                                                                   STD_PROP_LIST
"                                                                                                   TOSTRING_USE_CURRENT
"                                                                                                   TOSTRING_USE_INNER TOSTRING_USE_KEY UNIX_PATHS USE_KEY contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "sqlite3") >= 0 && index(g:php_syntax_extensions_disabled, "sqlite3") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "sqlite3") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "sqlite3") < 0)
"                                                                                                   " sqlite3 constants
"                                                                                                   syn keyword phpConstants SQLITE3_ASSOC SQLITE3_BLOB SQLITE3_BOTH SQLITE3_FLOAT SQLITE3_INTEGER SQLITE3_NULL SQLITE3_NUM SQLITE3_OPEN_CREATE SQLITE3_OPEN_READONLY SQLITE3_OPEN_READWRITE SQLITE3_TEXT contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "standard") >= 0 && index(g:php_syntax_extensions_disabled, "standard") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "standard") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "standard") < 0)
"                                                                                                   " standard constants
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpConstants
"                                                                                                   ABDAY_1
"                                                                                                   ABDAY_2
"                                                                                                   ABDAY_3
"                                                                                                   ABDAY_4
"                                                                                                   ABDAY_5
"                                                                                                   ABDAY_6
"                                                                                                   ABDAY_7
"                                                                                                   ABMON_1
"                                                                                                   ABMON_2
"                                                                                                   ABMON_3
"                                                                                                   ABMON_4
"                                                                                                   ABMON_5
"                                                                                                   ABMON_6
"                                                                                                   ABMON_7
"                                                                                                   ABMON_8
"                                                                                                   ABMON_9
"                                                                                                   ABMON_10
"                                                                                                   ABMON_11
"                                                                                                   ABMON_12
"                                                                                                   ALT_DIGITS
"                                                                                                   AM_STR
"                                                                                                   ARRAY_FILTER_USE_BOTH
"                                                                                                   ARRAY_FILTER_USE_KEY
"                                                                                                   ASSERT_ACTIVE
"                                                                                                   ASSERT_BAIL
"                                                                                                   ASSERT_CALLBACK
"                                                                                                   ASSERT_QUIET_EVAL
"                                                                                                   ASSERT_WARNING
"                                                                                                   CASE_LOWER
"                                                                                                   CASE_UPPER
"                                                                                                   CHAR_MAX
"                                                                                                   CODESET
"                                                                                                   CONNECTION_ABORTED
"                                                                                                   CONNECTION_NORMAL
"                                                                                                   CONNECTION_TIMEOUT
"                                                                                                   COUNT_NORMAL
"                                                                                                   COUNT_RECURSIVE
"                                                                                                   CREDITS_ALL
"                                                                                                   CREDITS_DOCS
"                                                                                                   CREDITS_FULLPAGE
"                                                                                                   CREDITS_GENERAL
"                                                                                                   CREDITS_GROUP
"                                                                                                   CREDITS_MODULES
"                                                                                                   CREDITS_QA
"                                                                                                   CREDITS_SAPI
"                                                                                                   CRNCYSTR
"                                                                                                   CRYPT_BLOWFISH
"                                                                                                   CRYPT_EXT_DES
"                                                                                                   CRYPT_MD5
"                                                                                                   CRYPT_SALT_LENGTH
"                                                                                                   CRYPT_SHA256
"                                                                                                   CRYPT_SHA512
"                                                                                                   CRYPT_STD_DES
"                                                                                                   DAY_1
"                                                                                                   DAY_2
"                                                                                                   DAY_3
"                                                                                                   DAY_4
"                                                                                                   DAY_5
"                                                                                                   DAY_6
"                                                                                                   DAY_7
"                                                                                                   DIRECTORY_SEPARATOR
"                                                                                                   DNS_A
"                                                                                                   DNS_A6
"                                                                                                   DNS_AAAA
"                                                                                                   DNS_ALL
"                                                                                                   DNS_ANY
"                                                                                                   DNS_CNAME
"                                                                                                   DNS_HINFO
"                                                                                                   DNS_MX
"                                                                                                   DNS_NAPTR
"                                                                                                   DNS_NS
"                                                                                                   DNS_PTR
"                                                                                                   DNS_SOA
"                                                                                                   DNS_SRV
"                                                                                                   DNS_TXT
"                                                                                                   D_FMT
"                                                                                                   D_T_FMT
"                                                                                                   ENT_COMPAT
"                                                                                                   ENT_DISALLOWED
"                                                                                                   ENT_HTML5
"                                                                                                   ENT_HTML401
"                                                                                                   ENT_IGNORE
"                                                                                                   ENT_NOQUOTES
"                                                                                                   ENT_QUOTES
"                                                                                                   ENT_SUBSTITUTE
"                                                                                                   ENT_XHTML
"                                                                                                   ENT_XML1
"                                                                                                   ERA
"                                                                                                   ERA_D_FMT
"                                                                                                   ERA_D_T_FMT
"                                                                                                   ERA_T_FMT
"                                                                                                   EXTR_IF_EXISTS
"                                                                                                   EXTR_OVERWRITE
"                                                                                                   EXTR_PREFIX_ALL
"                                                                                                   EXTR_PREFIX_IF_EXISTS
"                                                                                                   EXTR_PREFIX_INVALID
"                                                                                                   EXTR_PREFIX_SAME
"                                                                                                   EXTR_REFS
"                                                                                                   EXTR_SKIP
"                                                                                                   FILE_APPEND
"                                                                                                   FILE_BINARY
"                                                                                                   FILE_IGNORE_NEW_LINES
"                                                                                                   FILE_NO_DEFAULT_CONTEXT
"                                                                                                   FILE_SKIP_EMPTY_LINES
"                                                                                                   FILE_TEXT
"                                                                                                   FILE_USE_INCLUDE_PATH
"                                                                                                   FNM_CASEFOLD
"                                                                                                   FNM_NOESCAPE
"                                                                                                   FNM_PATHNAME
"                                                                                                   FNM_PERIOD
"                                                                                                   GLOB_AVAILABLE_FLAGS
"                                                                                                   GLOB_BRACE
"                                                                                                   GLOB_ERR
"                                                                                                   GLOB_MARK
"                                                                                                   GLOB_NOCHECK
"                                                                                                   GLOB_NOESCAPE
"                                                                                                   GLOB_NOSORT
"                                                                                                   GLOB_ONLYDIR
"                                                                                                   HTML_ENTITIES
"                                                                                                   HTML_SPECIALCHARS
"                                                                                                   IMAGETYPE_BMP
"                                                                                                   IMAGETYPE_COUNT
"                                                                                                   IMAGETYPE_GIF
"                                                                                                   IMAGETYPE_ICO
"                                                                                                   IMAGETYPE_IFF
"                                                                                                   IMAGETYPE_JB2
"                                                                                                   IMAGETYPE_JP2
"                                                                                                   IMAGETYPE_JPC
"                                                                                                   IMAGETYPE_JPEG
"                                                                                                   IMAGETYPE_JPEG2000
"                                                                                                   IMAGETYPE_JPX
"                                                                                                   IMAGETYPE_PNG
"                                                                                                   IMAGETYPE_PSD
"                                                                                                   IMAGETYPE_SWC
"                                                                                                   IMAGETYPE_SWF
"                                                                                                   IMAGETYPE_TIFF_II
"                                                                                                   IMAGETYPE_TIFF_MM
"                                                                                                   IMAGETYPE_UNKNOWN
"                                                                                                   IMAGETYPE_WBMP
"                                                                                                   IMAGETYPE_XBM
"                                                                                                   INF
"                                                                                                   INFO_ALL
"                                                                                                   INFO_CONFIGURATION
"                                                                                                   INFO_CREDITS
"                                                                                                   INFO_ENVIRONMENT
"                                                                                                   INFO_GENERAL
"                                                                                                   INFO_LICENSE
"                                                                                                   INFO_MODULES
"                                                                                                   INFO_VARIABLES
"                                                                                                   INI_ALL
"                                                                                                   INI_PERDIR
"                                                                                                   INI_SCANNER_NORMAL
"                                                                                                   INI_SCANNER_RAW
"                                                                                                   INI_SCANNER_TYPED
"                                                                                                   INI_SYSTEM
"                                                                                                   INI_USER
"                                                                                                   LC_ALL
"                                                                                                   LC_COLLATE
"                                                                                                   LC_CTYPE
"                                                                                                   LC_MESSAGES
"                                                                                                   LC_MONETARY
"                                                                                                   LC_NUMERIC
"                                                                                                   LC_TIME
"                                                                                                   LOCK_EX
"                                                                                                   LOCK_NB
"                                                                                                   LOCK_SH
"                                                                                                   LOCK_UN
"                                                                                                   LOG_ALERT
"                                                                                                   LOG_AUTH
"                                                                                                   LOG_AUTHPRIV
"                                                                                                   LOG_CONS
"                                                                                                   LOG_CRIT
"                                                                                                   LOG_CRON
"                                                                                                   LOG_DAEMON
"                                                                                                   LOG_DEBUG
"                                                                                                   LOG_EMERG
"                                                                                                   LOG_ERR
"                                                                                                   LOG_INFO
"                                                                                                   LOG_KERN
"                                                                                                   LOG_LOCAL0
"                                                                                                   LOG_LOCAL1
"                                                                                                   LOG_LOCAL2
"                                                                                                   LOG_LOCAL3
"                                                                                                   LOG_LOCAL4
"                                                                                                   LOG_LOCAL5
"                                                                                                   LOG_LOCAL6
"                                                                                                   LOG_LOCAL7
"                                                                                                   LOG_LPR
"                                                                                                   LOG_MAIL
"                                                                                                   LOG_NDELAY
"                                                                                                   LOG_NEWS
"                                                                                                   LOG_NOTICE
"                                                                                                   LOG_NOWAIT
"                                                                                                   LOG_ODELAY
"                                                                                                   LOG_PERROR
"                                                                                                   LOG_PID
"                                                                                                   LOG_SYSLOG
"                                                                                                   LOG_USER
"                                                                                                   LOG_UUCP
"                                                                                                   LOG_WARNING
"                                                                                                   MON_1
"                                                                                                   MON_2
"                                                                                                   MON_3
"                                                                                                   MON_4
"                                                                                                   MON_5
"                                                                                                   MON_6
"                                                                                                   MON_7
"                                                                                                   MON_8
"                                                                                                   MON_9
"                                                                                                   MON_10
"                                                                                                   MON_11
"                                                                                                   MON_12
"                                                                                                   M_1_PI
"                                                                                                   M_2_PI
"                                                                                                   M_2_SQRTPI
"                                                                                                   M_E
"                                                                                                   M_EULER
"                                                                                                   M_LN2
"                                                                                                   M_LN10
"                                                                                                   M_LNPI
"                                                                                                   M_LOG2E
"                                                                                                   M_LOG10E
"                                                                                                   M_PI
"                                                                                                   M_PI_2
"                                                                                                   M_PI_4
"                                                                                                   M_SQRT1_2
"                                                                                                   M_SQRT2
"                                                                                                   M_SQRT3
"                                                                                                   M_SQRTPI
"                                                                                                   NAN
"                                                                                                   NOEXPR
"                                                                                                   PASSWORD_BCRYPT
"                                                                                                   PASSWORD_BCRYPT_DEFAULT_COST
"                                                                                                   PASSWORD_DEFAULT
"                                                                                                   PATHINFO_BASENAME
"                                                                                                   PATHINFO_DIRNAME
"                                                                                                   PATHINFO_EXTENSION
"                                                                                                   PATHINFO_FILENAME
"                                                                                                   PATH_SEPARATOR
"                                                                                                   PHP_QUERY_RFC1738
"                                                                                                   PHP_QUERY_RFC3986
"                                                                                                   PHP_ROUND_HALF_DOWN
"                                                                                                   PHP_ROUND_HALF_EVEN
"                                                                                                   PHP_ROUND_HALF_ODD
"                                                                                                   PHP_ROUND_HALF_UP
"                                                                                                   PHP_URL_FRAGMENT
"                                                                                                   PHP_URL_HOST
"                                                                                                   PHP_URL_PASS
"                                                                                                   PHP_URL_PATH
"                                                                                                   PHP_URL_PORT
"                                                                                                   PHP_URL_QUERY
"                                                                                                   PHP_URL_SCHEME
"                                                                                                   PHP_URL_USER
"                                                                                                   PM_STR
"                                                                                                   PSFS_ERR_FATAL
"                                                                                                   PSFS_FEED_ME
"                                                                                                   PSFS_FLAG_FLUSH_CLOSE
"                                                                                                   PSFS_FLAG_FLUSH_INC
"                                                                                                   PSFS_FLAG_NORMAL
"                                                                                                   PSFS_PASS_ON
"                                                                                                   RADIXCHAR
"                                                                                                   SCANDIR_SORT_ASCENDING
"                                                                                                   SCANDIR_SORT_DESCENDING
"                                                                                                   SCANDIR_SORT_NONE
"                                                                                                   SEEK_CUR
"                                                                                                   SEEK_END
"                                                                                                   SEEK_SET
"                                                                                                   SORT_ASC
"                                                                                                   SORT_DESC
"                                                                                                   SORT_FLAG_CASE
"                                                                                                   SORT_LOCALE_STRING
"                                                                                                   SORT_NATURAL
"                                                                                                   SORT_NUMERIC
"                                                                                                   SORT_REGULAR
"                                                                                                   SORT_STRING
"                                                                                                   STREAM_BUFFER_FULL
"                                                                                                   STREAM_BUFFER_LINE
"                                                                                                   STREAM_BUFFER_NONE
"                                                                                                   STREAM_CAST_AS_STREAM
"                                                                                                   STREAM_CAST_FOR_SELECT
"                                                                                                   STREAM_CLIENT_ASYNC_CONNECT
"                                                                                                   STREAM_CLIENT_CONNECT
"                                                                                                   STREAM_CLIENT_PERSISTENT
"                                                                                                   STREAM_CRYPTO_METHOD_ANY_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_ANY_SERVER
"                                                                                                   STREAM_CRYPTO_METHOD_SSLv2_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_SSLv2_SERVER
"                                                                                                   STREAM_CRYPTO_METHOD_SSLv3_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_SSLv3_SERVER
"                                                                                                   STREAM_CRYPTO_METHOD_SSLv23_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_SSLv23_SERVER
"                                                                                                   STREAM_CRYPTO_METHOD_TLS_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_TLS_SERVER
"                                                                                                   STREAM_CRYPTO_METHOD_TLSv1_0_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_TLSv1_0_SERVER
"                                                                                                   STREAM_CRYPTO_METHOD_TLSv1_1_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_TLSv1_1_SERVER
"                                                                                                   STREAM_CRYPTO_METHOD_TLSv1_2_CLIENT
"                                                                                                   STREAM_CRYPTO_METHOD_TLSv1_2_SERVER
"                                                                                                   STREAM_FILTER_ALL
"                                                                                                   STREAM_FILTER_READ
"                                                                                                   STREAM_FILTER_WRITE
"                                                                                                   STREAM_IGNORE_URL
"                                                                                                   STREAM_IPPROTO_ICMP
"                                                                                                   STREAM_IPPROTO_IP
"                                                                                                   STREAM_IPPROTO_RAW
"                                                                                                   STREAM_IPPROTO_TCP
"                                                                                                   STREAM_IPPROTO_UDP
"                                                                                                   STREAM_IS_URL
"                                                                                                   STREAM_META_ACCESS
"                                                                                                   STREAM_META_GROUP
"                                                                                                   STREAM_META_GROUP_NAME
"                                                                                                   STREAM_META_OWNER
"                                                                                                   STREAM_META_OWNER_NAME
"                                                                                                   STREAM_META_TOUCH
"                                                                                                   STREAM_MKDIR_RECURSIVE
"                                                                                                   STREAM_MUST_SEEK
"                                                                                                   STREAM_NOTIFY_AUTH_REQUIRED
"                                                                                                   STREAM_NOTIFY_AUTH_RESULT
"                                                                                                   STREAM_NOTIFY_COMPLETED
"                                                                                                   STREAM_NOTIFY_CONNECT
"                                                                                                   STREAM_NOTIFY_FAILURE
"                                                                                                   STREAM_NOTIFY_FILE_SIZE_IS
"                                                                                                   STREAM_NOTIFY_MIME_TYPE_IS
"                                                                                                   STREAM_NOTIFY_PROGRESS
"                                                                                                   STREAM_NOTIFY_REDIRECTED
"                                                                                                   STREAM_NOTIFY_RESOLVE
"                                                                                                   STREAM_NOTIFY_SEVERITY_ERR
"                                                                                                   STREAM_NOTIFY_SEVERITY_INFO
"                                                                                                   STREAM_NOTIFY_SEVERITY_WARN
"                                                                                                   STREAM_OOB
"                                                                                                   STREAM_OPTION_BLOCKING
"                                                                                                   STREAM_OPTION_READ_BUFFER
"                                                                                                   STREAM_OPTION_READ_TIMEOUT
"                                                                                                   STREAM_OPTION_WRITE_BUFFER
"                                                                                                   STREAM_PEEK
"                                                                                                   STREAM_PF_INET
"                                                                                                   STREAM_PF_INET6
"                                                                                                   STREAM_PF_UNIX
"                                                                                                   STREAM_REPORT_ERRORS
"                                                                                                   STREAM_SERVER_BIND
"                                                                                                   STREAM_SERVER_LISTEN
"                                                                                                   STREAM_SHUT_RD
"                                                                                                   STREAM_SHUT_RDWR
"                                                                                                   STREAM_SHUT_WR
"                                                                                                   STREAM_SOCK_DGRAM
"                                                                                                   STREAM_SOCK_RAW
"                                                                                                   STREAM_SOCK_RDM
"                                                                                                   STREAM_SOCK_SEQPACKET
"                                                                                                   STREAM_SOCK_STREAM
"                                                                                                   STREAM_URL_STAT_LINK
"                                                                                                   STREAM_URL_STAT_QUIET
"                                                                                                   STREAM_USE_PATH
"                                                                                                   STR_PAD_BOTH
"                                                                                                   STR_PAD_LEFT
"                                                                                                   STR_PAD_RIGHT
"                                                                                                   THOUSEP T_FMT T_FMT_AMPM YESEXPR contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "tokenizer") >= 0 && index(g:php_syntax_extensions_disabled, "tokenizer") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "tokenizer") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "tokenizer") < 0)
"                                                                                                   " tokenizer constants
"                                                                                                   syn keyword phpConstants T_ABSTRACT T_AND_EQUAL T_ARRAY T_ARRAY_CAST T_AS T_BAD_CHARACTER T_BOOLEAN_AND T_BOOLEAN_OR T_BOOL_CAST T_BREAK T_CALLABLE T_CASE T_CATCH T_CHARACTER T_CLASS T_CLASS_C T_CLONE T_CLOSE_TAG T_COMMENT T_CONCAT_EQUAL T_CONST T_CONSTANT_ENCAPSED_STRING T_CONTINUE T_CURLY_OPEN T_DEC T_DECLARE T_DEFAULT T_DIR T_DIV_EQUAL T_DNUMBER T_DO T_DOC_COMMENT T_DOLLAR_OPEN_CURLY_BRACES T_DOUBLE_ARROW T_DOUBLE_CAST T_DOUBLE_COLON T_ECHO T_ELLIPSIS T_ELSE T_ELSEIF T_EMPTY T_ENCAPSED_AND_WHITESPACE T_ENDDECLARE T_ENDFOR T_ENDFOREACH T_ENDIF T_ENDSWITCH T_ENDWHILE T_END_HEREDOC T_EVAL T_EXIT T_EXTENDS T_FILE T_FINAL T_FINALLY T_FOR T_FOREACH T_FUNCTION T_FUNC_C T_GLOBAL T_GOTO T_HALT_COMPILER T_IF T_IMPLEMENTS T_INC T_INCLUDE T_INCLUDE_ONCE T_INLINE_HTML T_INSTANCEOF T_INSTEADOF T_INTERFACE T_INT_CAST T_ISSET T_IS_EQUAL T_IS_GREATER_OR_EQUAL T_IS_IDENTICAL T_IS_NOT_EQUAL T_IS_NOT_IDENTICAL T_IS_SMALLER_OR_EQUAL T_LINE T_LIST T_LNUMBER T_LOGICAL_AND T_LOGICAL_OR T_LOGICAL_XOR T_METHOD_C T_MINUS_EQUAL T_MOD_EQUAL T_MUL_EQUAL T_NAMESPACE T_NEW T_NS_C T_NS_SEPARATOR T_NUM_STRING T_OBJECT_CAST T_OBJECT_OPERATOR T_OPEN_TAG T_OPEN_TAG_WITH_ECHO T_OR_EQUAL T_PAAMAYIM_NEKUDOTAYIM T_PLUS_EQUAL T_POW T_POW_EQUAL T_PRINT T_PRIVATE T_PROTECTED T_PUBLIC T_REQUIRE T_REQUIRE_ONCE T_RETURN T_SL T_SL_EQUAL T_SR T_SR_EQUAL T_START_HEREDOC T_STATIC T_STRING T_STRING_CAST T_STRING_VARNAME T_SWITCH T_THROW T_TRAIT T_TRAIT_C T_TRY T_UNSET T_UNSET_CAST T_USE T_VAR T_VARIABLE T_WHILE T_WHITESPACE T_XOR_EQUAL T_YIELD contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "xml") >= 0 && index(g:php_syntax_extensions_disabled, "xml") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "xml") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "xml") < 0)
"                                                                                                   " xml constants
"                                                                                                   syn keyword phpConstants XML_ERROR_ASYNC_ENTITY XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF XML_ERROR_BAD_CHAR_REF XML_ERROR_BINARY_ENTITY_REF XML_ERROR_DUPLICATE_ATTRIBUTE XML_ERROR_EXTERNAL_ENTITY_HANDLING XML_ERROR_INCORRECT_ENCODING XML_ERROR_INVALID_TOKEN XML_ERROR_JUNK_AFTER_DOC_ELEMENT XML_ERROR_MISPLACED_XML_PI XML_ERROR_NONE XML_ERROR_NO_ELEMENTS XML_ERROR_NO_MEMORY XML_ERROR_PARAM_ENTITY_REF XML_ERROR_PARTIAL_CHAR XML_ERROR_RECURSIVE_ENTITY_REF XML_ERROR_SYNTAX XML_ERROR_TAG_MISMATCH XML_ERROR_UNCLOSED_CDATA_SECTION XML_ERROR_UNCLOSED_TOKEN XML_ERROR_UNDEFINED_ENTITY XML_ERROR_UNKNOWN_ENCODING XML_OPTION_CASE_FOLDING XML_OPTION_SKIP_TAGSTART XML_OPTION_SKIP_WHITE XML_OPTION_TARGET_ENCODING XML_SAX_IMPL contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "xmlreader") >= 0 && index(g:php_syntax_extensions_disabled, "xmlreader") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "xmlreader") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "xmlreader") < 0)
"                                                                                                   " xmlreader constants
"                                                                                                   syn keyword phpConstants ATTRIBUTE CDATA COMMENT DEFAULTATTRS DOC DOC_FRAGMENT DOC_TYPE ELEMENT END_ELEMENT END_ENTITY ENTITY ENTITY_REF LOADDTD NONE NOTATION PI SIGNIFICANT_WHITESPACE SUBST_ENTITIES TEXT VALIDATE WHITESPACE XML_DECLARATION contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "zip") >= 0 && index(g:php_syntax_extensions_disabled, "zip") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "zip") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "zip") < 0)
"                                                                                                   " zip constants
"                                                                                                   syn keyword phpConstants CHECKCONS CM_BZIP2 CM_DEFAULT CM_DEFLATE CM_DEFLATE64 CM_IMPLODE CM_LZ77 CM_LZMA CM_PKWARE_IMPLODE CM_PPMD CM_REDUCE_1 CM_REDUCE_2 CM_REDUCE_3 CM_REDUCE_4 CM_SHRINK CM_STORE CM_TERSE CM_WAVPACK CREATE ER_CHANGED ER_CLOSE ER_COMPNOTSUPP ER_CRC ER_DELETED ER_EOF ER_EXISTS ER_INCONS ER_INTERNAL ER_INVAL ER_MEMORY ER_MULTIDISK ER_NOENT ER_NOZIP ER_OK ER_OPEN ER_READ ER_REMOVE ER_RENAME ER_SEEK ER_TMPOPEN ER_WRITE ER_ZIPCLOSED ER_ZLIB EXCL FL_COMPRESSED FL_NOCASE FL_NODIR FL_UNCHANGED OPSYS_ACORN_RISC OPSYS_ALTERNATE_MVS OPSYS_AMIGA OPSYS_ATARI_ST OPSYS_BEOS OPSYS_DEFAULT OPSYS_DOS OPSYS_MACINTOSH OPSYS_MVS OPSYS_OPENVMS OPSYS_OS_2 OPSYS_OS_400 OPSYS_OS_X OPSYS_TANDEM OPSYS_UNIX OPSYS_VFAT OPSYS_VM_CMS OPSYS_VSE OPSYS_WINDOWS_NTFS OPSYS_Z_CPM OPSYS_Z_SYSTEM OVERWRITE contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "zlib") >= 0 && index(g:php_syntax_extensions_disabled, "zlib") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "zlib") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "zlib") < 0)
"                                                                                                   " zlib constants
"                                                                                                   syn keyword phpConstants FORCE_DEFLATE FORCE_GZIP ZLIB_ENCODING_DEFLATE ZLIB_ENCODING_GZIP ZLIB_ENCODING_RAW contained
"                                                                                                   endif
"                                                                                                   syn case ignore
"                                                                                                   if index(g:php_syntax_extensions_enabled, "bcmath") >= 0 && index(g:php_syntax_extensions_disabled, "bcmath") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "bcmath") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "bcmath") < 0)
"                                                                                                   " bcmath functions
"                                                                                                   syn keyword phpFunctions bcadd bccomp bcdiv bcmod bcmul bcpow bcpowmod bcscale bcsqrt bcsub contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "bz2") >= 0 && index(g:php_syntax_extensions_disabled, "bz2") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "bz2") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "bz2") < 0)
"                                                                                                   " bz2 functions
"                                                                                                   syn keyword phpFunctions bzclose bzcompress bzdecompress bzerrno bzerror bzerrstr bzflush bzopen bzread bzwrite contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "core") >= 0 && index(g:php_syntax_extensions_disabled, "core") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "core") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "core") < 0)
"                                                                                                   " Core functions
"                                                                                                   syn keyword phpFunctions class_alias class_exists create_function debug_backtrace debug_print_backtrace define defined each error_reporting extension_loaded func_get_arg func_get_args func_num_args function_exists gc_collect_cycles gc_disable gc_enable gc_enabled get_called_class get_class get_class_methods get_class_vars get_declared_classes get_declared_interfaces get_declared_traits get_defined_constants get_defined_functions get_defined_vars get_extension_funcs get_included_files get_loaded_extensions get_object_vars get_parent_class get_required_files get_resource_type interface_exists is_a is_subclass_of method_exists property_exists restore_error_handler restore_exception_handler set_error_handler set_exception_handler strcasecmp strcmp strlen strncasecmp strncmp trait_exists trigger_error user_error zend_version contained
"                                                                                                   " Core classes and interfaces
"                                                                                                   syn keyword phpClasses ArrayAccess Closure ErrorException Exception Generator Iterator IteratorAggregate Serializable Traversable stdClass contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "curl") >= 0 && index(g:php_syntax_extensions_disabled, "curl") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "curl") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "curl") < 0)
"                                                                                                   " curl functions
"                                                                                                   syn keyword phpFunctions curl_close curl_copy_handle curl_errno curl_error curl_escape curl_exec curl_file_create curl_getinfo curl_init curl_multi_add_handle curl_multi_close curl_multi_exec curl_multi_getcontent curl_multi_info_read curl_multi_init curl_multi_remove_handle curl_multi_select curl_multi_setopt curl_multi_strerror curl_pause curl_reset curl_setopt curl_setopt_array curl_share_close curl_share_init curl_share_setopt curl_strerror curl_unescape curl_version contained
"                                                                                                   " curl classes and interfaces
"                                                                                                   syn keyword phpClasses CURLFile contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "date") >= 0 && index(g:php_syntax_extensions_disabled, "date") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "date") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "date") < 0)
"                                                                                                   " date functions
"                                                                                                   syn keyword phpFunctions checkdate date date_add date_create date_create_from_format date_create_immutable date_create_immutable_from_format date_date_set date_default_timezone_get date_default_timezone_set date_diff date_format date_get_last_errors date_interval_create_from_date_string date_interval_format date_isodate_set date_modify date_offset_get date_parse date_parse_from_format date_sub date_sun_info date_sunrise date_sunset date_time_set date_timestamp_get date_timestamp_set date_timezone_get date_timezone_set getdate gmdate gmmktime gmstrftime idate localtime mktime strftime strtotime time timezone_abbreviations_list timezone_identifiers_list timezone_location_get timezone_name_from_abbr timezone_name_get timezone_offset_get timezone_open timezone_transitions_get timezone_version_get contained
"                                                                                                   " date classes and interfaces
"                                                                                                   syn keyword phpClasses DateInterval DatePeriod DateTime DateTimeImmutable DateTimeInterface DateTimeZone contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "dom") >= 0 && index(g:php_syntax_extensions_disabled, "dom") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "dom") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "dom") < 0)
"                                                                                                   " dom functions
"                                                                                                   syn keyword phpFunctions dom_import_simplexml contained
"                                                                                                   " dom classes and interfaces
"                                                                                                   syn keyword phpClasses DOMAttr DOMCdataSection DOMCharacterData DOMComment DOMConfiguration DOMDocument DOMDocumentFragment DOMDocumentType DOMDomError DOMElement DOMEntity DOMEntityReference DOMErrorHandler DOMException DOMImplementation DOMImplementationList DOMImplementationSource DOMLocator DOMNameList DOMNameSpaceNode DOMNamedNodeMap DOMNode DOMNodeList DOMNotation DOMProcessingInstruction DOMStringExtend DOMStringList DOMText DOMTypeinfo DOMUserDataHandler DOMXPath contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "ereg") >= 0 && index(g:php_syntax_extensions_disabled, "ereg") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "ereg") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "ereg") < 0)
"                                                                                                   " ereg functions
"                                                                                                   syn keyword phpFunctions ereg ereg_replace eregi eregi_replace split spliti sql_regcase contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "gd")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "gd")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "gd")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "gd")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   gd
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   gd_info
"                                                                                                   image2wbmp
"                                                                                                   imageaffine
"                                                                                                   imageaffinematrixconcat
"                                                                                                   imageaffinematrixget
"                                                                                                   imagealphablending
"                                                                                                   imagearc
"                                                                                                   imagechar
"                                                                                                   imagecharup
"                                                                                                   imagecolorallocate
"                                                                                                   imagecolorallocatealpha
"                                                                                                   imagecolorat
"                                                                                                   imagecolorclosest
"                                                                                                   imagecolorclosestalpha
"                                                                                                   imagecolorclosesthwb
"                                                                                                   imagecolordeallocate
"                                                                                                   imagecolorexact
"                                                                                                   imagecolorexactalpha
"                                                                                                   imagecolormatch
"                                                                                                   imagecolorresolve
"                                                                                                   imagecolorresolvealpha
"                                                                                                   imagecolorset
"                                                                                                   imagecolorsforindex
"                                                                                                   imagecolorstotal
"                                                                                                   imagecolortransparent
"                                                                                                   imageconvolution
"                                                                                                   imagecopy
"                                                                                                   imagecopymerge
"                                                                                                   imagecopymergegray
"                                                                                                   imagecopyresampled
"                                                                                                   imagecopyresized
"                                                                                                   imagecreate
"                                                                                                   imagecreatefromgd
"                                                                                                   imagecreatefromgd2
"                                                                                                   imagecreatefromgd2part
"                                                                                                   imagecreatefromgif
"                                                                                                   imagecreatefromjpeg
"                                                                                                   imagecreatefrompng
"                                                                                                   imagecreatefromstring
"                                                                                                   imagecreatefromwbmp
"                                                                                                   imagecreatefromwebp
"                                                                                                   imagecreatefromxbm
"                                                                                                   imagecreatefromxpm
"                                                                                                   imagecreatetruecolor
"                                                                                                   imagecrop
"                                                                                                   imagecropauto
"                                                                                                   imagedashedline
"                                                                                                   imagedestroy
"                                                                                                   imageellipse
"                                                                                                   imagefill
"                                                                                                   imagefilledarc
"                                                                                                   imagefilledellipse
"                                                                                                   imagefilledpolygon
"                                                                                                   imagefilledrectangle
"                                                                                                   imagefilltoborder
"                                                                                                   imagefilter
"                                                                                                   imageflip
"                                                                                                   imagefontheight
"                                                                                                   imagefontwidth
"                                                                                                   imageftbbox
"                                                                                                   imagefttext
"                                                                                                   imagegammacorrect
"                                                                                                   imagegd
"                                                                                                   imagegd2
"                                                                                                   imagegif
"                                                                                                   imageinterlace
"                                                                                                   imageistruecolor
"                                                                                                   imagejpeg
"                                                                                                   imagelayereffect
"                                                                                                   imageline
"                                                                                                   imageloadfont
"                                                                                                   imagepalettecopy
"                                                                                                   imagepalettetotruecolor
"                                                                                                   imagepng
"                                                                                                   imagepolygon
"                                                                                                   imagerectangle
"                                                                                                   imagerotate
"                                                                                                   imagesavealpha
"                                                                                                   imagescale
"                                                                                                   imagesetbrush
"                                                                                                   imagesetinterpolation
"                                                                                                   imagesetpixel
"                                                                                                   imagesetstyle
"                                                                                                   imagesetthickness
"                                                                                                   imagesettile
"                                                                                                   imagestring
"                                                                                                   imagestringup
"                                                                                                   imagesx
"                                                                                                   imagesy
"                                                                                                   imagetruecolortopalette
"                                                                                                   imagettfbbox
"                                                                                                   imagettftext
"                                                                                                   imagetypes
"                                                                                                   imagewbmp
"                                                                                                   imagewebp
"                                                                                                   imagexbm
"                                                                                                   jpeg2wbmp
"                                                                                                   png2wbmp
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "gettext")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "gettext")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "gettext")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "gettext")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   gettext
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   _
"                                                                                                   bind_textdomain_codeset
"                                                                                                   bindtextdomain
"                                                                                                   dcgettext
"                                                                                                   dcngettext
"                                                                                                   dgettext
"                                                                                                   dngettext
"                                                                                                   gettext
"                                                                                                   ngettext
"                                                                                                   textdomain
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "hash")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "hash")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "hash")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "hash")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   hash
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   hash
"                                                                                                   hash_algos
"                                                                                                   hash_copy
"                                                                                                   hash_equals
"                                                                                                   hash_file
"                                                                                                   hash_final
"                                                                                                   hash_hmac
"                                                                                                   hash_hmac_file
"                                                                                                   hash_init
"                                                                                                   hash_pbkdf2
"                                                                                                   hash_update
"                                                                                                   hash_update_file
"                                                                                                   hash_update_stream
"                                                                                                   mhash
"                                                                                                   mhash_count
"                                                                                                   mhash_get_block_size
"                                                                                                   mhash_get_hash_name
"                                                                                                   mhash_keygen_s2k
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "iconv")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "iconv")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "iconv")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "iconv")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   iconv
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   iconv
"                                                                                                   iconv_get_encoding
"                                                                                                   iconv_mime_decode
"                                                                                                   iconv_mime_decode_headers
"                                                                                                   iconv_mime_encode
"                                                                                                   iconv_set_encoding
"                                                                                                   iconv_strlen
"                                                                                                   iconv_strpos
"                                                                                                   iconv_strrpos
"                                                                                                   iconv_substr
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "json")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "json")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "json")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "json")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   json
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   json_decode
"                                                                                                   json_encode
"                                                                                                   json_last_error
"                                                                                                   json_last_error_msg
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   json
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   JsonIncrementalParser
"                                                                                                   JsonSerializable
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "libxml")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "libxml")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "libxml") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "libxml") < 0)
"                                                                                                   " libxml functions
"                                                                                                   syn keyword phpFunctions libxml_clear_errors libxml_disable_entity_loader libxml_get_errors libxml_get_last_error libxml_set_external_entity_loader libxml_set_streams_context libxml_use_internal_errors contained
"                                                                                                   " libxml classes and interfaces
"                                                                                                   syn keyword phpClasses LibXMLError contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "mbstring") >= 0 && index(g:php_syntax_extensions_disabled, "mbstring") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "mbstring") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "mbstring") < 0)
"                                                                                                   " mbstring functions
"                                                                                                   syn keyword phpFunctions mb_check_encoding mb_convert_case mb_convert_encoding mb_convert_kana mb_convert_variables mb_decode_mimeheader mb_decode_numericentity mb_detect_encoding mb_detect_order mb_encode_mimeheader mb_encode_numericentity mb_encoding_aliases mb_ereg mb_ereg_match mb_ereg_replace mb_ereg_replace_callback mb_ereg_search mb_ereg_search_getpos mb_ereg_search_getregs mb_ereg_search_init mb_ereg_search_pos mb_ereg_search_regs mb_ereg_search_setpos mb_eregi mb_eregi_replace mb_get_info mb_http_input mb_http_output mb_internal_encoding mb_language mb_list_encodings mb_output_handler mb_parse_str mb_preferred_mime_name mb_regex_encoding mb_regex_set_options mb_send_mail mb_split mb_strcut mb_strimwidth mb_stripos mb_stristr mb_strlen mb_strpos mb_strrchr mb_strrichr mb_strripos mb_strrpos mb_strstr mb_strtolower mb_strtoupper mb_strwidth mb_substitute_character mb_substr mb_substr_count mbereg mbereg_match mbereg_replace mbereg_search mbereg_search_getpos mbereg_search_getregs mbereg_search_init mbereg_search_pos mbereg_search_regs mbereg_search_setpos mberegi mberegi_replace mbregex_encoding mbsplit contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "mcrypt") >= 0 && index(g:php_syntax_extensions_disabled, "mcrypt") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "mcrypt") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "mcrypt") < 0)
"                                                                                                   " mcrypt functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   mcrypt_cbc
"                                                                                                   mcrypt_cfb
"                                                                                                   mcrypt_create_iv
"                                                                                                   mcrypt_decrypt
"                                                                                                   mcrypt_ecb
"                                                                                                   mcrypt_enc_get_algorithms_name
"                                                                                                   mcrypt_enc_get_block_size
"                                                                                                   mcrypt_enc_get_iv_size
"                                                                                                   mcrypt_enc_get_key_size
"                                                                                                   mcrypt_enc_get_modes_name
"                                                                                                   mcrypt_enc_get_supported_key_sizes
"                                                                                                   mcrypt_enc_is_block_algorithm
"                                                                                                   mcrypt_enc_is_block_algorithm_mode
"                                                                                                   mcrypt_enc_is_block_mode
"                                                                                                   mcrypt_enc_self_test
"                                                                                                   mcrypt_encrypt
"                                                                                                   mcrypt_generic
"                                                                                                   mcrypt_generic_deinit
"                                                                                                   mcrypt_generic_end
"                                                                                                   mcrypt_generic_init
"                                                                                                   mcrypt_get_block_size
"                                                                                                   mcrypt_get_cipher_name
"                                                                                                   mcrypt_get_iv_size
"                                                                                                   mcrypt_get_key_size
"                                                                                                   mcrypt_list_algorithms
"                                                                                                   mcrypt_list_modes
"                                                                                                   mcrypt_module_close
"                                                                                                   mcrypt_module_get_algo_block_size
"                                                                                                   mcrypt_module_get_algo_key_size
"                                                                                                   mcrypt_module_get_supported_key_sizes
"                                                                                                   mcrypt_module_is_block_algorithm
"                                                                                                   mcrypt_module_is_block_algorithm_mode
"                                                                                                   mcrypt_module_is_block_mode
"                                                                                                   mcrypt_module_open
"                                                                                                   mcrypt_module_self_test
"                                                                                                   mcrypt_ofb
"                                                                                                   mdecrypt_generic
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "mysql")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "mysql")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "mysql")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "mysql")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   mysql
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   mysql
"                                                                                                   mysql_affected_rows
"                                                                                                   mysql_client_encoding
"                                                                                                   mysql_close
"                                                                                                   mysql_connect
"                                                                                                   mysql_data_seek
"                                                                                                   mysql_db_name
"                                                                                                   mysql_db_query
"                                                                                                   mysql_dbname
"                                                                                                   mysql_errno
"                                                                                                   mysql_error
"                                                                                                   mysql_escape_string
"                                                                                                   mysql_fetch_array
"                                                                                                   mysql_fetch_assoc
"                                                                                                   mysql_fetch_field
"                                                                                                   mysql_fetch_lengths
"                                                                                                   mysql_fetch_object
"                                                                                                   mysql_fetch_row
"                                                                                                   mysql_field_flags
"                                                                                                   mysql_field_len
"                                                                                                   mysql_field_name
"                                                                                                   mysql_field_seek
"                                                                                                   mysql_field_table
"                                                                                                   mysql_field_type
"                                                                                                   mysql_fieldflags
"                                                                                                   mysql_fieldlen
"                                                                                                   mysql_fieldname
"                                                                                                   mysql_fieldtable
"                                                                                                   mysql_fieldtype
"                                                                                                   mysql_free_result
"                                                                                                   mysql_freeresult
"                                                                                                   mysql_get_client_info
"                                                                                                   mysql_get_host_info
"                                                                                                   mysql_get_proto_info
"                                                                                                   mysql_get_server_info
"                                                                                                   mysql_info
"                                                                                                   mysql_insert_id
"                                                                                                   mysql_list_dbs
"                                                                                                   mysql_list_fields
"                                                                                                   mysql_list_processes
"                                                                                                   mysql_list_tables
"                                                                                                   mysql_listdbs
"                                                                                                   mysql_listfields
"                                                                                                   mysql_listtables
"                                                                                                   mysql_num_fields
"                                                                                                   mysql_num_rows
"                                                                                                   mysql_numfields
"                                                                                                   mysql_numrows
"                                                                                                   mysql_pconnect
"                                                                                                   mysql_ping
"                                                                                                   mysql_query
"                                                                                                   mysql_real_escape_string
"                                                                                                   mysql_result
"                                                                                                   mysql_select_db
"                                                                                                   mysql_selectdb
"                                                                                                   mysql_set_charset
"                                                                                                   mysql_stat
"                                                                                                   mysql_table_name
"                                                                                                   mysql_tablename
"                                                                                                   mysql_thread_id
"                                                                                                   mysql_unbuffered_query
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "mysqli")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "mysqli")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "mysqli")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "mysqli")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   mysqli
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   mysqli_affected_rows
"                                                                                                   mysqli_autocommit
"                                                                                                   mysqli_begin_transaction
"                                                                                                   mysqli_change_user
"                                                                                                   mysqli_character_set_name
"                                                                                                   mysqli_close mysqli_commit mysqli_connect mysqli_connect_errno mysqli_connect_error mysqli_data_seek mysqli_debug mysqli_dump_debug_info mysqli_errno mysqli_error mysqli_error_list mysqli_escape_string mysqli_execute mysqli_fetch_array mysqli_fetch_assoc mysqli_fetch_field mysqli_fetch_field_direct mysqli_fetch_fields mysqli_fetch_lengths mysqli_fetch_object mysqli_fetch_row mysqli_field_count mysqli_field_seek mysqli_field_tell mysqli_free_result mysqli_get_charset mysqli_get_client_info mysqli_get_client_version mysqli_get_host_info mysqli_get_links_stats mysqli_get_proto_info mysqli_get_server_info mysqli_get_server_version mysqli_get_warnings mysqli_info mysqli_init mysqli_insert_id mysqli_kill mysqli_more_results mysqli_multi_query mysqli_next_result mysqli_num_fields mysqli_num_rows mysqli_options mysqli_ping mysqli_prepare mysqli_query mysqli_real_connect mysqli_real_escape_string mysqli_real_query mysqli_refresh mysqli_release_savepoint mysqli_report mysqli_rollback mysqli_savepoint mysqli_select_db mysqli_set_charset mysqli_set_opt mysqli_sqlstate mysqli_ssl_set mysqli_stat mysqli_stmt_affected_rows mysqli_stmt_attr_get mysqli_stmt_attr_set mysqli_stmt_bind_param mysqli_stmt_bind_result mysqli_stmt_close mysqli_stmt_data_seek mysqli_stmt_errno mysqli_stmt_error mysqli_stmt_error_list mysqli_stmt_execute mysqli_stmt_fetch mysqli_stmt_field_count mysqli_stmt_free_result mysqli_stmt_get_warnings mysqli_stmt_init mysqli_stmt_insert_id mysqli_stmt_num_rows mysqli_stmt_param_count mysqli_stmt_prepare mysqli_stmt_reset mysqli_stmt_result_metadata mysqli_stmt_send_long_data mysqli_stmt_sqlstate mysqli_stmt_store_result mysqli_store_result mysqli_thread_id mysqli_thread_safe mysqli_use_result mysqli_warning_count contained
"                                                                                                   " mysqli classes and interfaces
"                                                                                                   syn keyword phpClasses mysqli mysqli_driver mysqli_result mysqli_sql_exception mysqli_stmt mysqli_warning contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "openssl") >= 0 && index(g:php_syntax_extensions_disabled, "openssl") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "openssl") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "openssl") < 0)
"                                                                                                   " openssl functions
"                                                                                                   syn keyword phpFunctions openssl_cipher_iv_length openssl_csr_export openssl_csr_export_to_file openssl_csr_get_public_key openssl_csr_get_subject openssl_csr_new openssl_csr_sign openssl_decrypt openssl_dh_compute_key openssl_digest openssl_encrypt openssl_error_string openssl_free_key openssl_get_cert_locations openssl_get_cipher_methods openssl_get_md_methods openssl_get_privatekey openssl_get_publickey openssl_open openssl_pbkdf2 openssl_pkcs7_decrypt openssl_pkcs7_encrypt openssl_pkcs7_sign openssl_pkcs7_verify openssl_pkcs12_export openssl_pkcs12_export_to_file openssl_pkcs12_read openssl_pkey_export openssl_pkey_export_to_file openssl_pkey_free openssl_pkey_get_details openssl_pkey_get_private openssl_pkey_get_public openssl_pkey_new openssl_private_decrypt openssl_private_encrypt openssl_public_decrypt openssl_public_encrypt openssl_random_pseudo_bytes openssl_seal openssl_sign openssl_spki_export openssl_spki_export_challenge openssl_spki_new openssl_spki_verify openssl_verify openssl_x509_check_private_key openssl_x509_checkpurpose openssl_x509_export openssl_x509_export_to_file openssl_x509_fingerprint openssl_x509_free openssl_x509_parse openssl_x509_read contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "pcre") >= 0 && index(g:php_syntax_extensions_disabled, "pcre") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "pcre") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "pcre") < 0)
"                                                                                                   " pcre functions
"                                                                                                   syn keyword phpFunctions preg_filter preg_grep preg_last_error preg_match preg_match_all preg_quote preg_replace preg_replace_callback preg_split contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "pdo") >= 0 && index(g:php_syntax_extensions_disabled, "pdo") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "pdo") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "pdo") < 0)
"                                                                                                   " PDO functions
"                                                                                                   syn keyword phpFunctions pdo_drivers contained
"                                                                                                   " PDO classes and interfaces
"                                                                                                   syn keyword phpClasses PDO PDOException PDORow PDOStatement contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "pgsql") >= 0 && index(g:php_syntax_extensions_disabled, "pgsql") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "pgsql") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "pgsql") < 0)
"                                                                                                   " pgsql functions
"                                                                                                   syn keyword phpFunctions pg_affected_rows pg_cancel_query pg_client_encoding pg_clientencoding pg_close pg_cmdtuples pg_connect pg_connect_poll pg_connection_busy pg_connection_reset pg_connection_status pg_consume_input pg_convert pg_copy_from pg_copy_to pg_dbname pg_delete pg_end_copy pg_errormessage pg_escape_bytea pg_escape_identifier pg_escape_literal pg_escape_string pg_exec pg_execute pg_fetch_all pg_fetch_all_columns pg_fetch_array pg_fetch_assoc pg_fetch_object pg_fetch_result pg_fetch_row pg_field_is_null pg_field_name pg_field_num pg_field_prtlen pg_field_size pg_field_table pg_field_type pg_field_type_oid pg_fieldisnull pg_fieldname pg_fieldnum pg_fieldprtlen pg_fieldsize pg_fieldtype pg_flush pg_free_result pg_freeresult pg_get_notify pg_get_pid pg_get_result pg_getlastoid pg_host pg_insert pg_last_error pg_last_notice pg_last_oid pg_lo_close pg_lo_create pg_lo_export pg_lo_import pg_lo_open pg_lo_read pg_lo_read_all pg_lo_seek pg_lo_tell pg_lo_truncate pg_lo_unlink pg_lo_write pg_loclose pg_locreate pg_loexport pg_loimport pg_loopen pg_loread pg_loreadall pg_lounlink pg_lowrite pg_meta_data pg_num_fields pg_num_rows pg_numfields pg_numrows pg_options pg_parameter_status pg_pconnect pg_ping pg_port pg_prepare pg_put_line pg_query pg_query_params pg_result pg_result_error pg_result_error_field pg_result_seek pg_result_status pg_select pg_send_execute pg_send_prepare pg_send_query pg_send_query_params pg_set_client_encoding pg_set_error_verbosity pg_setclientencoding pg_socket pg_trace pg_transaction_status pg_tty pg_unescape_bytea pg_untrace pg_update pg_version contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "phar") >= 0 && index(g:php_syntax_extensions_disabled, "phar") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "phar") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "phar") < 0)
"                                                                                                   " Phar classes and interfaces
"                                                                                                   syn keyword phpClasses Phar PharData PharException PharFileInfo contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "reflection")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "reflection")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "reflection")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "reflection")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   Reflection
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   Reflection
"                                                                                                   ReflectionClass
"                                                                                                   ReflectionException
"                                                                                                   ReflectionExtension
"                                                                                                   ReflectionFunction
"                                                                                                   ReflectionFunctionAbstract
"                                                                                                   ReflectionMethod
"                                                                                                   ReflectionObject
"                                                                                                   ReflectionParameter
"                                                                                                   ReflectionProperty
"                                                                                                   ReflectionZendExtension
"                                                                                                   Reflector
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "session")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "session")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "session")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "session")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   session
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   session_abort
"                                                                                                   session_cache_expire
"                                                                                                   session_cache_limiter
"                                                                                                   session_commit
"                                                                                                   session_decode
"                                                                                                   session_destroy
"                                                                                                   session_encode
"                                                                                                   session_get_cookie_params
"                                                                                                   session_id
"                                                                                                   session_module_name
"                                                                                                   session_name
"                                                                                                   session_regenerate_id
"                                                                                                   session_register_shutdown
"                                                                                                   session_reset
"                                                                                                   session_save_path
"                                                                                                   session_set_cookie_params
"                                                                                                   session_set_save_handler
"                                                                                                   session_start
"                                                                                                   session_status
"                                                                                                   session_unset
"                                                                                                   session_write_close
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   session
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   SessionHandler
"                                                                                                   SessionHandlerInterface
"                                                                                                   SessionIdInterface
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "simplexml")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "simplexml")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "simplexml")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "simplexml")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   SimpleXML
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   simplexml_import_dom
"                                                                                                   simplexml_load_file
"                                                                                                   simplexml_load_string
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   SimpleXML
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   SimpleXMLElement
"                                                                                                   SimpleXMLIterator
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "soap")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "soap")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "soap")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "soap")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   soap
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   is_soap_fault
"                                                                                                   use_soap_error_handler
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   soap
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   SoapClient
"                                                                                                   SoapFault
"                                                                                                   SoapHeader
"                                                                                                   SoapParam
"                                                                                                   SoapServer
"                                                                                                   SoapVar
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "sockets")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "sockets")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "sockets")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "sockets")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   sockets
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   socket_accept
"                                                                                                   socket_bind
"                                                                                                   socket_clear_error
"                                                                                                   socket_close
"                                                                                                   socket_cmsg_space
"                                                                                                   socket_connect
"                                                                                                   socket_create
"                                                                                                   socket_create_listen
"                                                                                                   socket_create_pair
"                                                                                                   socket_get_option
"                                                                                                   socket_getopt
"                                                                                                   socket_getpeername
"                                                                                                   socket_getsockname
"                                                                                                   socket_import_stream
"                                                                                                   socket_last_error
"                                                                                                   socket_listen
"                                                                                                   socket_read
"                                                                                                   socket_recv
"                                                                                                   socket_recvfrom
"                                                                                                   socket_recvmsg
"                                                                                                   socket_select
"                                                                                                   socket_send
"                                                                                                   socket_sendmsg socket_sendto socket_set_block socket_set_nonblock socket_set_option socket_setopt socket_shutdown socket_strerror socket_write contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "spl") >= 0 && index(g:php_syntax_extensions_disabled, "spl") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "spl") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "spl") < 0)
"                                                                                                   " SPL functions
"                                                                                                   syn keyword phpFunctions class_implements class_parents class_uses iterator_apply iterator_count iterator_to_array spl_autoload spl_autoload_call spl_autoload_extensions spl_autoload_functions spl_autoload_register spl_autoload_unregister spl_classes spl_object_hash contained
"                                                                                                   " SPL classes and interfaces
"                                                                                                   syn keyword phpClasses AppendIterator ArrayIterator ArrayObject BadFunctionCallException BadMethodCallException CachingIterator CallbackFilterIterator Countable DirectoryIterator DomainException EmptyIterator FilesystemIterator FilterIterator GlobIterator InfiniteIterator InvalidArgumentException IteratorIterator LengthException LimitIterator LogicException MultipleIterator NoRewindIterator OutOfBoundsException OutOfRangeException OuterIterator OverflowException ParentIterator RangeException RecursiveArrayIterator RecursiveCachingIterator RecursiveCallbackFilterIterator RecursiveDirectoryIterator RecursiveFilterIterator RecursiveIterator RecursiveIteratorIterator RecursiveRegexIterator RecursiveTreeIterator RegexIterator RuntimeException SeekableIterator SplDoublyLinkedList SplFileInfo SplFileObject SplFixedArray SplHeap SplMaxHeap SplMinHeap SplObjectStorage SplObserver SplPriorityQueue SplQueue SplStack SplSubject SplTempFileObject UnderflowException UnexpectedValueException contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "sqlite3") >= 0 && index(g:php_syntax_extensions_disabled, "sqlite3") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "sqlite3") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "sqlite3") < 0)
"                                                                                                   " sqlite3 classes and interfaces
"                                                                                                   syn keyword phpClasses SQLite3 SQLite3Result SQLite3Stmt contained
"                                                                                                   endif
"                                                                                                   if index(g:php_syntax_extensions_enabled, "standard") >= 0 && index(g:php_syntax_extensions_disabled, "standard") < 0 && ( ! exists("b:php_syntax_extensions_enabled") || index(b:php_syntax_extensions_enabled, "standard") >= 0) && ( ! exists("b:php_syntax_extensions_disabled") || index(b:php_syntax_extensions_disabled, "standard") < 0)
"                                                                                                   " standard functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   abs
"                                                                                                   acos
"                                                                                                   acosh
"                                                                                                   addcslashes
"                                                                                                   addslashes
"                                                                                                   array_change_key_case
"                                                                                                   array_chunk
"                                                                                                   array_column
"                                                                                                   array_combine
"                                                                                                   array_count_values
"                                                                                                   array_diff
"                                                                                                   array_diff_assoc
"                                                                                                   array_diff_key
"                                                                                                   array_diff_uassoc
"                                                                                                   array_diff_ukey
"                                                                                                   array_fill
"                                                                                                   array_fill_keys
"                                                                                                   array_filter
"                                                                                                   array_flip
"                                                                                                   array_intersect
"                                                                                                   array_intersect_assoc
"                                                                                                   array_intersect_key
"                                                                                                   array_intersect_uassoc
"                                                                                                   array_intersect_ukey
"                                                                                                   array_key_exists
"                                                                                                   array_keys
"                                                                                                   array_map
"                                                                                                   array_merge
"                                                                                                   array_merge_recursive
"                                                                                                   array_multisort
"                                                                                                   array_pad
"                                                                                                   array_pop
"                                                                                                   array_product
"                                                                                                   array_push
"                                                                                                   array_rand
"                                                                                                   array_reduce
"                                                                                                   array_replace
"                                                                                                   array_replace_recursive
"                                                                                                   array_reverse
"                                                                                                   array_search
"                                                                                                   array_shift
"                                                                                                   array_slice
"                                                                                                   array_splice
"                                                                                                   array_sum
"                                                                                                   array_udiff
"                                                                                                   array_udiff_assoc
"                                                                                                   array_udiff_uassoc
"                                                                                                   array_uintersect
"                                                                                                   array_uintersect_assoc
"                                                                                                   array_uintersect_uassoc
"                                                                                                   array_unique
"                                                                                                   array_unshift
"                                                                                                   array_values
"                                                                                                   array_walk
"                                                                                                   array_walk_recursive
"                                                                                                   arsort
"                                                                                                   asin
"                                                                                                   asinh
"                                                                                                   asort
"                                                                                                   assert
"                                                                                                   assert_options
"                                                                                                   atan
"                                                                                                   atan2
"                                                                                                   atanh
"                                                                                                   base64_decode
"                                                                                                   base64_encode
"                                                                                                   base_convert
"                                                                                                   basename
"                                                                                                   bin2hex
"                                                                                                   bindec
"                                                                                                   boolval
"                                                                                                   call_user_func
"                                                                                                   call_user_func_array
"                                                                                                   call_user_method
"                                                                                                   call_user_method_array
"                                                                                                   ceil
"                                                                                                   chdir
"                                                                                                   checkdnsrr
"                                                                                                   chgrp
"                                                                                                   chmod
"                                                                                                   chop
"                                                                                                   chown
"                                                                                                   chr
"                                                                                                   chroot
"                                                                                                   chunk_split
"                                                                                                   clearstatcache
"                                                                                                   cli_get_process_title
"                                                                                                   cli_set_process_title
"                                                                                                   closedir
"                                                                                                   closelog
"                                                                                                   compact
"                                                                                                   connection_aborted
"                                                                                                   connection_status
"                                                                                                   constant
"                                                                                                   convert_cyr_string
"                                                                                                   convert_uudecode
"                                                                                                   convert_uuencode
"                                                                                                   copy
"                                                                                                   cos
"                                                                                                   cosh
"                                                                                                   count
"                                                                                                   count_chars
"                                                                                                   crc32
"                                                                                                   crypt
"                                                                                                   current
"                                                                                                   debug_zval_dump
"                                                                                                   decbin
"                                                                                                   dechex
"                                                                                                   decoct
"                                                                                                   deg2rad
"                                                                                                   dir
"                                                                                                   dirname
"                                                                                                   disk_free_space
"                                                                                                   disk_total_space
"                                                                                                   diskfreespace
"                                                                                                   dl
"                                                                                                   dns_check_record
"                                                                                                   dns_get_mx
"                                                                                                   dns_get_record
"                                                                                                   doubleval
"                                                                                                   end
"                                                                                                   error_get_last
"                                                                                                   error_log
"                                                                                                   escapeshellarg
"                                                                                                   escapeshellcmd
"                                                                                                   exec
"                                                                                                   exp
"                                                                                                   explode
"                                                                                                   expm1
"                                                                                                   extract
"                                                                                                   ezmlm_hash
"                                                                                                   fclose
"                                                                                                   feof
"                                                                                                   fflush
"                                                                                                   fgetc
"                                                                                                   fgetcsv
"                                                                                                   fgets
"                                                                                                   fgetss
"                                                                                                   file
"                                                                                                   file_exists
"                                                                                                   file_get_contents
"                                                                                                   file_put_contents
"                                                                                                   fileatime
"                                                                                                   filectime
"                                                                                                   filegroup
"                                                                                                   fileinode
"                                                                                                   filemtime
"                                                                                                   fileowner
"                                                                                                   fileperms
"                                                                                                   filesize
"                                                                                                   filetype
"                                                                                                   floatval
"                                                                                                   flock
"                                                                                                   floor
"                                                                                                   flush
"                                                                                                   fmod
"                                                                                                   fnmatch
"                                                                                                   fopen
"                                                                                                   forward_static_call
"                                                                                                   forward_static_call_array
"                                                                                                   fpassthru
"                                                                                                   fprintf
"                                                                                                   fputcsv
"                                                                                                   fputs
"                                                                                                   fread
"                                                                                                   fscanf
"                                                                                                   fseek
"                                                                                                   fsockopen
"                                                                                                   fstat
"                                                                                                   ftell
"                                                                                                   ftok
"                                                                                                   ftruncate
"                                                                                                   fwrite
"                                                                                                   get_browser
"                                                                                                   get_cfg_var
"                                                                                                   get_current_user
"                                                                                                   get_headers
"                                                                                                   get_html_translation_table
"                                                                                                   get_include_path
"                                                                                                   get_magic_quotes_gpc
"                                                                                                   get_magic_quotes_runtime
"                                                                                                   get_meta_tags
"                                                                                                   getcwd
"                                                                                                   getenv
"                                                                                                   gethostbyaddr
"                                                                                                   gethostbyname
"                                                                                                   gethostbynamel
"                                                                                                   gethostname
"                                                                                                   getimagesize
"                                                                                                   getimagesizefromstring
"                                                                                                   getlastmod
"                                                                                                   getmxrr
"                                                                                                   getmygid
"                                                                                                   getmyinode
"                                                                                                   getmypid
"                                                                                                   getmyuid
"                                                                                                   getopt
"                                                                                                   getprotobyname
"                                                                                                   getprotobynumber
"                                                                                                   getrandmax
"                                                                                                   getrusage
"                                                                                                   getservbyname
"                                                                                                   getservbyport
"                                                                                                   gettimeofday
"                                                                                                   gettype
"                                                                                                   glob
"                                                                                                   header
"                                                                                                   header_register_callback
"                                                                                                   header_remove
"                                                                                                   headers_list
"                                                                                                   headers_sent
"                                                                                                   hebrev
"                                                                                                   hebrevc
"                                                                                                   hex2bin
"                                                                                                   hexdec
"                                                                                                   highlight_file
"                                                                                                   highlight_string
"                                                                                                   html_entity_decode
"                                                                                                   htmlentities
"                                                                                                   htmlspecialchars
"                                                                                                   htmlspecialchars_decode
"                                                                                                   http_build_query
"                                                                                                   http_response_code
"                                                                                                   hypot
"                                                                                                   ignore_user_abort
"                                                                                                   image_type_to_extension
"                                                                                                   image_type_to_mime_type
"                                                                                                   implode
"                                                                                                   in_array
"                                                                                                   inet_ntop
"                                                                                                   inet_pton
"                                                                                                   ini_alter
"                                                                                                   ini_get
"                                                                                                   ini_get_all
"                                                                                                   ini_restore
"                                                                                                   ini_set
"                                                                                                   intval
"                                                                                                   ip2long
"                                                                                                   iptcembed
"                                                                                                   iptcparse
"                                                                                                   is_array
"                                                                                                   is_bool
"                                                                                                   is_callable
"                                                                                                   is_dir
"                                                                                                   is_double
"                                                                                                   is_executable
"                                                                                                   is_file
"                                                                                                   is_finite
"                                                                                                   is_float
"                                                                                                   is_infinite
"                                                                                                   is_int
"                                                                                                   is_integer
"                                                                                                   is_link
"                                                                                                   is_long
"                                                                                                   is_nan
"                                                                                                   is_null
"                                                                                                   is_numeric
"                                                                                                   is_object
"                                                                                                   is_readable
"                                                                                                   is_real
"                                                                                                   is_resource
"                                                                                                   is_scalar
"                                                                                                   is_string
"                                                                                                   is_uploaded_file
"                                                                                                   is_writable
"                                                                                                   is_writeable
"                                                                                                   join
"                                                                                                   key
"                                                                                                   key_exists
"                                                                                                   krsort
"                                                                                                   ksort
"                                                                                                   lcfirst
"                                                                                                   lcg_value
"                                                                                                   lchgrp
"                                                                                                   lchown
"                                                                                                   levenshtein
"                                                                                                   link
"                                                                                                   linkinfo
"                                                                                                   localeconv
"                                                                                                   log
"                                                                                                   log1p
"                                                                                                   log10
"                                                                                                   long2ip
"                                                                                                   lstat
"                                                                                                   ltrim
"                                                                                                   magic_quotes_runtime
"                                                                                                   mail
"                                                                                                   max
"                                                                                                   md5
"                                                                                                   md5_file
"                                                                                                   memory_get_peak_usage
"                                                                                                   memory_get_usage
"                                                                                                   metaphone
"                                                                                                   microtime
"                                                                                                   min
"                                                                                                   mkdir
"                                                                                                   money_format
"                                                                                                   move_uploaded_file
"                                                                                                   mt_getrandmax
"                                                                                                   mt_rand
"                                                                                                   mt_srand
"                                                                                                   natcasesort
"                                                                                                   natsort
"                                                                                                   next
"                                                                                                   nl2br
"                                                                                                   nl_langinfo
"                                                                                                   number_format
"                                                                                                   ob_clean
"                                                                                                   ob_end_clean
"                                                                                                   ob_end_flush
"                                                                                                   ob_flush
"                                                                                                   ob_get_clean
"                                                                                                   ob_get_contents
"                                                                                                   ob_get_flush
"                                                                                                   ob_get_length
"                                                                                                   ob_get_level
"                                                                                                   ob_get_status
"                                                                                                   ob_implicit_flush
"                                                                                                   ob_list_handlers
"                                                                                                   ob_start
"                                                                                                   octdec
"                                                                                                   opendir
"                                                                                                   openlog
"                                                                                                   ord
"                                                                                                   output_add_rewrite_var
"                                                                                                   output_reset_rewrite_vars
"                                                                                                   pack
"                                                                                                   parse_ini_file
"                                                                                                   parse_ini_string
"                                                                                                   parse_str
"                                                                                                   parse_url
"                                                                                                   passthru
"                                                                                                   password_get_info
"                                                                                                   password_hash
"                                                                                                   password_needs_rehash
"                                                                                                   password_verify
"                                                                                                   pathinfo
"                                                                                                   pclose
"                                                                                                   pfsockopen
"                                                                                                   php_ini_loaded_file
"                                                                                                   php_ini_scanned_files
"                                                                                                   php_sapi_name
"                                                                                                   php_strip_whitespace
"                                                                                                   php_uname
"                                                                                                   phpcredits
"                                                                                                   phpinfo
"                                                                                                   phpversion
"                                                                                                   pi
"                                                                                                   popen
"                                                                                                   pos
"                                                                                                   pow
"                                                                                                   prev
"                                                                                                   print_r
"                                                                                                   printf
"                                                                                                   proc_close
"                                                                                                   proc_get_status
"                                                                                                   proc_nice
"                                                                                                   proc_open
"                                                                                                   proc_terminate
"                                                                                                   putenv
"                                                                                                   quoted_printable_decode
"                                                                                                   quoted_printable_encode
"                                                                                                   quotemeta
"                                                                                                   rad2deg
"                                                                                                   rand
"                                                                                                   range
"                                                                                                   rawurldecode
"                                                                                                   rawurlencode
"                                                                                                   readdir
"                                                                                                   readfile
"                                                                                                   readlink
"                                                                                                   realpath
"                                                                                                   realpath_cache_get
"                                                                                                   realpath_cache_size
"                                                                                                   register_shutdown_function
"                                                                                                   register_tick_function
"                                                                                                   rename
"                                                                                                   reset
"                                                                                                   restore_include_path
"                                                                                                   rewind
"                                                                                                   rewinddir
"                                                                                                   rmdir
"                                                                                                   round
"                                                                                                   rsort
"                                                                                                   rtrim
"                                                                                                   scandir
"                                                                                                   serialize
"                                                                                                   set_file_buffer
"                                                                                                   set_include_path
"                                                                                                   set_magic_quotes_runtime
"                                                                                                   set_socket_blocking
"                                                                                                   set_time_limit
"                                                                                                   setcookie
"                                                                                                   setlocale
"                                                                                                   setrawcookie
"                                                                                                   settype
"                                                                                                   sha1
"                                                                                                   sha1_file
"                                                                                                   shell_exec
"                                                                                                   show_source
"                                                                                                   shuffle
"                                                                                                   similar_text
"                                                                                                   sin
"                                                                                                   sinh
"                                                                                                   sizeof
"                                                                                                   sleep
"                                                                                                   socket_get_status
"                                                                                                   socket_set_blocking
"                                                                                                   socket_set_timeout
"                                                                                                   sort
"                                                                                                   soundex
"                                                                                                   sprintf
"                                                                                                   sqrt
"                                                                                                   srand
"                                                                                                   sscanf
"                                                                                                   stat
"                                                                                                   str_getcsv
"                                                                                                   str_ireplace
"                                                                                                   str_pad
"                                                                                                   str_repeat
"                                                                                                   str_replace
"                                                                                                   str_rot13
"                                                                                                   str_shuffle
"                                                                                                   str_split
"                                                                                                   str_word_count
"                                                                                                   strchr
"                                                                                                   strcoll
"                                                                                                   strcspn
"                                                                                                   stream_bucket_append
"                                                                                                   stream_bucket_make_writeable
"                                                                                                   stream_bucket_new
"                                                                                                   stream_bucket_prepend
"                                                                                                   stream_context_create
"                                                                                                   stream_context_get_default
"                                                                                                   stream_context_get_options
"                                                                                                   stream_context_get_params
"                                                                                                   stream_context_set_default
"                                                                                                   stream_context_set_option
"                                                                                                   stream_context_set_params
"                                                                                                   stream_copy_to_stream
"                                                                                                   stream_filter_append
"                                                                                                   stream_filter_prepend
"                                                                                                   stream_filter_register
"                                                                                                   stream_filter_remove
"                                                                                                   stream_get_contents
"                                                                                                   stream_get_filters
"                                                                                                   stream_get_line
"                                                                                                   stream_get_meta_data
"                                                                                                   stream_get_transports
"                                                                                                   stream_get_wrappers
"                                                                                                   stream_is_local
"                                                                                                   stream_register_wrapper
"                                                                                                   stream_resolve_include_path
"                                                                                                   stream_select
"                                                                                                   stream_set_blocking
"                                                                                                   stream_set_chunk_size
"                                                                                                   stream_set_read_buffer
"                                                                                                   stream_set_timeout
"                                                                                                   stream_set_write_buffer
"                                                                                                   stream_socket_accept
"                                                                                                   stream_socket_client
"                                                                                                   stream_socket_enable_crypto
"                                                                                                   stream_socket_get_name
"                                                                                                   stream_socket_pair
"                                                                                                   stream_socket_recvfrom
"                                                                                                   stream_socket_sendto
"                                                                                                   stream_socket_server
"                                                                                                   stream_socket_shutdown
"                                                                                                   stream_supports_lock
"                                                                                                   stream_wrapper_register
"                                                                                                   stream_wrapper_restore
"                                                                                                   stream_wrapper_unregister
"                                                                                                   strip_tags
"                                                                                                   stripcslashes
"                                                                                                   stripos
"                                                                                                   stripslashes
"                                                                                                   stristr
"                                                                                                   strnatcasecmp
"                                                                                                   strnatcmp
"                                                                                                   strpbrk
"                                                                                                   strpos
"                                                                                                   strptime
"                                                                                                   strrchr
"                                                                                                   strrev
"                                                                                                   strripos
"                                                                                                   strrpos
"                                                                                                   strspn
"                                                                                                   strstr
"                                                                                                   strtok
"                                                                                                   strtolower
"                                                                                                   strtoupper
"                                                                                                   strtr
"                                                                                                   strval
"                                                                                                   substr
"                                                                                                   substr_compare
"                                                                                                   substr_count
"                                                                                                   substr_replace
"                                                                                                   symlink
"                                                                                                   sys_get_temp_dir
"                                                                                                   sys_getloadavg
"                                                                                                   syslog
"                                                                                                   system
"                                                                                                   tan
"                                                                                                   tanh
"                                                                                                   tempnam
"                                                                                                   time_nanosleep
"                                                                                                   time_sleep_until
"                                                                                                   tmpfile
"                                                                                                   touch
"                                                                                                   trim
"                                                                                                   uasort
"                                                                                                   ucfirst
"                                                                                                   ucwords
"                                                                                                   uksort
"                                                                                                   umask
"                                                                                                   uniqid
"                                                                                                   unlink
"                                                                                                   unpack
"                                                                                                   unregister_tick_function
"                                                                                                   unserialize
"                                                                                                   urldecode
"                                                                                                   urlencode
"                                                                                                   usleep
"                                                                                                   usort
"                                                                                                   var_dump
"                                                                                                   var_export
"                                                                                                   version_compare
"                                                                                                   vfprintf
"                                                                                                   vprintf
"                                                                                                   vsprintf
"                                                                                                   wordwrap
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   standard
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   Directory
"                                                                                                   __PHP_Incomplete_Class
"                                                                                                   php_user_filter
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "tokenizer")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "tokenizer")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "tokenizer")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "tokenizer")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   tokenizer
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   token_get_all
"                                                                                                   token_name
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "wddx")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "wddx")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "wddx")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "wddx")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   wddx
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   wddx_add_vars
"                                                                                                   wddx_deserialize
"                                                                                                   wddx_packet_end
"                                                                                                   wddx_packet_start
"                                                                                                   wddx_serialize_value
"                                                                                                   wddx_serialize_vars
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "xml")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "xml")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "xml")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "xml")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   xml
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   utf8_decode
"                                                                                                   utf8_encode
"                                                                                                   xml_error_string
"                                                                                                   xml_get_current_byte_index
"                                                                                                   xml_get_current_column_number
"                                                                                                   xml_get_current_line_number
"                                                                                                   xml_get_error_code
"                                                                                                   xml_parse
"                                                                                                   xml_parse_into_struct
"                                                                                                   xml_parser_create
"                                                                                                   xml_parser_create_ns
"                                                                                                   xml_parser_free
"                                                                                                   xml_parser_get_option
"                                                                                                   xml_parser_set_option
"                                                                                                   xml_set_character_data_handler
"                                                                                                   xml_set_default_handler
"                                                                                                   xml_set_element_handler
"                                                                                                   xml_set_end_namespace_decl_handler
"                                                                                                   xml_set_external_entity_ref_handler
"                                                                                                   xml_set_notation_decl_handler
"                                                                                                   xml_set_object
"                                                                                                   xml_set_processing_instruction_handler
"                                                                                                   xml_set_start_namespace_decl_handler
"                                                                                                   xml_set_unparsed_entity_decl_handler
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "xmlreader")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "xmlreader")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "xmlreader")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "xmlreader")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   xmlreader
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   XMLReader
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "xmlwriter")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "xmlwriter")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "xmlwriter")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "xmlwriter")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   xmlwriter
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   xmlwriter_end_attribute
"                                                                                                   xmlwriter_end_cdata
"                                                                                                   xmlwriter_end_comment
"                                                                                                   xmlwriter_end_document
"                                                                                                   xmlwriter_end_dtd
"                                                                                                   xmlwriter_end_dtd_attlist
"                                                                                                   xmlwriter_end_dtd_element
"                                                                                                   xmlwriter_end_dtd_entity
"                                                                                                   xmlwriter_end_element
"                                                                                                   xmlwriter_end_pi
"                                                                                                   xmlwriter_flush
"                                                                                                   xmlwriter_full_end_element
"                                                                                                   xmlwriter_open_memory
"                                                                                                   xmlwriter_open_uri
"                                                                                                   xmlwriter_output_memory
"                                                                                                   xmlwriter_set_indent
"                                                                                                   xmlwriter_set_indent_string
"                                                                                                   xmlwriter_start_attribute
"                                                                                                   xmlwriter_start_attribute_ns
"                                                                                                   xmlwriter_start_cdata
"                                                                                                   xmlwriter_start_comment
"                                                                                                   xmlwriter_start_document
"                                                                                                   xmlwriter_start_dtd
"                                                                                                   xmlwriter_start_dtd_attlist
"                                                                                                   xmlwriter_start_dtd_element
"                                                                                                   xmlwriter_start_dtd_entity
"                                                                                                   xmlwriter_start_element
"                                                                                                   xmlwriter_start_element_ns
"                                                                                                   xmlwriter_start_pi
"                                                                                                   xmlwriter_text
"                                                                                                   xmlwriter_write_attribute
"                                                                                                   xmlwriter_write_attribute_ns
"                                                                                                   xmlwriter_write_cdata
"                                                                                                   xmlwriter_write_comment
"                                                                                                   xmlwriter_write_dtd
"                                                                                                   xmlwriter_write_dtd_attlist
"                                                                                                   xmlwriter_write_dtd_element
"                                                                                                   xmlwriter_write_dtd_entity
"                                                                                                   xmlwriter_write_element
"                                                                                                   xmlwriter_write_element_ns
"                                                                                                   xmlwriter_write_pi
"                                                                                                   xmlwriter_write_raw
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   xmlwriter
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   XMLWriter
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "zip")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "zip")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "zip")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "zip")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   zip
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   zip_close
"                                                                                                   zip_entry_close
"                                                                                                   zip_entry_compressedsize
"                                                                                                   zip_entry_compressionmethod
"                                                                                                   zip_entry_filesize
"                                                                                                   zip_entry_name
"                                                                                                   zip_entry_open
"                                                                                                   zip_entry_read
"                                                                                                   zip_open
"                                                                                                   zip_read
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   zip
"                                                                                                   classes
"                                                                                                   and
"                                                                                                   interfaces
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   ZipArchive
"                                                                                                   contained
"                                                                                                   endif
"                                                                                                   if
"                                                                                                   index(g:php_syntax_extensions_enabled,
"                                                                                                   "zlib")
"                                                                                                   >=
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   index(g:php_syntax_extensions_disabled,
"                                                                                                   "zlib")
"                                                                                                   <
"                                                                                                   0
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_enabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_enabled,
"                                                                                                   "zlib")
"                                                                                                   >=
"                                                                                                   0)
"                                                                                                   &&
"                                                                                                   (
"                                                                                                   !
"                                                                                                   exists("b:php_syntax_extensions_disabled")
"                                                                                                   ||
"                                                                                                   index(b:php_syntax_extensions_disabled,
"                                                                                                   "zlib")
"                                                                                                   <
"                                                                                                   0)
"                                                                                                   "
"                                                                                                   zlib
"                                                                                                   functions
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpFunctions
"                                                                                                   gzclose
"                                                                                                   gzcompress
"                                                                                                   gzdecode
"                                                                                                   gzdeflate
"                                                                                                   gzencode
"                                                                                                   gzeof
"                                                                                                   gzfile
"                                                                                                   gzgetc
"                                                                                                   gzgets
"                                                                                                   gzgetss
"                                                                                                   gzinflate
"                                                                                                   gzopen
"                                                                                                   gzpassthru
"                                                                                                   gzputs
"                                                                                                   gzread
"                                                                                                   gzrewind
"                                                                                                   gzseek
"                                                                                                   gztell
"                                                                                                   gzuncompress
"                                                                                                   gzwrite
"                                                                                                   ob_gzhandler
"                                                                                                   readgzfile
"                                                                                                   zlib_decode
"                                                                                                   zlib_encode
"                                                                                                   zlib_get_coding_type
"                                                                                                   contained
"                                                                                                   endif
"
"                                                                                                   "
"                                                                                                   }}}
"
"                                                                                                   "
"                                                                                                   The
"                                                                                                   following
"                                                                                                   is
"                                                                                                   needed
"                                                                                                   afterall
"                                                                                                   it
"                                                                                                   seems.
"                                                                                                   syntax
"                                                                                                   keyword
"                                                                                                   phpClasses
"                                                                                                   containedin=ALLBUT,phpComment,phpDocComment,phpStringDouble,phpStringSingle,phpIdentifier,phpMethodsVar
"
"                                                                                                   "
"                                                                                                   Control
"                                                                                                   Structures
"                                                                                                   syn
"                                                                                                   keyword
"                                                                                                   phpKeyword
"                                                                                                   echo
"                                                                                                   continue
"                                                                                                   case
"                                                                                                   default
"                                                                                                   break
"                                                                                                   return
"                                                                                                   goto
"                                                                                                   as
"                                                                                                   endif
"                                                                                                   endwhile
"                                                                                                   endfor
"                                                                                                   endforeach
"                                                                                                   endswitch
"                                                                                                   declare
"                                                                                                   endeclare
"                                                                                                   print
"                                                                                                   new
"                                                                                                   clone
"                                                                                                   yield
"                                                                                                   contained
"                                                                                                   "
"                                                                                                   Only
"                                                                                                   create
"                                                                                                   keyword
"                                                                                                   groupings
"                                                                                                   for
"                                                                                                   these
"                                                                                                   if
"                                                                                                   not
"                                                                                                   doing
"                                                                                                   folding,
"                                                                                                   otherwise
"                                                                                                   they
"                                                                                                   take
"                                                                                                   precedence
"                                                                                                   over
"                                                                                                   the
"                                                                                                   regions
"                                                                                                   "
"                                                                                                   used
"                                                                                                   for
"                                                                                                   folding.
"                                                                                                   if
"                                                                                                   php_folding
"                                                                                                   !=
"                                                                                                   1
"                                                                                                     syn
"                                                                                                     keyword
"                                                                                                     phpKeyword
"                                                                                                     if
"                                                                                                     else
"                                                                                                     elseif
"                                                                                                     while
"                                                                                                     do
"                                                                                                     for
"                                                                                                     foreach
"                                                                                                     function
"                                                                                                     switch
"                                                                                                     contained
"
"                                                                                                       "
"                                                                                                       Exception
"                                                                                                       Keywords
"                                                                                                         syn
"                                                                                                         keyword
"                                                                                                         phpKeyword
"                                                                                                         try
"                                                                                                         catch
"                                                                                                         finally
"                                                                                                         throw
"                                                                                                         contained
"                                                                                                         endif
"
"                                                                                                         "
"                                                                                                         Class
"                                                                                                         Keywords
"                                                                                                         syn
"                                                                                                         keyword
"                                                                                                         phpType
"                                                                                                         class
"                                                                                                         abstract
"                                                                                                         extends
"                                                                                                         interface
"                                                                                                         implements
"                                                                                                         static
"                                                                                                         final
"                                                                                                         var
"                                                                                                         public
"                                                                                                         private
"                                                                                                         protected
"                                                                                                         const
"                                                                                                         trait
"                                                                                                         contained
"
"                                                                                                         "
"                                                                                                         Magic
"                                                                                                         Methods
"                                                                                                         syn
"                                                                                                         keyword
"                                                                                                         phpStatement
"                                                                                                         __construct
"                                                                                                         __destruct
"                                                                                                         __call
"                                                                                                         __callStatic
"                                                                                                         __get
"                                                                                                         __set
"                                                                                                         __isset
"                                                                                                         __unset
"                                                                                                         __sleep
"                                                                                                         __wakeup
"                                                                                                         __toString
"                                                                                                         __invoke
"                                                                                                         __set_state
"                                                                                                         __clone
"                                                                                                         contained
"
"                                                                                                         "
"                                                                                                         Language
"                                                                                                         Constructs
"                                                                                                         syn
"                                                                                                         keyword
"                                                                                                         phpKeyword
"                                                                                                         die
"                                                                                                         exit
"                                                                                                         eval
"                                                                                                         empty
"                                                                                                         isset
"                                                                                                         unset
"                                                                                                         list
"                                                                                                         instanceof
"                                                                                                         insteadof
"                                                                                                         contained
"
"                                                                                                         "
"                                                                                                         Include
"                                                                                                         &
"                                                                                                         friends
"                                                                                                         syn
"                                                                                                         keyword
"                                                                                                         phpInclude
"                                                                                                         include
"                                                                                                         include_once
"                                                                                                         require
"                                                                                                         require_once
"                                                                                                         namespace
"                                                                                                         use
"                                                                                                         contained
"
"                                                                                                         "
"                                                                                                         Types
"                                                                                                         syn
"                                                                                                         keyword
"                                                                                                         phpType
"                                                                                                         bool[ean]
"                                                                                                         int[eger]
"                                                                                                         real
"                                                                                                         double
"                                                                                                         float
"                                                                                                         string
"                                                                                                         array
"                                                                                                         object
"                                                                                                         null
"                                                                                                         self
"                                                                                                         parent
"                                                                                                         global
"                                                                                                         this
"                                                                                                         stdClass
"                                                                                                         callable
"                                                                                                         contained
"
"                                                                                                         "
"                                                                                                         Operator
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "[-=+%^&|*!.~?:]"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "[-+*/%^&|.]="
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "/[^*/]"me=e-1
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "\$"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "&&\|\<and\>"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "||\|\<x\=or\>"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "[!=<>]="
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOperator
"                                                                                                         "[<>]"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpMemberSelector
"                                                                                                         "->\|::"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpVarSelector
"                                                                                                         "\$"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         "
"                                                                                                         highlight
"                                                                                                         static
"                                                                                                         and
"                                                                                                         object
"                                                                                                         variables
"                                                                                                         inside
"                                                                                                         strings
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpMethodsVar
"                                                                                                         "\%(->\|::$\?\)\h\w*"
"                                                                                                         contained
"                                                                                                         contains=phpMethods,phpMemberSelector,phpIdentifier
"                                                                                                         display
"                                                                                                         containedin=phpStringDouble
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSplatOperator
"                                                                                                         "\.\.\."
"                                                                                                         contained
"                                                                                                         display
"
"                                                                                                         "
"                                                                                                         Identifier
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpIdentifier
"                                                                                                         "$\h\w*"
"                                                                                                         contained
"                                                                                                         contains=phpSuperglobals,phpVarSelector
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpIdentifierSimply
"                                                                                                         "${\h\w*}"
"                                                                                                         contains=phpOperator,phpParent
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         region
"                                                                                                         phpIdentifierComplex
"                                                                                                         matchgroup=phpParent
"                                                                                                         start="{\$"rs=e-1
"                                                                                                         end="}"
"                                                                                                         contains=phpIdentifier,phpMemberSelector,phpVarSelector,phpIdentifierArray
"                                                                                                         contained
"                                                                                                         extend
"                                                                                                         syn
"                                                                                                         region
"                                                                                                         phpIdentifierArray
"                                                                                                         matchgroup=phpParent
"                                                                                                         start="\["
"                                                                                                         end="]"
"                                                                                                         contains=@phpClInside
"                                                                                                         contained
"
"                                                                                                         "
"                                                                                                         Boolean
"                                                                                                         syn
"                                                                                                         keyword
"                                                                                                         phpBoolean
"                                                                                                         true
"                                                                                                         false
"                                                                                                         contained
"
"                                                                                                         "
"                                                                                                         Number
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpNumber
"                                                                                                         "-\=\<\d\+\>"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpNumber
"                                                                                                         "\<0x\x\{1,8}\>"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpNumber
"                                                                                                         "\<0b[01]\+\>"
"                                                                                                         contained
"                                                                                                         display
"
"                                                                                                         "
"                                                                                                         Float
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpNumber
"                                                                                                         "\(-\=\<\d+\|-\=\)\.\d\+\>"
"                                                                                                         contained
"                                                                                                         display
"
"                                                                                                         "
"                                                                                                         SpecialChar
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSpecialChar
"                                                                                                         "\\[fnrtv\\]"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSpecialChar
"                                                                                                         "\\\d\{3}"
"                                                                                                         contained
"                                                                                                         contains=phpOctalError
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSpecialChar
"                                                                                                         "\\x\x\{2}"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         "
"                                                                                                         corrected
"                                                                                                         highlighting
"                                                                                                         for
"                                                                                                         an
"                                                                                                         escaped
"                                                                                                         '\$'
"                                                                                                         inside
"                                                                                                         a
"                                                                                                         double-quoted
"                                                                                                         string
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSpecialChar
"                                                                                                         "\\\$"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSpecialChar
"                                                                                                         +\\"+
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpStrEsc
"                                                                                                         "\\\\"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpStrEsc
"                                                                                                         "\\'"
"                                                                                                         contained
"                                                                                                         display
"
"                                                                                                         "
"                                                                                                         Format
"                                                                                                         specifiers
"                                                                                                         (printf)
"                                                                                                         "
"                                                                                                         See
"                                                                                                         https://github.com/aantonello/php.vim/commit/9d24eab4ea4b3752a54aebf14d3491b6d8edb6d8
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSpecialChar
"                                                                                                         display
"                                                                                                         contained
"                                                                                                         /%\(\d\+\$\)\=[-+'
"                                                                                                         #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([aAbBdiouxXDOUfFeEgGcCsSpnmMyYhH]\|\[\^\=.[^]]*\]\)/
"                                                                                                         containedin=phpStringSingle,phpStringDouble,phpHereDoc
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpSpecialChar
"                                                                                                         display
"                                                                                                         contained
"                                                                                                         /%%/
"                                                                                                         containedin=phpStringSingle,phpStringDouble,phpHereDoc
"
"                                                                                                         "
"                                                                                                         Error
"                                                                                                         syn
"                                                                                                         match
"                                                                                                         phpOctalError
"                                                                                                         "[89]"
"                                                                                                         contained
"                                                                                                         display
"                                                                                                         if
"                                                                                                         (exists("php_parent_error_close")
"                                                                                                         &&
"                                                                                                         php_parent_error_close)
"                                                                                                           syn
"                                                                                                           match
"                                                                                                           phpParentError
"                                                                                                           "[)\]}]"
"                                                                                                           contained
"                                                                                                           display
"                                                                                                           endif
"
"                                                                                                           "
"                                                                                                           Todo
"                                                                                                           syn
"                                                                                                           case
"                                                                                                           match
"                                                                                                           syn
"                                                                                                           keyword
"                                                                                                           phpTodo
"                                                                                                           TODO
"                                                                                                           FIXME
"                                                                                                           XXX
"                                                                                                           NOTE
"                                                                                                           contained
"                                                                                                           syn
"                                                                                                           case
"                                                                                                           ignore
"
"                                                                                                           "
"                                                                                                           Comment
"                                                                                                           if
"                                                                                                           (exists("php_parent_error_open")
"                                                                                                           &&
"                                                                                                           php_parent_error_open)
"                                                                                                             syn
"                                                                                                             region
"                                                                                                             phpComment
"                                                                                                             start="/\*"
"                                                                                                             end="\*/"
"                                                                                                             contained
"                                                                                                             contains=phpTodo,@Spell
"                                                                                                             else
"                                                                                                               syn
"                                                                                                               region
"                                                                                                               phpComment
"                                                                                                               start="/\*"
"                                                                                                               end="\*/"
"                                                                                                               contained
"                                                                                                               contains=phpTodo,@Spell
"                                                                                                               extend
"                                                                                                               endif
"
"                                                                                                               syn
"                                                                                                               match
"                                                                                                               phpCommentStar
"                                                                                                               contained
"                                                                                                               "^\s*\*[^/]"me=e-1
"                                                                                                               syn
"                                                                                                               match
"                                                                                                               phpCommentStar
"                                                                                                               contained
"                                                                                                               "^\s*\*$"
"
"                                                                                                               if
"                                                                                                               !exists("php_ignore_phpdoc")
"                                                                                                               ||
"                                                                                                               !php_ignore_phpdoc
"                                                                                                                 syn
"                                                                                                                 case
"                                                                                                                 ignore
"
"                                                                                                                   SynFoldDoc
"                                                                                                                   syn
"                                                                                                                   region
"                                                                                                                   phpDocComment
"                                                                                                                   start="/\*\*"
"                                                                                                                   end="\*/"
"                                                                                                                   keepend
"                                                                                                                   contains=phpCommentTitle,phpDocTags,phpTodo,@Spell
"                                                                                                                     syn
"                                                                                                                     region
"                                                                                                                     phpCommentTitle
"                                                                                                                     contained
"                                                                                                                     matchgroup=phpDocComment
"                                                                                                                     start="/\*\*"
"                                                                                                                     matchgroup=phpCommmentTitle
"                                                                                                                     keepend
"                                                                                                                     end="\.$"
"                                                                                                                     end="\.[
"                                                                                                                     \t\r<&]"me=e-1
"                                                                                                                     end="[^{]@"me=s-2,he=s-1
"                                                                                                                     end="\*/"me=s-1,he=s-1
"                                                                                                                     contains=phpCommentStar,phpTodo,phpDocTags,@Spell
"                                                                                                                     containedin=phpDocComment
"
"                                                                                                                       syn
"                                                                                                                       region
"                                                                                                                       phpDocTags
"                                                                                                                       start="{@\(example\|id\|internal\|inheritdoc\|link\|source\|toc\|tutorial\)"
"                                                                                                                       end="}"
"                                                                                                                       containedin=phpDocComment
"                                                                                                                         syn
"                                                                                                                         match
"                                                                                                                         phpDocTags
"                                                                                                                         "@\%(abstract\|access\|api\|author\|brief\|bug\|category\|class\|copyright\|created\|date\|deprecated\|details\|example\|exception\|file\|filesource\|final\|global\|id\|ignore\|inheritdoc\|internal\|license\|link\|magic\|method\|name\|package\|param\|property\|return\|see\|since\|source\|static\|staticvar\|struct\|subpackage\|throws\|toc\|todo\|tutorial\|type\|uses\|var\|version\|warning\)" containedin=phpDocComment nextgroup=phpDocParam,phpDocIdentifier skipwhite
"                                                                                                                           syn match phpDocParam "\s\+\zs\%(\h\w*|\?\)\+" nextgroup=phpDocIdentifier skipwhite
"                                                                                                                             syn match phpDocIdentifier "\s\+\zs$\h\w*"
"
"                                                                                                                               syn case match
"                                                                                                                               endif
"
"                                                                                                                               if version >= 600
"                                                                                                                                 syn match phpComment  "#.\{-}\(?>\|$\)\@="  contained contains=phpTodo,@Spell
"                                                                                                                                   syn match phpComment  "//.\{-}\(?>\|$\)\@=" contained contains=phpTodo,@Spell
"                                                                                                                                   else
"                                                                                                                                     syn match phpComment  "#.\{-}$" contained contains=phpTodo,@Spell
"                                                                                                                                       syn match phpComment  "#.\{-}?>"me=e-2  contained contains=phpTodo,@Spell
"                                                                                                                                         syn match phpComment  "//.\{-}$"  contained contains=phpTodo,@Spell
"                                                                                                                                           syn match phpComment  "//.\{-}?>"me=e-2 contained contains=phpTodo,@Spell
"                                                                                                                                           endif
"
"                                                                                                                                           " String
"                                                                                                                                           if (exists("php_parent_error_open") && php_parent_error_open)
"                                                                                                                                             syn region phpStringDouble matchgroup=phpStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=@Spell,@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpStrEsc contained keepend
"                                                                                                                                               syn region phpBacktick matchgroup=phpStringDelimiter start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=@Spell,@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpStrEsc contained keepend
"                                                                                                                                                 syn region phpStringSingle matchgroup=phpStringDelimiter start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@Spell,@phpAddStrings,phpStrEsc contained keepend
"                                                                                                                                                 else
"                                                                                                                                                   syn region phpStringDouble matchgroup=phpStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=@Spell,@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpStrEsc contained extend keepend
"                                                                                                                                                     syn region phpBacktick matchgroup=phpStringDelimiter start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=@Spell,@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex,phpStrEsc contained extend keepend
"                                                                                                                                                       syn region phpStringSingle matchgroup=phpStringDelimiter start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@Spell,@phpAddStrings,phpStrEsc contained keepend extend
"                                                                                                                                                       endif
"
"                                                                                                                                                       " HereDoc
"                                                                                                                                                       syn case match
"
"                                                                                                                                                       SynFold syn region phpHereDoc matchgroup=Delimiter start="\(<<<\)\@<=\z(\I\i*\)$" end="^\z1\(;\=$\)\@=" contained contains=@Spell,phpIdentifier,phpIdentifierSimply,phpIdentifierComplex,phpSpecialChar,phpMethodsVar,phpStrEsc keepend extend
"                                                                                                                                                       SynFold syn region phpHereDoc matchgroup=Delimiter start=+\(<<<\)\@<="\z(\I\i*\)"$+ end="^\z1\(;\=$\)\@=" contained contains=@Spell,phpIdentifier,phpIdentifierSimply,phpIdentifierComplex,phpSpecialChar,phpMethodsVar,phpStrEsc keepend extend
"                                                                                                                                                       " including HTML,JavaScript,SQL if enabled via options
"                                                                                                                                                       if (exists("php_html_in_heredoc") && php_html_in_heredoc)
"                                                                                                                                                         SynFold syn region phpHereDoc matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(html\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@="  contained contains=@htmlTop,phpIdentifier,phpIdentifierSimply,phpIdentifierComplex,phpSpecialChar,phpMethodsVar,phpStrEsc keepend extend
"                                                                                                                                                           SynFold syn region phpHereDoc matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(javascript\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@="  contained contains=@htmlJavascript,phpIdentifierSimply,phpIdentifier,phpIdentifierComplex,phpSpecialChar,phpMethodsVar,phpStrEsc keepend extend
"                                                                                                                                                           endif
"                                                                                                                                                           if (exists("php_sql_heredoc") && php_sql_heredoc)
"                                                                                                                                                             SynFold syn region phpHereDoc matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(sql\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@=" contained contains=@sqlTop,phpIdentifier,phpIdentifierSimply,phpIdentifierComplex,phpSpecialChar,phpMethodsVar,phpStrEsc keepend extend
"                                                                                                                                                             endif
"
"                                                                                                                                                             " NowDoc
"                                                                                                                                                             SynFold syn region phpNowDoc matchgroup=Delimiter start=+\(<<<\)\@<='\z(\I\i*\)'$+ end="^\z1\(;\=$\)\@=" contained keepend extend
"
"                                                                                                                                                             syn case ignore
"
"                                                                                                                                                             " Parent
"                                                                                                                                                             if (exists("php_parent_error_close") && php_parent_error_close) || (exists("php_parent_error_open") && php_parent_error_open)
"                                                                                                                                                               syn match  phpParent "[{}]"  contained
"                                                                                                                                                                 syn region phpParent matchgroup=Delimiter start="(" end=")"  contained contains=@phpClFunction,@phpClControl transparent
"                                                                                                                                                                   syn region phpParent matchgroup=Delimiter start="\[" end="\]"  contained contains=@phpClFunction,@phpClControl transparent
"                                                                                                                                                                     if ! (exists("php_parent_error_close") && php_parent_error_close)
"                                                                                                                                                                         syn match phpParent "[\])]" contained
"                                                                                                                                                                           endif
"                                                                                                                                                                           else
"                                                                                                                                                                             syn match phpParent "[({[\]})]" contained
"                                                                                                                                                                             endif
"
"                                                                                                                                                                             " Static classes
"                                                                                                                                                                             syn match phpStaticClasses "\v\h\w+(::)@=" contained display
"
"                                                                                                                                                                             " Class name
"                                                                                                                                                                             syn keyword phpKeyword class contained
"                                                                                                                                                                                   \ nextgroup=phpClass skipwhite skipempty
"                                                                                                                                                                                   syn match phpClass /\h\w*/
"
"                                                                                                                                                                                   " Class extends
"                                                                                                                                                                                   syn keyword phpKeyword extends contained
"                                                                                                                                                                                         \ nextgroup=phpClassExtends skipwhite skipempty
"                                                                                                                                                                                         syn match phpClassExtends /\(\\\|\h\w*\)*\h\w*/
"
"                                                                                                                                                                                         " Class implements
"                                                                                                                                                                                         syntax keyword phpKeyword implements contained
"                                                                                                                                                                                               \ nextgroup=phpClassImplements skipwhite skipempty
"                                                                                                                                                                                               syntax match phpClassImplements contained
"                                                                                                                                                                                                     \ nextgroup=phpClassDelimiter skipwhite skipempty /\(\\\|\h\w*\)*\h\w*/
"                                                                                                                                                                                                     syntax match phpClassDelimiter contained
"                                                                                                                                                                                                           \ nextgroup=phpClassImplements skipwhite skipempty /,/
"
"                                                                                                                                                                                                           " Function name
"                                                                                                                                                                                                           syn keyword phpKeyword function contained
"                                                                                                                                                                                                                 \ nextgroup=phpFunction skipwhite skipempty
"                                                                                                                                                                                                                 syn match phpFunction /\h\w*/
"
"                                                                                                                                                                                                                 " Clusters
"                                                                                                                                                                                                                 syn cluster phpClConst contains=phpFunctions,phpClasses,phpStaticClasses,phpIdentifier,phpStatement,phpKeyword,phpOperator,phpSplatOperator,phpStringSingle,phpStringDouble,phpBacktick,phpNumber,phpType,phpBoolean,phpStructure,phpMethodsVar,phpConstants,phpException,phpSuperglobals,phpMagicConstants,phpServerVars
"                                                                                                                                                                                                                 syn cluster phpClInside contains=@phpClConst,phpComment,phpDocComment,phpParent,phpParentError,phpInclude,phpHereDoc,phpNowDoc
"                                                                                                                                                                                                                 syn cluster phpClFunction contains=@phpClInside,phpDefine,phpParentError,phpStorageClass,phpKeyword
"                                                                                                                                                                                                                 syn cluster phpClControl contains=phpFoldIfContainer,phpFoldWhile,phpFoldDoWhile,phpFoldFor,phpFoldForeach,phpFoldTryContainer,phpFoldSwitch
"                                                                                                                                                                                                                 syn cluster phpClTop contains=@phpClFunction,@phpClControl,phpFoldFunction,phpFoldClass,phpFoldInterface,phpFoldHtmlInside
"
"                                                                                                                                                                                                                 " Php Region
"                                                                                                                                                                                                                 if (exists("php_parent_error_open") && php_parent_error_open)
"                                                                                                                                                                                                                   syn region phpRegion matchgroup=Delimiter start="<?\(php\)\=" end="?>" contains=@phpClTop
"                                                                                                                                                                                                                   else
"                                                                                                                                                                                                                     syn region phpRegion matchgroup=Delimiter start="<?\(php\)\=" end="?>" contains=@phpClTop keepend
"                                                                                                                                                                                                                     endif
"
"                                                                                                                                                                                                                     " Fold
"                                                                                                                                                                                                                     if php_folding==1
"                                                                                                                                                                                                                       " match one line constructs here and skip them at folding
"                                                                                                                                                                                                                         syn keyword phpSCKeyword  abstract final private protected public static  contained
"                                                                                                                                                                                                                           syn keyword phpFCKeyword  function  contained
"                                                                                                                                                                                                                             syn match phpDefine "\(\s\|^\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\(\s\+.*[;}]\)\@="  contained contains=phpSCKeyword
"                                                                                                                                                                                                                               syn match phpStructure "\(\s\|^\)\(abstract\s\+\|final\s\+\)*class\(\s\+.*}\)\@="  contained
"                                                                                                                                                                                                                                 syn match phpStructure "\(\s\|^\)interface\(\s\+.*}\)\@="  contained
"                                                                                                                                                                                                                                   syn match phpException "\(\s\|^\)try\(\s\+.*}\)\@="  contained
"                                                                                                                                                                                                                                     syn match phpException "\(\s\|^\)catch\(\s\+.*}\)\@="  contained
"                                                                                                                                                                                                                                       syn match phpKeyword "^\s*\(if\|else\%[if]\)\s*\(.*{.*}$\|[^{}]*$\)\@=" contained
"                                                                                                                                                                                                                                         syn match phpKeyword "^\s*while\s*\([^{}]*$\|.*{.*}$\)\@=" contained
"                                                                                                                                                                                                                                           syn match phpKeyword "^\s*do\s*\([^{}]*$\|{.*}\s*while\s*.*;$\)\@=" contained
"                                                                                                                                                                                                                                             syn match phpKeyword "while\s*\((.*);$\)\@=" contained
"                                                                                                                                                                                                                                               syn match phpKeyword "^\s*for\s*\((.*)\s*{.*}$\|[^{}]*$\)\@=" contained
"                                                                                                                                                                                                                                                 syn match phpKeyword "^\s*foreach\s*\((.*)\s*{.*}$\|[^{}]*$\)\@=" contained
"
"                                                                                                                                                                                                                                                   set foldmethod=syntax
"                                                                                                                                                                                                                                                     syn region phpFoldHtmlInside matchgroup=Delimiter start="?>" end="<?\(php\)\=" contained transparent contains=@htmlTop
"                                                                                                                                                                                                                                                       syn region phpFoldFunction matchgroup=Storageclass start="^\z(\s*\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\s\([^};]*$\)\@="rs=e-9 matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,@phpClControl,phpFoldHtmlInside,phpFCKeyword contained transparent fold extend
"                                                                                                                                                                                                                                                         syn region phpFoldFunction matchgroup=Define start="^function\s\([^};]*$\)\@=" matchgroup=Delimiter end="^}" contains=@phpClFunction,@phpClControl,phpFoldHtmlInside contained transparent fold extend
"                                                                                                                                                                                                                                                           syn region phpFoldClass matchgroup=Structure start="^\z(\s*\)\(abstract\s\+\|final\s\+\)*class\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction,phpSCKeyword contained transparent fold extend
"                                                                                                                                                                                                                                                             syn region phpFoldInterface matchgroup=Structure start="^\z(\s*\)interface\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent fold extend
"
"                                                                                                                                                                                                                                                               syn region phpFoldTryContainer start="^\z(\s*\)try\s\+\(.*{$\)\@=" skip="^\z1}\_s*\(catch\|finally\)" end="^\z1}$" keepend extend contained contains=@phpClFunction,@phpClControl,phpFoldFunction,phpFoldHtmlInside transparent
"                                                                                                                                                                                                                                                                 syn region phpFoldTry matchgroup=phpException start="^\z(\s*\)try\s\+\(.*{$\)\@=" matchgroup=Delimiter end="^\z1}$" end="^\z1}\(\s\+\(catch\|finally\)\)\@="me=s-1 containedin=phpFoldTryContainer contained transparent keepend fold extend nextgroup=phpFoldCatch
"                                                                                                                                                                                                                                                                   syn region phpFoldCatch matchgroup=phpException start="^\z(\s*\)\(}\s\+\)\=catch\s\+\(.*{$\)\@=" matchgroup=Delimiter end="^\z1}$" end="^\z1}\(\s\+\(catch\|finally\)\)\@="me=s-1 containedin=phpFoldTryContainer keepend contained transparent fold extend nextgroup=phpFoldCatch,phpFoldFinally
"                                                                                                                                                                                                                                                                     syn region phpFoldFinally matchgroup=phpException start="^\z(\s*\)\(}\s\+\)\=finally\s\+\(.*{$\)\@=" matchgroup=Delimiter end="^\z1}$" contained containedin=phpFoldTryContainer transparent fold keepend
"
"                                                                                                                                                                                                                                                                       syn region phpFoldIfContainer start="^\z(\s*\)if\s\+\(.*{$\)\@=" skip="^\z1}\_s*else\%[if]" end="^\z1}$" keepend extend contained contains=@phpClFunction,@phpClControl,phpFCKeyword,phpFoldHtmlInside
"                                                                                                                                                                                                                                                                         syn region phpFoldIf matchgroup=phpKeyword start="^\z(\s*\)if\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="\(^\z1\)\@=}\(\_s\+\%[elseif]\s\+[^}]*$\)\@="me=s-1 contained containedin=phpFoldIfContainer keepend nextgroup=phpFoldElseIf,phpFoldElse fold transparent
"                                                                                                                                                                                                                                                                           syn region phpFoldElseIf matchgroup=phpKeyword start="^\z(\s*\)\(}\s\+\)\=elseif\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="\(^\z1\)\@=}\(\s*\%[elseif]\s*[^}]*$\)\@="me=s-1 contained containedin=phpFoldIfContainer keepend nextgroup=phpFoldElseIf,phpFoldElse fold transparent 
"                                                                                                                                                                                                                                                                             syn region phpFoldElse matchgroup=phpKeyword start="^\z(\s*\)\(}\s\+\)\=else\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="\(^\z1\)\@=}\(\s\+\%[elseif]\s\+[^}]*$\)\@="me=s-1 contained containedin=phpFoldIfContainer keepend fold transparent
"
"                                                                                                                                                                                                                                                                               syn region phpFoldSwitch matchgroup=phpKeyword start="^\z(\s*\)switch\s*\(.*{$\)\@=" matchgroup=Delimiter end="^\z1}$" keepend extend contained contains=@phpClFunction,@phpClControl,phpFCKeyword,phpFoldHtmlInside fold transparent
"                                                                                                                                                                                                                                                                                 syn region phpFoldCase matchgroup=phpKeyword start="^\z(\s*\)case\s*\(.*:$\)\@=" end="^\z1\(case\|default\)"me=s-1 contained containedin=phpFoldSwitch keepend contains=@phpClFunction,@phpClControl,phpFCKeyword,phpFoldHtmlInside nextgroup=phpFoldCase,phpFoldDefault fold transparent
"                                                                                                                                                                                                                                                                                   syn region phpFoldDefault matchgroup=phpKeyword start="^\z(\s*\)default\(:$\)\@=" matchgroup=Delimiter end="\s*}$" contained contains=@phpClFunction,@phpClControl,phpFCKeyword,phpFoldHtmlInside containedin=phpFoldSwitch keepend fold transparent
"
"                                                                                                                                                                                                                                                                                     syn region phpFoldWhile matchgroup=phpKeyword start="^\z(\s*\)while\s\+\(.*{$\)\@=" matchgroup=Delimiter end="^\z1}$" contains=@phpClFunction,@phpClControl,phpFoldHtmlInside contained fold extend
"                                                                                                                                                                                                                                                                                       syn region phpFoldDoWhile matchgroup=phpkeyword start="^\z(\s*\)do\s\+\({$\)\@=" matchgroup=Delimiter end="\z1}\s\+\(while\s\+.*;$\)\@=" contains=@phpClFunction,@phpClControl,phpFoldHtmlInside contained fold extend keepend
"
"                                                                                                                                                                                                                                                                                         syn region phpFoldFor matchgroup=phpKeyword start="^\z(\s*\)for\s\(.*{$\)\@=" matchgroup=Delimiter end="\z1}$" contains=@phpClFunction,@phpClControl,phpFCKeyword,phpFoldHtmlInside contained transparent fold extend
"                                                                                                                                                                                                                                                                                           syn region phpFoldForeach matchgroup=phpKeyword start="^\z(\s*\)foreach\s\(.*{$\)\@=" matchgroup=Delimiter end="\z1}$" contains=@phpClFunction,@phpClControl,phpFCKeyword,phpFoldHtmlInside contained transparent fold extend
"
"                                                                                                                                                                                                                                                                                           elseif php_folding==2
"                                                                                                                                                                                                                                                                                             set foldmethod=syntax
"                                                                                                                                                                                                                                                                                               syn region phpFoldHtmlInside matchgroup=Delimiter start="?>" end="<?\(php\)\=" contained transparent contains=@htmlTop
"                                                                                                                                                                                                                                                                                                 syn region phpParent matchgroup=Delimiter start="{" end="}"  contained contains=@phpClFunction,phpFoldHtmlInside transparent fold
"                                                                                                                                                                                                                                                                                                   syn region phpParent matchgroup=Delimiter start="(" end=")"  contained contains=@phpClFunction,phpFoldHtmlInside transparent fold
"                                                                                                                                                                                                                                                                                                     syn region phpParent matchgroup=Delimiter start="\[" end="]"  contained contains=@phpClFunction,phpFoldHtmlInside transparent fold
"                                                                                                                                                                                                                                                                                                     endif
"
"                                                                                                                                                                                                                                                                                                     " Sync
"                                                                                                                                                                                                                                                                                                     if php_sync_method==-1
"                                                                                                                                                                                                                                                                                                       syn sync match phpRegionSync grouphere phpRegion "^\s*<?\(php\)\=\s*$"
"                                                                                                                                                                                                                                                                                                         syn sync match phpRegionSync grouphere NONE "^\s*?>\s*$"
"                                                                                                                                                                                                                                                                                                           syn sync match phpRegionSync grouphere NONE "^\s*%>\s*$"
"                                                                                                                                                                                                                                                                                                             syn sync match phpRegionSync grouphere phpRegion "function\s.*(.*\$"
"                                                                                                                                                                                                                                                                                                             elseif php_sync_method>0
"                                                                                                                                                                                                                                                                                                               exec
"                                                                                                                                                                                                                                                                                                               "syn
"                                                                                                                                                                                                                                                                                                               sync
"                                                                                                                                                                                                                                                                                                               minlines="
"                                                                                                                                                                                                                                                                                                               .
"                                                                                                                                                                                                                                                                                                               php_sync_method
"                                                                                                                                                                                                                                                                                                               else
"                                                                                                                                                                                                                                                                                                                 exec
"                                                                                                                                                                                                                                                                                                                 "syn
"                                                                                                                                                                                                                                                                                                                 sync
"                                                                                                                                                                                                                                                                                                                 fromstart"
"                                                                                                                                                                                                                                                                                                                 endif
"
"                                                                                                                                                                                                                                                                                                                 "
"                                                                                                                                                                                                                                                                                                                 Define
"                                                                                                                                                                                                                                                                                                                 the
"                                                                                                                                                                                                                                                                                                                 default
"                                                                                                                                                                                                                                                                                                                 highlighting.
"                                                                                                                                                                                                                                                                                                                 "
"                                                                                                                                                                                                                                                                                                                 For
"                                                                                                                                                                                                                                                                                                                 version
"                                                                                                                                                                                                                                                                                                                 5.8
"                                                                                                                                                                                                                                                                                                                 and
"                                                                                                                                                                                                                                                                                                                 later:
"                                                                                                                                                                                                                                                                                                                 only
"                                                                                                                                                                                                                                                                                                                 when
"                                                                                                                                                                                                                                                                                                                 an
"                                                                                                                                                                                                                                                                                                                 item
"                                                                                                                                                                                                                                                                                                                 doesn't
"                                                                                                                                                                                                                                                                                                                 have
"                                                                                                                                                                                                                                                                                                                 highlighting
"                                                                                                                                                                                                                                                                                                                 yet
"                                                                                                                                                                                                                                                                                                                 if
"                                                                                                                                                                                                                                                                                                                 !exists("did_php_syn_inits")
"
"                                                                                                                                                                                                                                                                                                                   hi
"                                                                                                                                                                                                                                                                                                                   def
"                                                                                                                                                                                                                                                                                                                   link
"                                                                                                                                                                                                                                                                                                                   phpComment
"                                                                                                                                                                                                                                                                                                                   Comment
"                                                                                                                                                                                                                                                                                                                     hi
"                                                                                                                                                                                                                                                                                                                     def
"                                                                                                                                                                                                                                                                                                                     link
"                                                                                                                                                                                                                                                                                                                     phpMagicConstants
"                                                                                                                                                                                                                                                                                                                     Constant
"                                                                                                                                                                                                                                                                                                                       hi
"                                                                                                                                                                                                                                                                                                                       def
"                                                                                                                                                                                                                                                                                                                       link
"                                                                                                                                                                                                                                                                                                                       phpServerVars
"                                                                                                                                                                                                                                                                                                                       Constant
"                                                                                                                                                                                                                                                                                                                         hi
"                                                                                                                                                                                                                                                                                                                         def
"                                                                                                                                                                                                                                                                                                                         link
"                                                                                                                                                                                                                                                                                                                         phpConstants
"                                                                                                                                                                                                                                                                                                                         Constant
"                                                                                                                                                                                                                                                                                                                           hi
"                                                                                                                                                                                                                                                                                                                           def
"                                                                                                                                                                                                                                                                                                                           link
"                                                                                                                                                                                                                                                                                                                           phpBoolean
"                                                                                                                                                                                                                                                                                                                           Boolean
"                                                                                                                                                                                                                                                                                                                             hi
"                                                                                                                                                                                                                                                                                                                             def
"                                                                                                                                                                                                                                                                                                                             link
"                                                                                                                                                                                                                                                                                                                             phpNumber
"                                                                                                                                                                                                                                                                                                                             Number
"                                                                                                                                                                                                                                                                                                                               hi
"                                                                                                                                                                                                                                                                                                                               def
"                                                                                                                                                                                                                                                                                                                               link
"                                                                                                                                                                                                                                                                                                                               phpStringSingle
"                                                                                                                                                                                                                                                                                                                               String
"                                                                                                                                                                                                                                                                                                                                 hi
"                                                                                                                                                                                                                                                                                                                                 def
"                                                                                                                                                                                                                                                                                                                                 link
"                                                                                                                                                                                                                                                                                                                                 phpStringDouble
"                                                                                                                                                                                                                                                                                                                                 String
"                                                                                                                                                                                                                                                                                                                                   hi
"                                                                                                                                                                                                                                                                                                                                   def
"                                                                                                                                                                                                                                                                                                                                   link
"                                                                                                                                                                                                                                                                                                                                   phpBacktick
"                                                                                                                                                                                                                                                                                                                                   String
"                                                                                                                                                                                                                                                                                                                                     hi
"                                                                                                                                                                                                                                                                                                                                     def
"                                                                                                                                                                                                                                                                                                                                     link
"                                                                                                                                                                                                                                                                                                                                     phpStringDelimiter
"                                                                                                                                                                                                                                                                                                                                     String
"                                                                                                                                                                                                                                                                                                                                       hi
"                                                                                                                                                                                                                                                                                                                                       def
"                                                                                                                                                                                                                                                                                                                                       link
"                                                                                                                                                                                                                                                                                                                                       phpHereDoc
"                                                                                                                                                                                                                                                                                                                                       String
"                                                                                                                                                                                                                                                                                                                                         hi
"                                                                                                                                                                                                                                                                                                                                         def
"                                                                                                                                                                                                                                                                                                                                         link
"                                                                                                                                                                                                                                                                                                                                         phpNowDoc
"                                                                                                                                                                                                                                                                                                                                         String
"                                                                                                                                                                                                                                                                                                                                           hi
"                                                                                                                                                                                                                                                                                                                                           def
"                                                                                                                                                                                                                                                                                                                                           link
"                                                                                                                                                                                                                                                                                                                                           phpFunctions
"                                                                                                                                                                                                                                                                                                                                           Function
"                                                                                                                                                                                                                                                                                                                                             hi
"                                                                                                                                                                                                                                                                                                                                             def
"                                                                                                                                                                                                                                                                                                                                             link
"                                                                                                                                                                                                                                                                                                                                             phpMethods
"                                                                                                                                                                                                                                                                                                                                             Function
"                                                                                                                                                                                                                                                                                                                                               hi
"                                                                                                                                                                                                                                                                                                                                               def
"                                                                                                                                                                                                                                                                                                                                               link
"                                                                                                                                                                                                                                                                                                                                               phpClasses
"                                                                                                                                                                                                                                                                                                                                               StorageClass
"                                                                                                                                                                                                                                                                                                                                                 hi
"                                                                                                                                                                                                                                                                                                                                                 def
"                                                                                                                                                                                                                                                                                                                                                 link
"                                                                                                                                                                                                                                                                                                                                                 phpException
"                                                                                                                                                                                                                                                                                                                                                 Exception
"                                                                                                                                                                                                                                                                                                                                                   hi
"                                                                                                                                                                                                                                                                                                                                                   def
"                                                                                                                                                                                                                                                                                                                                                   link
"                                                                                                                                                                                                                                                                                                                                                   phpIdentifier
"                                                                                                                                                                                                                                                                                                                                                   Identifier
"                                                                                                                                                                                                                                                                                                                                                     hi
"                                                                                                                                                                                                                                                                                                                                                     def
"                                                                                                                                                                                                                                                                                                                                                     link
"                                                                                                                                                                                                                                                                                                                                                     phpIdentifierSimply
"                                                                                                                                                                                                                                                                                                                                                     Identifier
"                                                                                                                                                                                                                                                                                                                                                       hi
"                                                                                                                                                                                                                                                                                                                                                       def
"                                                                                                                                                                                                                                                                                                                                                       link
"                                                                                                                                                                                                                                                                                                                                                       phpStatement
"                                                                                                                                                                                                                                                                                                                                                       Statement
"                                                                                                                                                                                                                                                                                                                                                         hi
"                                                                                                                                                                                                                                                                                                                                                         def
"                                                                                                                                                                                                                                                                                                                                                         link
"                                                                                                                                                                                                                                                                                                                                                         phpStructure
"                                                                                                                                                                                                                                                                                                                                                         Statement
"                                                                                                                                                                                                                                                                                                                                                           hi
"                                                                                                                                                                                                                                                                                                                                                           def
"                                                                                                                                                                                                                                                                                                                                                           link
"                                                                                                                                                                                                                                                                                                                                                           phpOperator
"                                                                                                                                                                                                                                                                                                                                                           Operator
"                                                                                                                                                                                                                                                                                                                                                             hi
"                                                                                                                                                                                                                                                                                                                                                             def
"                                                                                                                                                                                                                                                                                                                                                             link
"                                                                                                                                                                                                                                                                                                                                                             phpMemberSelector
"                                                                                                                                                                                                                                                                                                                                                             Operator
"                                                                                                                                                                                                                                                                                                                                                               hi
"                                                                                                                                                                                                                                                                                                                                                               def
"                                                                                                                                                                                                                                                                                                                                                               link
"                                                                                                                                                                                                                                                                                                                                                               phpInclude
"                                                                                                                                                                                                                                                                                                                                                               PreProc
"                                                                                                                                                                                                                                                                                                                                                                 hi
"                                                                                                                                                                                                                                                                                                                                                                 def
"                                                                                                                                                                                                                                                                                                                                                                 link
"                                                                                                                                                                                                                                                                                                                                                                 phpDefine
"                                                                                                                                                                                                                                                                                                                                                                 PreProc
"                                                                                                                                                                                                                                                                                                                                                                   hi
"                                                                                                                                                                                                                                                                                                                                                                   def
"                                                                                                                                                                                                                                                                                                                                                                   link
"                                                                                                                                                                                                                                                                                                                                                                   phpKeyword
"                                                                                                                                                                                                                                                                                                                                                                   Keyword
"                                                                                                                                                                                                                                                                                                                                                                     hi
"                                                                                                                                                                                                                                                                                                                                                                     def
"                                                                                                                                                                                                                                                                                                                                                                     link
"                                                                                                                                                                                                                                                                                                                                                                     phpSuperglobals
"                                                                                                                                                                                                                                                                                                                                                                     Type
"                                                                                                                                                                                                                                                                                                                                                                       hi
"                                                                                                                                                                                                                                                                                                                                                                       def
"                                                                                                                                                                                                                                                                                                                                                                       link
"                                                                                                                                                                                                                                                                                                                                                                       phpType
"                                                                                                                                                                                                                                                                                                                                                                       Type
"                                                                                                                                                                                                                                                                                                                                                                         hi
"                                                                                                                                                                                                                                                                                                                                                                         def
"                                                                                                                                                                                                                                                                                                                                                                         link
"                                                                                                                                                                                                                                                                                                                                                                         phpParent
"                                                                                                                                                                                                                                                                                                                                                                         Special
"                                                                                                                                                                                                                                                                                                                                                                           hi
"                                                                                                                                                                                                                                                                                                                                                                           def
"                                                                                                                                                                                                                                                                                                                                                                           link
"                                                                                                                                                                                                                                                                                                                                                                           phpSpecialChar
"                                                                                                                                                                                                                                                                                                                                                                           SpecialChar
"                                                                                                                                                                                                                                                                                                                                                                             hi
"                                                                                                                                                                                                                                                                                                                                                                             def
"                                                                                                                                                                                                                                                                                                                                                                             link
"                                                                                                                                                                                                                                                                                                                                                                             phpStrEsc
"                                                                                                                                                                                                                                                                                                                                                                             SpecialChar
"                                                                                                                                                                                                                                                                                                                                                                               hi
"                                                                                                                                                                                                                                                                                                                                                                               def
"                                                                                                                                                                                                                                                                                                                                                                               link
"                                                                                                                                                                                                                                                                                                                                                                               phpParentError
"                                                                                                                                                                                                                                                                                                                                                                               Error
"                                                                                                                                                                                                                                                                                                                                                                                 hi
"                                                                                                                                                                                                                                                                                                                                                                                 def
"                                                                                                                                                                                                                                                                                                                                                                                 link
"                                                                                                                                                                                                                                                                                                                                                                                 phpOctalError
"                                                                                                                                                                                                                                                                                                                                                                                 Error
"                                                                                                                                                                                                                                                                                                                                                                                   hi
"                                                                                                                                                                                                                                                                                                                                                                                   def
"                                                                                                                                                                                                                                                                                                                                                                                   link
"                                                                                                                                                                                                                                                                                                                                                                                   phpTodo
"                                                                                                                                                                                                                                                                                                                                                                                   Todo
"
"                                                                                                                                                                                                                                                                                                                                                                                     hi
"                                                                                                                                                                                                                                                                                                                                                                                     def
"                                                                                                                                                                                                                                                                                                                                                                                     link
"                                                                                                                                                                                                                                                                                                                                                                                     phpSplatOperator
"                                                                                                                                                                                                                                                                                                                                                                                     phpOperator
"
"                                                                                                                                                                                                                                                                                                                                                                                       hi
"                                                                                                                                                                                                                                                                                                                                                                                       def
"                                                                                                                                                                                                                                                                                                                                                                                       link
"                                                                                                                                                                                                                                                                                                                                                                                       phpCommentStar
"                                                                                                                                                                                                                                                                                                                                                                                       phpComment
"                                                                                                                                                                                                                                                                                                                                                                                         hi
"                                                                                                                                                                                                                                                                                                                                                                                         def
"                                                                                                                                                                                                                                                                                                                                                                                         link
"                                                                                                                                                                                                                                                                                                                                                                                         phpDocComment
"                                                                                                                                                                                                                                                                                                                                                                                         phpComment
"                                                                                                                                                                                                                                                                                                                                                                                           hi
"                                                                                                                                                                                                                                                                                                                                                                                           def
"                                                                                                                                                                                                                                                                                                                                                                                           link
"                                                                                                                                                                                                                                                                                                                                                                                           phpCommentTitle
"                                                                                                                                                                                                                                                                                                                                                                                           phpComment
"                                                                                                                                                                                                                                                                                                                                                                                             hi
"                                                                                                                                                                                                                                                                                                                                                                                             def
"                                                                                                                                                                                                                                                                                                                                                                                             link
"                                                                                                                                                                                                                                                                                                                                                                                             phpDocTags
"                                                                                                                                                                                                                                                                                                                                                                                             phpComment
"                                                                                                                                                                                                                                                                                                                                                                                               hi
"                                                                                                                                                                                                                                                                                                                                                                                               def
"                                                                                                                                                                                                                                                                                                                                                                                               link
"                                                                                                                                                                                                                                                                                                                                                                                               phpDocParam
"                                                                                                                                                                                                                                                                                                                                                                                               phpComment
"                                                                                                                                                                                                                                                                                                                                                                                                 hi
"                                                                                                                                                                                                                                                                                                                                                                                                 def
"                                                                                                                                                                                                                                                                                                                                                                                                 link
"                                                                                                                                                                                                                                                                                                                                                                                                 phpDocIdentifier
"                                                                                                                                                                                                                                                                                                                                                                                                 phpComment
"
"                                                                                                                                                                                                                                                                                                                                                                                                   hi
"                                                                                                                                                                                                                                                                                                                                                                                                   def
"                                                                                                                                                                                                                                                                                                                                                                                                   link
"                                                                                                                                                                                                                                                                                                                                                                                                   phpFCKeyword
"                                                                                                                                                                                                                                                                                                                                                                                                   phpKeyword
"                                                                                                                                                                                                                                                                                                                                                                                                     hi
"                                                                                                                                                                                                                                                                                                                                                                                                     def
"                                                                                                                                                                                                                                                                                                                                                                                                     link
"                                                                                                                                                                                                                                                                                                                                                                                                     phpSCKeyword
"                                                                                                                                                                                                                                                                                                                                                                                                     phpKeyword
"
"                                                                                                                                                                                                                                                                                                                                                                                                       hi
"                                                                                                                                                                                                                                                                                                                                                                                                       def
"                                                                                                                                                                                                                                                                                                                                                                                                       link
"                                                                                                                                                                                                                                                                                                                                                                                                       phpStaticClasses
"                                                                                                                                                                                                                                                                                                                                                                                                       phpClasses
"
"                                                                                                                                                                                                                                                                                                                                                                                                         if
"                                                                                                                                                                                                                                                                                                                                                                                                         (exists("php_var_selector_is_identifier")
"                                                                                                                                                                                                                                                                                                                                                                                                         &&
"                                                                                                                                                                                                                                                                                                                                                                                                         php_var_selector_is_identifier)
"                                                                                                                                                                                                                                                                                                                                                                                                             hi
"                                                                                                                                                                                                                                                                                                                                                                                                             def
"                                                                                                                                                                                                                                                                                                                                                                                                             link
"                                                                                                                                                                                                                                                                                                                                                                                                             phpVarSelector
"                                                                                                                                                                                                                                                                                                                                                                                                             phpIdentifier
"                                                                                                                                                                                                                                                                                                                                                                                                               else
"                                                                                                                                                                                                                                                                                                                                                                                                                   hi
"                                                                                                                                                                                                                                                                                                                                                                                                                   def
"                                                                                                                                                                                                                                                                                                                                                                                                                   link
"                                                                                                                                                                                                                                                                                                                                                                                                                   phpVarSelector
"                                                                                                                                                                                                                                                                                                                                                                                                                   phpOperator
"                                                                                                                                                                                                                                                                                                                                                                                                                     endif
"
"                                                                                                                                                                                                                                                                                                                                                                                                                       hi
"                                                                                                                                                                                                                                                                                                                                                                                                                       def
"                                                                                                                                                                                                                                                                                                                                                                                                                       link
"                                                                                                                                                                                                                                                                                                                                                                                                                       phpFunction
"                                                                                                                                                                                                                                                                                                                                                                                                                       phpRegion
"                                                                                                                                                                                                                                                                                                                                                                                                                         hi
"                                                                                                                                                                                                                                                                                                                                                                                                                         def
"                                                                                                                                                                                                                                                                                                                                                                                                                         link
"                                                                                                                                                                                                                                                                                                                                                                                                                         phpClass
"                                                                                                                                                                                                                                                                                                                                                                                                                         phpRegion
"                                                                                                                                                                                                                                                                                                                                                                                                                           hi
"                                                                                                                                                                                                                                                                                                                                                                                                                           def
"                                                                                                                                                                                                                                                                                                                                                                                                                           link
"                                                                                                                                                                                                                                                                                                                                                                                                                           phpClassExtends
"                                                                                                                                                                                                                                                                                                                                                                                                                           phpClass
"                                                                                                                                                                                                                                                                                                                                                                                                                             hi
"                                                                                                                                                                                                                                                                                                                                                                                                                             def
"                                                                                                                                                                                                                                                                                                                                                                                                                             link
"                                                                                                                                                                                                                                                                                                                                                                                                                             phpClassImplements
"                                                                                                                                                                                                                                                                                                                                                                                                                             phpClass
"                                                                                                                                                                                                                                                                                                                                                                                                                               hi
"                                                                                                                                                                                                                                                                                                                                                                                                                               def
"                                                                                                                                                                                                                                                                                                                                                                                                                               link
"                                                                                                                                                                                                                                                                                                                                                                                                                               phpClassDelimiter
"                                                                                                                                                                                                                                                                                                                                                                                                                               phpRegion
"
"                                                                                                                                                                                                                                                                                                                                                                                                                               endif
"
"                                                                                                                                                                                                                                                                                                                                                                                                                               "
"                                                                                                                                                                                                                                                                                                                                                                                                                               Cleanup:
"                                                                                                                                                                                                                                                                                                                                                                                                                               {{{
"
"                                                                                                                                                                                                                                                                                                                                                                                                                               delcommand
"                                                                                                                                                                                                                                                                                                                                                                                                                               SynFold
"                                                                                                                                                                                                                                                                                                                                                                                                                               delcommand
"                                                                                                                                                                                                                                                                                                                                                                                                                               SynFoldDoc
"                                                                                                                                                                                                                                                                                                                                                                                                                               let
"                                                                                                                                                                                                                                                                                                                                                                                                                               b:current_syntax
"                                                                                                                                                                                                                                                                                                                                                                                                                               =
"                                                                                                                                                                                                                                                                                                                                                                                                                               "php"
"
"                                                                                                                                                                                                                                                                                                                                                                                                                               let
"                                                                                                                                                                                                                                                                                                                                                                                                                               &iskeyword
"                                                                                                                                                                                                                                                                                                                                                                                                                               =
"                                                                                                                                                                                                                                                                                                                                                                                                                               s:iskeyword_save
"                                                                                                                                                                                                                                                                                                                                                                                                                               unlet
"                                                                                                                                                                                                                                                                                                                                                                                                                               s:iskeyword_save
"
"                                                                                                                                                                                                                                                                                                                                                                                                                               if
"                                                                                                                                                                                                                                                                                                                                                                                                                               main_syntax
"                                                                                                                                                                                                                                                                                                                                                                                                                               ==
"                                                                                                                                                                                                                                                                                                                                                                                                                               'php'
"                                                                                                                                                                                                                                                                                                                                                                                                                                 unlet
"                                                                                                                                                                                                                                                                                                                                                                                                                                 main_syntax
"                                                                                                                                                                                                                                                                                                                                                                                                                                 endif
"
"                                                                                                                                                                                                                                                                                                                                                                                                                                 "
"                                                                                                                                                                                                                                                                                                                                                                                                                                 }}}
"
"                                                                                                                                                                                                                                                                                                                                                                                                                                 "
"                                                                                                                                                                                                                                                                                                                                                                                                                                 vim:
"                                                                                                                                                                                                                                                                                                                                                                                                                                 ts=8
"                                                                                                                                                                                                                                                                                                                                                                                                                                 sts=2
"                                                                                                                                                                                                                                                                                                                                                                                                                                 sw=2
"                                                                                                                                                                                                                                                                                                                                                                                                                                 fdm=marker
"                                                                                                                                                                                                                                                                                                                                                                                                                                 expandtab

