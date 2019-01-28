unit iconv;
interface

Type
  Psize_t  = ^size_t;
  iconv_t = pointer;
  size_t = NativeInt;

function libiconv_open(tocode:Pchar; fromcode:Pchar):iconv_t;cdecl;
	external 'libiconv.dll' name 'libiconv_open';
function libiconv(cd:iconv_t; inbuf:PPchar; inbytesleft:Psize_t; outbuf:PPchar; outbytesleft:Psize_t):size_t;cdecl;
	external 'libiconv.dll' name 'libiconv';
function libiconv_close(cd:iconv_t):longint;cdecl;
	external 'libiconv.dll' name 'libiconv_close';

implementation


end.
